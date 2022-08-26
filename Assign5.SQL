/*Named PL/SQL Block: PL/SQL Stored Procedure and Stored Function.
Write a Stored Procedure namely proc_Grade for the categorization of student.
If marks scored by students in examination is <=1500 and marks >=990 then
student will be placed in distinction category if marks scored are between 
989 and900 category is first class, if marks 899 and 825 category is Higher
Second Class.
Write a PL/SQL block to use procedure created with above requirement.
Stud_Marks (name, total_marks)
Result (Roll, Name, Class)
*/


create table Stud_Marks(name varchar(20), total_marks int);

create table result(rollno int primary key, name varchar(20), class varchar(20));

DESC Stud_Marks;
DESC result;

insert into Stud_Marks values ('Yashpal',1410);

insert into Stud_Marks values ('Kalash',907);

insert into Stud_Marks values ('Utkarsh',864);

insert into Stud_Marks values ('Omkar',1015);

insert into Stud_Marks values ('Dhruv',953);

insert into Stud_Marks values ('Mahavir',837);

select * from Stud_Marks;

delimiter //

create function setclass (marks int)
returns varchar(30)
deterministic
BEGIN
declare grade varchar(30);
IF (marks>=990 and marks<=1500) THEN
set grade = 'Distinction Class';
ELSEIF (marks>=900 and marks<=989) THEN
set grade = 'First Class';
ELSEIF (marks>=825 and marks<=899) THEN
set grade = 'Higher Second Class';
ELSE
set grade = '-----------';
END IF;
return grade;
END;//

create procedure insresult(in rollno int, in name varchar(20))
BEGIN

declare smarks int;
declare grade varchar(30);
declare stud_name varchar(20);
IF (name IN (select Stud_Marks.name from Stud_Marks)) THEN
select Stud_Marks.total_marks into smarks from Stud_marks where Stud_Marks.name = name;
select name into stud_name;
select setclass(smarks) into grade;
insert into result values(rollno,stud_name,grade);
ELSE
select 'Name Not Found' as Exception;
END IF;
END;//

delimiter ;

call insresult(1,'Yashpal');

call insresult(2,'Kalash');

select * from result;
