create table  Departement (
  depnum int not null,
  depname varchar(100) not null,
  primary key (depnum));

  insert into Departement(depnum,depname)
  values (1, "Accounting"),
         (2, 'Production'),
         (3, "Research"),
         (4, "Education"),
         (5, "Management"),
         (6, "IT");


create table Location(
  locationcode int not null,
  location varchar(100) not null,
  primary key (locationcode));

  insert into Location(locationcode, location)
    values(1385,'Asker'),
          (0192,'Oslo'),
          (0166,'Bæerum');

create table Positions(
  positioncode int not null,
  positionname varchar(100) not null,
  description varchar(100) not null,
  depnum int not null,
  primary key(positioncode),
  foreign key (depnum)
  references Departement (depnum))
  ;

  insert into Positions(positioncode, positionname,description,depnum)
    values(00345,"Manager","Manager", 2),
    (00111,"President","BOSS",1),
    (0456,"Data entry specialist","Data",3),
    (0678,"Professional","Pro",4),
    (00044,"Manager","Manager",2),
    (09644,"Accountant","Math",6);

  create table Employee(
  eid int not null,
  lname varchar(100) not null,
  fname varchar(100) not null,
  address varchar(100)not null,
  phone int not null,
  depnum int not null,
  locationcode int not null,
  positioncode int not null,
  primary key (eid),
  foreign key (depnum) references Departement(depnum),
  foreign key (locationcode)
  references Location(locationcode),
  foreign key (positioncode)
  references Positions (positioncode)
);

insert into Employee(eid,lname,fname,address,phone,depnum,locationcode,positioncode)
values(1,'Henriksen','Ola','Storgata1',00555,5,1385,00345),
      (2, 'Beeblebrox', 'Zaphod', "Oslo", 34561,5,0192,00111),
	    (3, 'Anderson', 'Thomas', "Asker",3455,6,1385,0456),
      (4, 'Leon', 'Reno', "Bæerum", 19087,4,0192,0678),
      (5, 'Durden', 'Tyler', "Byen", 67546,5,1385,00345),
      (6, 'Larsen', 'Hanne',"Sandvika", 345671,1,0192,09644);

create table Course(
  courseid varchar(100)not null,
  coursename varchar(100) not null,
  description varchar(100) null,
  lecturer varchar(100) null,
  locationcode int not null,
  primary key (courseid,coursename),
  foreign key (locationcode)
  references Location (locationcode));

  insert into Course(courseid,coursename,description,lecturer,locationcode)
  values("ASM101","Artisan soap making","How to make soap","Prof.Soap",1385),
        ("AST101","Artisan tea making","How to make tea","Dr.Tea",0166),
        ("SPD100","Spoon bending for beginners","Bending spoon","Dr.S",0192),
        ("BBW100","Building better worlds","Building","prof.B",1385),
        ("BIO330","Alien ecology","Alien Theory","Dr.Ann",0166),
        ("AAM100","Advanced anger management","Anger management","Dr.Ann",1385);

CREATE TABLE Historic_events(
  event INT NOT NULL,PRIMARY KEY (event),
  days varchar(100) NOT NULL,
  elname VARCHAR(100) default " ",
  efname VARCHAR(100) default " ",
  courseID varchar(100) NOT NULL,
  coursename VARCHAR(100) NOT NULL,
  location_code int not null,
  foreign key(location_code) references Location(locationcode),
  FOREIGN KEY (courseID ,coursename)
  REFERENCES Course (courseID , coursename));

insert into Historic_events(event,days,elname,efname,courseID,coursename,location_code)
  values(1,"June 3 2017",'Henriksen','Ola',"ASM101","Artisan soap making",1385),
        (2,"June 3 2017",'Durden', 'Tyler',"ASM101","Artisan soap making",1385),
        (3,"June 3 2017",'Larsen', 'Hanne',"ASM101","Artisan soap making",1385),
        (4,"October 14 2017",'Henriksen','Ola',"AAM100","Advanced anger management",1385),
        (5,"October 14 2017",'Durden', 'Tyler',"AAM100","Advanced anger management",1385),
        (6,"October 14 2017",'Larsen', 'Hanne',"AAM100","Advanced anger management",1385),
        (7,"July 18 2017",'Durden', 'Tyler',"ASM101","Artisan soap making",1385),
        (8,"June 3 2017",'Beeblebrox','Zaphod',"AST101","Artisan tea making",0166),
        (9,"June 3 2017",'Anderson', 'Thomas',"AST101","Artisan tea making",0166),
        (10,"March 22 2017",'Beeblebrox','Zaphod',"SPD100","Spoon bending for beginners",0192),
        (11,"March 22 2017",'Anderson', 'Thomas',"SPD100","Spoon bending for beginners",0192),
        (12,"April 1 2017", 'Anderson', 'Thomas',"SPD100","Spoon bending for beginners",0192),
        (13,"April 8 2017",'Anderson', 'Thomas',"SPD100","Spoon bending for beginners",0192),
        (14,"April 22 2017",'Anderson', 'Thomas',"SPD100","Spoon bending for beginners",0192),
        (15,"January 2 2017",'Henriksen','Ola',"ASM101","Artisan soap making",1385);

insert into Historic_events(event,days,courseID,coursename,location_code)
values(16,"January 1 2017","BBW100","Building better worlds",1385),
      (17,"December 12 2017","BBW100","Building better worlds",1385),
      (18,"February 11 2017","BIO330","Alien ecology",0166);



SELECT days,coursename FROM historic_events;
SELECT elname,efname,coursename FROM Historic_events;
SELECT depname,e.eid
FROM Departement d, Employee e
WHERE d.depnum = e.eid
HAVING e.eid > 2;
