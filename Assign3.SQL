create table placementdrive(drive_id int primary key auto_increment,
company_name varchar(30),package int,
location varchar(30) );


create table student(s_id int primary key auto_increment,
drive_id int, s_name varchar(30),
cgpa real, s_branch varchar(20),
foreign key(drive_id) references placementdrive(drive_id) on delete cascade);

alter table student auto_increment = 101;

create table training(t_id int primary key auto_increment, 
s_id int, company_name varchar(30),
t_fee int, t_year YEAR,
foreign key(s_id) references student(s_id) on delete cascade);

/*Inserting records in tables*/

insert into  placementdrive (company_name,package,location) values ('Amazon',1500000,'Mumbai');
insert into  placementdrive (company_name,package,location) values ('Google',2000000,'Pune');
insert into  placementdrive (company_name,package,location) values ('Infosys',500000,'Banglore');
insert into  placementdrive (company_name,package,location) values ('Flipkart',800000,'Pune');
insert into  placementdrive (company_name,package,location) values ('Twitter',750000,'Mumbai');
insert into  placementdrive (company_name,package,location) values ('Google',500000,'Banglore');
insert into  placementdrive (company_name,package,location) values ('Microsoft',1000000,'Thane');
insert into  placementdrive (company_name,package,location) values ('Wipro',500000,'Chennai');


insert into student (drive_id,s_name,cgpa, s_branch) values (1,'Sameer',9.7,'Computer');
insert into student (drive_id,s_name,cgpa, s_branch) values (2,'Kunal',9.6,'ENTC');
insert into student (drive_id,s_name,cgpa, s_branch) values (5,'Yash',9.4,'IT');
insert into student (drive_id,s_name,cgpa, s_branch) values (1,'Aditi',9.1,'Computer');
insert into student (drive_id,s_name,cgpa, s_branch) values (4,'Darshan',8.4,'Computer');
insert into student (drive_id,s_name,cgpa, s_branch) values (5,'Atharva',7.14,'ENTC');
insert into student (drive_id,s_name,cgpa, s_branch) values (8,'Kajol',6.1,'ENTC');
insert into student (drive_id,s_name,cgpa, s_branch) values (7,'Sejal',8,'IT');
insert into student (drive_id,s_name,cgpa, s_branch) values (6,'Arnav',7.8,'Computer');
insert into student (drive_id,s_name,cgpa, s_branch) values (3,'Dhruv',8.5,'ENTC');
insert into student (drive_id,s_name,cgpa, s_branch) values (7,'Shantanu',9,'Computer');
insert into student (drive_id,s_name,cgpa, s_branch) values (3,'Utkarsh',8.5,'Computer');
insert into student (drive_id,s_name,cgpa, s_branch) values (2,'Kalash',8.8,'Computer');


insert into training (s_id,company_name, t_fee,t_year) values (104,'Amazon',5750,2019);
insert into training (s_id,company_name, t_fee,t_year) values (101,'Amazon',15000,2020);
insert into training (s_id,company_name, t_fee,t_year) values (113,'Google',25000,2021);
insert into training (s_id,company_name, t_fee,t_year) values (112,'Infosys',4025,2019);
insert into training (s_id,company_name, t_fee,t_year) values (105,'Flipkart',4500,2020);
insert into training (s_id,company_name, t_fee,t_year) values (102,'Google',10000,2021);
insert into training (s_id,company_name, t_fee,t_year) values (103,'Twitter',6325,2019);
insert into training (s_id,company_name, t_fee,t_year) values (109,'Google',8000,2014);
insert into training (s_id,company_name, t_fee,t_year) values (108,'Microsoft',20000,2015);
insert into training (s_id,company_name, t_fee,t_year) values (107,'Wipro',16000,2013);
insert into training (s_id,company_name, t_fee,t_year) values (111,'Microsoft',27000,2011);
insert into training (s_id,company_name, t_fee,t_year) values (110,'Infosys',12000,2016);
insert into training (s_id,company_name, t_fee,t_year) values (106,'Google',10000,2018);


/*Query 1
Find the Student details and Placement details using NATURAL JOIN.
*/
select * from student natural join placementdrive;

/*Query 2
Find all the student details with company_name

*/
select s_id,student.drive_id,s_name,cgpa,s_branch,company_name from student,placementdrive where student.drive_id = placementdrive.drive_id;

/*Query 3
List all the Student name and Student branch of Student having package 5 LPA
*/
select s_name,s_branch from student inner join placementdrive on student.drive_id = placementdrive.drive_id where package = 500000;

/*Query 4   
List all the student names ,company_name having T_fee more than 20000
*/
select s_name,company_name,t_fee from student inner join training on student.s_id = training.s_id where t_fee>20000;

/*Query 5
 Display all training details attended by “shantanu” in year 2011
*/
select * from training where s_id = (select s_id from student where s_name = 'Shantanu');

/*Query 6
 list the total number of companies who conducted training before 2015

*/
select company_name,t_year from training where t_year<2015;

/*Query 7
List the students name with company ‘Microsoft’ and location ’Thane’
*/
select s_name,company_name,location from student inner join placementdrive on student.drive_id=placementdrive.drive_id where (company_name='Microsoft' and location='Thane');

/*Query 8
Find the names of all Students who have joined ‘Microsoft ‘ training in 2015 .
*/
select s_name, company_name from student inner join training on student.s_id=training.s_id where company_name = 'Microsoft' and t_year=2015;

/*Query 9
Create a view showing the Student and Training details
*/
create view st as select * from training natural join student;
select * from st;

/*Query 10
Perform Manipulation on simple view-Insert, update, delete, drop view.
*/
create view stt as select s_name,s_branch from student;
desc stt;
select * from stt;
insert into stt(s_name,s_branch) values ('Ajay','IT');
drop view stt;
desc stt;
