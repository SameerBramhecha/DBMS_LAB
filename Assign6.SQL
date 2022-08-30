create table O_EmpId (empid int primary key, name varchar(20),department varchar(20));

create table N_EmpId (empid int primary key, name varchar(20),department varchar(20));

/*Inserting values in O_EmpId table*/

insert into O_EmpId VALUES (101,'Sagar','Accounts');

insert into O_EmpId VALUES (102,'Yash','IT');

insert into O_EmpId VALUES (103,'Vikas','IT');

insert into O_EmpId VALUES (104,'Kshitij','Accounts');

insert into O_EmpId VALUES (105,'Aryan','Accounts');

insert into O_EmpId VALUES (106,'Jay','IT');

insert into O_EmpId VALUES (107,'Viraj','Management');

insert into O_EmpId VALUES (108,'Rohit','Management');

insert into O_EmpId VALUES (109,'Atharva','IT');

select * from O_EmpId;

/*Inserting values in N_EmpId table*/

insert into N_EmpId VALUES (102,'Yash','IT');

insert into N_EmpId VALUES (105,'Aryan','Accounts');

insert into N_EmpId VALUES (106,'Jay','IT');

insert into N_EmpId VALUES (108,'Rohit','Management');

select * from N_EmpId;

/*Creating procedure to implement Cursor*/

delimiter //

CREATE procedure cursor1()
BEGIN
DECLARE finished INTEGER DEFAULT 0;
DECLARE eid INTEGER DEFAULT 0;
DECLARE ename varchar(20) DEFAULT "";
DECLARE dept varchar(20) DEFAULT "";

DECLARE emp_cursor CURSOR FOR SELECT * FROM O_EmpId;

DECLARE CONTINUE HANDLER FOR NOT FOUND
BEGIN
	SET finished = 1;
END;

OPEN emp_cursor;
L: LOOP

FETCH emp_cursor into eid,ename,dept;

IF (finished = 1) THEN
	LEAVE L;
END IF;

IF(eid not in(select N_EmpId.empid from N_EmpId)) THEN
	INSERT INTO N_EmpId VALUES (eid,ename,dept);
END IF;
END LOOP;

CLOSE emp_cursor;

END;
//
delimiter ;

select * from N_EmpId;

call cursor1();

select * from N_EmpId;

