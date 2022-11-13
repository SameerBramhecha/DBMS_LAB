/*Unnamed PL/SQL code block: Use of Control structure 
and Exception handling is mandatory.
Write a PL/SQL block of code for the following requirements:-
Schema:
1.	Borrower(Roll, Name, DateofIssue, NameofBook, Status)
2.	Fine(Roll, Date, Amt)
•Accept Roll & Nameofbook from user.
•Check the number of days (from dateofissue), if days
are between 15 to 30 then fine amount will be Rs 5 per day.
•If no.ofdays>30, per day fine will be Rs 50 per day &
for days less than 30, Rs.5 per day.
•After submitting the book, status will change from I to R.
•If condition of fine is true, then details will be stored into fine table.
*/



Asssignment 4A


create table borrower(
rollno int, name varchar(40),
doi DATE, bname varchar(40),
status char
);

create table fine(
rollno int,
date DATE,
amt int
);

insert into borrower values (1,'Kunal',
'2022-11-01','Merchant Of Venice','I');

insert into borrower values (2,'Sarthak',
'2022-10-30','As You Like It','I');

insert into borrower values (3,'Atharva',
'2022-10-31','My Experiments With Truth','I');

insert into borrower values (4,'Omkar',
'2022-10-25','Malgudi Days','I');

insert into borrower values (5,'Darshan',
'2022-10-15','The Hidden Pool','I');

select * from borrower;
delimiter //

create procedure finecalc(in roll_no int,
in b_name varchar(40))
begin
declare date_of_issue DATE;
declare fineamt int default -1;
declare days int;
declare act_rollno int;
declare pre_status char;

declare exit handler for SQLSTATE '43250'
begin
select "Book was previously returned!!!" as 
Exception;
end;

declare exit handler for SQLSTATE '43251'
begin
select "This roll number did not issue the 
book which they are trying to return" 
as Exception;
end;

declare exit handler for not found
begin
select "Book not Found" as Exception;
end;

select doi into date_of_issue from borrower 
where bname = b_name;

select rollno into act_rollno from borrower
where bname = b_name;

select status into pre_status from borrower
where bname = b_name;

IF(pre_status = "R") THEN SIGNAL SQLSTATE '43250';
END IF;

IF(roll_no != act_rollno) THEN SIGNAL SQLSTATE '43251';
END IF;

set days = DATEDIFF(CURDATE(),date_of_issue);

IF(days>15 and days<=30) THEN
set fineamt = days*5;
ELSEIF (days>30) THEN
set fineamt = (days-30)*50 + 150;
END IF;

IF(fineamt!=-1) THEN
insert into fine values(roll_no,CURDATE(),fineamt);
update borrower set status = "R" where rollno = roll_no;
select fineamt as "Fine to be paid";

ELSE
update borrower set status = "R" where rollno = roll_no;
select "No fine to be paid" as "Message";
END IF;
END;

//

delimiter ;

call finecalc(1,'Merchant Of Venice');


