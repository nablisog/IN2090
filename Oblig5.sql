--1

select f.filmcharacter, count(*) from  filmcharacter f
group by f.filmcharacter
having count(*) > 2000
order by f.filmcharacter desc;

--2

select title, prodyear
from film f
  natural join filmparticipation l
  natural join person p
where l.parttype ='director'
and firstname='Stanley'
and lastname='Kubrick';

select title, prodyear
from film f
  inner join filmparticipation l on f.filmid = l.filmid
  inner join person p on p.personid=l.personid
where l.parttype ='director' and p.firstname='Stanley' and  p.lastname='Kubrick';

select title, prodyear
from film f, filmparticipation l, person p
where f.filmid=l.filmid and p.personid=l.personid
and l.parttype ='director' and p.firstname='Stanley'
and  p.lastname='Kubrick';

--3

select personid, firstname||' '|| lastname as name, title, country
from filmparticipation
natural join person
natural join film
natural join filmcharacter
natural join filmcountry
where firstname = 'Ingrid' and filmcharacter = 'Ingrid';

--4

select film.filmid, film.title, count(filmgenre.genre)
from film
	left join filmgenre on film.filmid = filmgenre.filmid
  where film.title like '%Antoine %'
group by film.filmid, film.title;

--5

select title, parttype, count(parttype)
from film
natural join filmparticipation
natural join filmitem
where filmtype like 'C' and
title like '%Lord of the Rings%'
group by title,parttype;

--6

with year as (
  select prodyear, count(*) as antall
  from film
  group by prodyear
)
select prodyear
from year
where antall = (select min(antall) from year);

--7

select title,prodyear
from film f
inner join filmgenre f1 on f.filmid=f1.filmid
inner join filmgenre f2 on f1.filmid=f2.filmid
where f1.genre like 'Film-Noir'
and f2.genre like 'Comedy';

--8

(with year as (
  select prodyear, count(*) as antall
  from film
  group by prodyear
)
select prodyear
from year
where antall = (select min(antall) from year))

union all

(select prodyear
from film f
inner join filmgenre f1 on f.filmid=f1.filmid
inner join filmgenre f2 on f1.filmid=f2.filmid
where f1.genre like 'Film-Noir'
and f2.genre like 'Comedy');
		

--9
(select title, prodyear
from film f
  inner join filmparticipation l on f.filmid = l.filmid
  inner join person p on p.personid=l.personid
where l.parttype ='cast'
and p.firstname='Stanley'
and  p.lastname='Kubrick')

intersect all

(select title, prodyear
from film f
  inner join filmparticipation l on f.filmid = l.filmid
  inner join person p on p.personid=l.personid
where l.parttype ='director'
and p.firstname='Stanley'
and  p.lastname='Kubrick');
		

--10
		
select maintitle, votes, rank
from series s
inner join filmrating f
on s.seriesid=f.filmid
where f.votes >1000 and  f.rank = (
  select max(rank)
  from filmrating
  where votes > 1000
);
		
--11
		
select country,count(*)
from filmcountry
group by country
having count(*) < 2;
		

--12
with you as (select * from (
select f.filmcharacter, count(*)
from filmcharacter f group by f.filmcharacter having count(*)< 2)
as unik,filmcharacter as ff
where unik.filmcharacter=ff.filmcharacter)
select firstname, lastname, count(*)
from person natural join filmparticipation
natural join you group by firstname,lastname
having count(*)>199;
		
--13
		
select (firstname || ' ' || lastname) as name
from film
natural join person
natural join filmparticipation
natural join filmrating
where parttype like 'director'
and votes > 60000 and rank > 8
group by name;
