/*Database Trigger (All Types: Row level and Statement
Level triggers, Before and After Triggers).	Write a
 database trigger on Library table. The System
  should keep track of the records that are being
   updated or deleted. The old value of updated or
    deleted records should be added in Library_Audit table.
Frame problem statement for writing Database Triggers
 of all types, in line with above statement. The problem
  statement should clearly state the requirements.
*/

create table Library(book_id int primary key,title varchar(40),isbn bigint, author varchar(20),copies int);

create table library_audit(book_id int,title varchar(40),isbn bigint, author varchar(20),copies int);

insert into Library values(1,'Hamlet',9503424234,'Shakesphere',5);
insert into Library values(2,'Othello',9503425334,'Shakesphere',6);
insert into Library values(3,'Deep Work',4853985543,'Cal Newport',4);
insert into Library values(4,'Ikigai',4824285543,'Hector Garcia',10);
insert into Library values(5,'Night',4853385543,'William Blake',7);
insert into Library values(6,'The Dark Room',3634636463,'R.K.Narayan',20);

/*BEFORE DELETE TRIGGER*/

DELIMITER //

CREATE TRIGGER t
BEFORE DELETE 
ON Library FOR EACH ROW
BEGIN
  INSERT INTO library_audit values(OLD.book_id,old.title,old.isbn,old.author,old.copies);
END;
//

/*BEFORE UPDATE TRIGGER*/

CREATE TRIGGER t1
BEFORE UPDATE 
ON Library FOR EACH ROW
BEGIN
  INSERT INTO library_audit values(OLD.book_id,old.title,old.isbn,old.author,old.copies);
END;
//

DELIMITER ;

select * from Library;

update Library set copies = 15 where title = 'The Dark Room';

select * from library_audit;

select * from Library;

delete from Library where book_id = 4;

select * from library_audit;

select * from Library;