/*Assignment 2A
Employee Schema

Employee( Emp_id, Dept_id, fname, lname, 
designation, salary,JoinDate)

Dept ( Dept_id, dname,dlocation )

Project( Proj_id,Dept_id ,Pname,Plocation,
Pcost,Pyear)
*/

create table dept(dept_id int primary key 
auto_increment, dname varchar(40),
dlocation varchar(40));

create table employee(emp_id int primary key
auto_increment, dept_id int, fname varchar(40),
lname varchar(40), designation varchar(40),
salary bigint, joinDate DATE,
foreign key(dept_id) references dept(dept_id)
ON DELETE CASCADE);

alter table employee
auto_increment = 1001;


create table project(proj_id int primary key
auto_increment, dept_id int, pname varchar(40),
plocation varchar(40), pcost bigint,
pyear YEAR,
foreign key(dept_id) references dept(dept_id)
ON DELETE CASCADE);


/*1. Insert at least 10 records in the Employee
 table and insert other tables accordingly

//dept table*/
insert into dept(dname,dlocation) 
values ('Computer','Pune');

insert into dept(dname,dlocation) 
values ('IT','Mumbai');

insert into dept(dname,dlocation) 
values ('Sales','Pune');

/*employee table*/
insert into employee(dept_id, fname,
lname,designation,salary,joinDate)
values (1,'Sameer','B','CEO',1000000,
'2004-09-01');

insert into employee(dept_id, fname,
lname,designation,salary,joinDate)
values (2,'Kalash','S','CTO',800000,
'2004-09-15');

insert into employee(dept_id, fname,
lname,designation,salary,joinDate)
values (3,'Yash','K','Manager',700000,
'2004-09-16');

insert into employee(dept_id, fname,
lname,designation,salary,joinDate)
values (2,'Omkar','B','SDE',650000,
'2005-01-01');

insert into employee(dept_id, fname,
lname,designation,salary,joinDate)
values (1,'Utkarsh','J','System Designer'
,750000,'2005-01-16');

insert into employee(dept_id, fname,
lname,designation,salary,joinDate)
values (1,'Aditi','C','Web Developer',
600000,'2005-02-16');

insert into employee(dept_id, fname,
lname,designation,salary,joinDate)
values (2,'Kunal','T','SDE',650000,
'2007-09-29');

insert into employee(dept_id, fname,
lname,designation,salary,joinDate)
values (2,'Priyal','B','Web Developer',
600000,'2013-09-19');

insert into employee(dept_id, fname,
lname,designation,salary,joinDate)
values (1,'Hitesh','G','Web Developer',
600000,'2018-09-20');

insert into employee(dept_id, fname,
lname,designation,salary,joinDate)
values (1,'Sejal','B','SDE',650000,
'2019-09-24');

/*project*/

insert into project(dept_id,pname,
plocation,pcost,pyear) values
(1,'P1','Pune',250000,2004);

insert into project(dept_id,pname,
plocation,pcost,pyear) values
(2,'P2','Mumbai',500000,2005);

insert into project(dept_id,pname,
plocation,pcost,pyear) values
(1,'P3','Chennai',750000,2005);

insert into project(dept_id,pname,
plocation,pcost,pyear) values
(3,'P4','Delhi',70000,2007);

insert into project(dept_id,pname,
plocation,pcost,pyear) values
(3,'P5','Mumbai',100000,2017);

insert into project(dept_id,pname,
plocation,pcost,pyear) values
(2,'P6','Pune',600000,2019);


/*2. Display all Employee details with Department
 ‘Computer’ and ‘IT’ and Employee
 first name starting with 'p' or 'h'.*/

select * from employee where
(dept_id=1 or dept_id=2) and
(fname like 'p%' or fname like 'h%');

/*3. Lists the number of different Employee 
Positions. */

select DISTINCT designation from employee;

/*4. Give 10% increase in Salary of the Employee 
whose joindate before 2015. */

update employee set salary = salary+0.1*salary
where joinDate<'2015-01-01';

select * from employee;


/*5. Delete all the department details having 
location as ‘mumbai’. */

delete from dept where dlocation = 'Mumbai';

select * from dept;

select * from employee;

select * from project;

/*6. Find the names of Projects with location 
‘pune’ . */

select pname from project where 
plocation = 'Pune';

/*7. Find the project having cost in between 
100000 to 500000. */

select * from project where pcost>=100000 
and pcost<=500000;

/*8. Find the project having maximum price and 
find average Project cost.*/

select * from project where 
pcost = (select max(pcost) from project);

/*9. Display all employees with Emp _id and Emp 
name in descending order.*/

select * from employee ORDER BY emp_id,fname DESC;	

/*10. Display Proj_name,Plocation ,Pcost of all
 project started in 2004,2005,2007 */

select pname,plocation,pcost from project
where (pyear = 2004 or pyear = 2005 or 
pyear = 2007);
