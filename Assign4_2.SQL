/*Write a PL/SQL code block to calculate the area of a circle
 for a value of radius varying from 5 to 9. Store the radius 
 and the corresponding values of calculated area in an empty 
 table named areas, consisting of two columns, radius, and area.*/


create table area (radius real primary key,area real);

delimiter //
create procedure areacalc(in radius real)
begin
declare area real;
declare pie real;
set pie = 3.14;
IF (radius > 9 or radius <5) THEN
select 'Values > 9 and < 5 are not allowed' as Exception;
ELSE 
set area = pie*radius*radius;
insert into area values(radius,area);
END IF;
END;//

delimiter ;

call areacalc(5);
select * from area;
call areacalc(5.5);
select * from area;
call areacalc(9.5);
select * from area;
