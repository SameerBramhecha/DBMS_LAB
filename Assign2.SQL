create table placementdrive (drive_id int primary key auto_increment, companyname varchar(20),package int, location varchar(20));

desc placementdrive;

create table student (s_id int primary key auto_increment, drive_id int, sname varchar(20), cgpa real,sbranch varchar(20), foreign key(drive_id) references placementdrive(drive_id) ON DELETE CASCADE );
alter table student auto_increment = 101;

desc student;

create table training (t_id int primary key auto_increment, tcompanyname varchar(25),tfee int, tyear year);

desc training;


/*
Query 1: - Insert at least 10 records in the Student table
 and insert other tables accordingly.*/
insert into placementdrive values(1,'Amazon',150000,'Mumbai');
insert into placementdrive values(2,'Google',200000,'Pune');
insert into placementdrive values(3,'Infosys',160000,'Banglore');
insert into placementdrive values(4,'Flipkart', 50000,'Pune');
insert into placementdrive values(5,'Twitter', 40000,'Mumbai');
insert into placementdrive values(6,'Google', 50000,'Banglore');
insert into placementdrive values(7,'Amazon', 40000,'Pune');
insert into placementdrive values(8,'Twitter', 35000,'Mumbai');

select * from placementdrive;

insert into student (drive_id,sname,cgpa,sbranch) values (1,'Sameer',9.7,'Computer');
insert into student (drive_id,sname,cgpa,sbranch) values (2,'Kunal',9.6,'ENTC');
insert into student (drive_id,sname,cgpa,sbranch) values (5,'Yash',9.4,'IT');
insert into student (drive_id,sname,cgpa,sbranch) values (1,'Aditi',9.1,'Computer');
insert into student (drive_id,sname,cgpa,sbranch) values (4,'Darshan',8.4,'Computer');
insert into student (drive_id,sname,cgpa,sbranch) values (5,'Atharva',7.14,'ENTC');
insert into student (drive_id,sname,cgpa,sbranch) values (8,'Kajol',6.1,'ENTC');
insert into student (drive_id,sname,cgpa,sbranch) values (7,'Sejal',8,'IT');
insert into student (drive_id,sname,cgpa,sbranch) values (6,'Arnav',7.8,'Computer');
insert into student (drive_id,sname,cgpa,sbranch) values (3,'Dhruv',8.5,'ENTC');

select  * from student;

insert into training values(1,'Amazon',5000,2019);
insert into training values(2,'Amazon',6000,2020);
insert into training values(3,'Google',8000,2021);
insert into training values(4,'Infosys',3500,2019);
insert into training values(5,'Flipkart',4500,2020);
insert into training values(6,'Flipkart',5000,2021);
insert into training values(7,'Twitter',5500,2019);

select * from training;


/*Query 2: -
Display all students details with branch ‘Computer ‘and ‘IT’ and 
student name starting with ‘a’ or 'd'.
*/

select  * from student where (sbranch = 'Computer' or sbranch = 'IT') and (sname like 'a%' or sname like 'd%');

/*Query 3: -
List the number of different companies.
*/

SELECT DISTINCT companyname from placementdrive;

/*Query 4: -
 Give 15% increase in fee of the Training with date of training year as 2019.
*/

UPDATE training set tfee = tfee*0.15+tfee where tyear=2019;
SELECT * from training;

/*Query 5: -
Delete PlacementDrive details having package less than 500000.
*/

update placementdrive set package = 2000000 where package = 150000;

delete from placementdrive where package<=500000;

select * from placementdrive;

select * from student;

/*Query 6: -
Find the names of companies belonging to’ Pune’ or ‘Mumbai’.
*/

select companyname from placementdrive where location='Mumbai' or location = 'Pune';

/*Query 7: -
Find the Average Package from PlacementDrive.
*/

SELECT avg(package) from placementdrive;

/*Query 8: -
Find the student name having maximum CGPA score and names of students
having CGPA score between 7 and 9.
*/

SELECT sname, cgpa from student where cgpa = (select max(cgpa) from student);

SELECT sname, cgpa from student where cgpa>=7 and cgpa<=9;
/*Query 9: -
Display All Training with Decreasing order of Training Fees.
*/

select * from training order by tfee DESC;

/*Query 10: -
Display Company name, S_name , location and Package with Package 30K,
40K and 50k
*/

create view stud_comp as SELECT companyname,sname,location,package from student,placementdrive where (placementdrive.drive_id = student.drive_id);

desc stud_comp; 

select * from stud_comp where (package=30000 or package = 40000 or package = 50000);
