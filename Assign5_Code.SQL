create table Stud_Marks(name varchar(40), 
total_marks int);

create table result(rollno int primary key,
name varchar(40), class varchar(40));

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
returns varchar(40)
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
declare grade varchar(40);
declare stud_name varchar(40);
select Stud_Marks.total_marks into smarks from Stud_marks where Stud_Marks.name = name;
select name into stud_name;
select setclass(smarks) into grade;
insert into result values(rollno,stud_name,grade);
END;//


create procedure proc_Grade()
begin
declare finished integer default 0;
declare rno integer default (select count(*) from result);
declare sname varchar(40) default ""; 
declare totmarks int default 0;

declare stud_cursor CURSOR FOR SELECT * FROM Stud_Marks;

DECLARE CONTINUE HANDLER FOR NOT FOUND
BEGIN
	SET finished = 1;
END;

OPEN stud_cursor;
L: LOOP

FETCH stud_cursor into sname,totmarks;

IF (finished = 1) THEN
	LEAVE L;
END IF;

IF(sname NOT IN(select result.name from result)) THEN
	call insresult(rno,sname);
	set rno = rno + 1;
END IF;
END LOOP;

CLOSE stud_cursor;
end;//

delimiter ;

select * from result;

call proc_Grade();

select * from result;

insert into Stud_Marks values('A',988); 

call proc_Grade();

select * from result;
