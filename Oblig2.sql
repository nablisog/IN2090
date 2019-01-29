--A
select timelistenr
from Timelistelinje
where timelistenr=3;

--B
select count (timelistenr)
from Timeliste;

--C
select count(status) as antall
from Timeliste
where status != 'utbetalt';

--D
select count(timelistenr), status
from Timeliste
group by status;

--E
select count(f) as antall, count(pause) as antallmedpause
from Timelistelinje f;

--F
select  count(f) as antall
from Timelistelinje f
where pause is null;


--3a
select sum(a.timeantall)
from Timeliste t,Timeantall a
where t.status!='utbetalt'
and a.timelistenr=t.timelistenr;

--3b
select distinct(timelistenr),beskrivelse
from Timeliste
where beskrivelse like '%test%' or
beskrivelse like '%Test%';

--3c
select t.timelistenr,t.linjenr,t.beskrivelse,v.varighet
from Timelistelinje t, Varighet v
where t.timelistenr=v.timelistenr
and t.linjenr=v.linjenr
order by v.varighet desc
limit 5;

--3d
select t.timelistenr, count(t.linjenr)
from Timelistelinje t full outer join Timeliste v
on v.timelistenr=t.timelistenr
group by t.timelistenr
order by t.timelistenr;

--3e
select sum(timeantall*200)
from Timeliste t,Timeantall a
where t.status='utbetalt'
and a.timelistenr=t.timelistenr;
