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



create table borrower(rollno int primary key,name varchar(20), dateofissue DATE, nameofbook varchar(50),status char);

desc borrower;

create table fine(rollno int primary key,date DATE, amt int);

desc fine;

insert into borrower values (1,'Kunal','2022-07-21','Merchant Of Venice','I');

insert into borrower values (2,'Sarthak','2022-07-25','As You Like It','I');

insert into borrower values (3,'Atharva','2022-07-30','My Experiments With Truth','I');

insert into borrower values (4,'Omkar','2022-08-01','Malgudi Days','I');

insert into borrower values (5,'Darshan','2022-08-15','The Hidden Pool','I');

select * from borrower;

delimiter //

create procedure finecalc(in rollno int, in name varchar(50))
begin
declare fineamt int;
declare doi DATE;
declare dor DATE;
declare continue handler for not found
begin
select 'Not Found' as Exception;
end;
	select dateofissue into doi from borrower where name = nameofbook;
	select CURRENT_DATE() into dor;
	IF(DATEDIFF(dor,doi)>=15 and DATEDIFF(dor,doi)<=30) THEN
		set fineamt = (DATEDIFF(dor,doi)-14)*5;
	ELSEIF (DATEDIFF(dor,doi)>30) THEN
		set fineamt = (DATEDIFF(dor,doi)-30)*50 + 75;
	END IF;
	IF(DATEDIFF(dor,doi)>=0) THEN
		UPDATE borrower set status = 'R' where rollno = borrower.rollno;
	insert into fine values(rollno,dor,fineamt);
END IF;
	
END;
//

delimiter ;

call finecalc(1,'Merchant Of Venice');
select * from fine;
call finecalc(2,'As You Like It');
select * from fine;

