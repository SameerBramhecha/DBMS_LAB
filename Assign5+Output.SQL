mysql> create table Stud_Marks(name varchar(40),                                                 
    -> total_marks int);                                                    
Query OK, 0 rows affected (0.03 sec)                                    
mysql>
mysql> create table result(rollno int primary key,
    -> name varchar(40), class varchar(40));
Query OK, 0 rows affected (0.01 sec) 
mysql>
mysql> DESC Stud_Marks;
+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra | 
+-------------+-------------+------+-----+---------+-------+ 
| name        | varchar(40) | YES  |     | NULL    |       | 
| total_marks | int         | YES  |     | NULL    |       | 
+-------------+-------------+------+-----+---------+-------+  
2 rows in set (0.00 sec) 
mysql> DESC result;
+--------+-------------+------+-----+---------+-------+ 
| Field  | Type        | Null | Key | Default | Extra | 
+--------+-------------+------+-----+---------+-------+ 
| rollno | int         | NO   | PRI | NULL    |       | 
| name   | varchar(40) | YES  |     | NULL    |       | 
| class  | varchar(40) | YES  |     | NULL    |       |  
+--------+-------------+------+-----+---------+-------+ 
3 rows in set (0.00 sec) 
mysql>
mysql> insert into Stud_Marks values ('Yashpal',1410);
Query OK, 1 row affected (0.01 sec)
mysql>
mysql> insert into Stud_Marks values ('Kalash',907);
Query OK, 1 row affected (0.00 sec)
mysql>
mysql> insert into Stud_Marks values ('Utkarsh',864);
Query OK, 1 row affected (0.00 sec)
mysql>
mysql> insert into Stud_Marks values ('Omkar',1015);
Query OK, 1 row affected (0.00 sec)
mysql>
mysql> insert into Stud_Marks values ('Dhruv',953);
Query OK, 1 row affected (0.00 sec) 
mysql>                    
mysql> insert into Stud_Marks values ('Mahavir',837);    
Query OK, 1 row affected (0.00 sec)               
mysql>                                            
mysql> select * from Stud_Marks;                   
+---------+-------------+                           
| name    | total_marks |                            
+---------+-------------+                               
| Yashpal |        1410 |    
| Kalash  |         907 |      
| Utkarsh |         864 |     
| Omkar   |        1015 |     
| Dhruv   |         953 | 
| Mahavir |         837 |   
+---------+-------------+   
6 rows in set (0.00 sec)    
mysql>                    
mysql> delimiter //              
mysql>                           
mysql> create function setclass (marks int)          
    -> returns varchar(40)      
    -> deterministic   
    -> BEGIN           
    -> declare grade varchar(30);  
    -> IF (marks>=990 and marks<=1500) THEN   
    -> set grade = 'Distinction Class';     
    -> ELSEIF (marks>=900 and marks<=989) THEN  
    -> set grade = 'First Class';   
    -> ELSEIF (marks>=825 and marks<=899) THEN  
    -> set grade = 'Higher Second Class';  
    -> ELSE                                
    -> set grade = '-----------';              
    -> END IF;  
    -> return grade;  
    -> END;//        
Query OK, 0 rows affected (0.01 sec) 
mysql>     
mysql> create procedure insresult(in rollno int, in name varchar(20))   
    -> BEGIN  
    -> declare smarks int;         
    -> declare grade varchar(40);    
    -> declare stud_name varchar(40);     
    -> select Stud_Marks.total_marks into smarks from Stud_marks where Stud_Marks.name = name;
    -> select name into stud_name;       
    -> select setclass(smarks) into grade;   
    -> insert into result values(rollno,stud_name,grade);       
    -> END;//                 
Query OK, 0 rows affected (0.00 sec)   
mysql>                     
mysql>                      
mysql> create procedure proc_Grade()      
    -> begin                     
    -> declare finished integer default 0;     
    -> declare rno integer default (select count(*) from result);
    -> declare sname varchar(40) default "";    
    -> declare totmarks int default 0;   
    ->                              
    -> declare stud_cursor CURSOR FOR SELECT * FROM Stud_Marks;     
    ->                                                           
    -> DECLARE CONTINUE HANDLER FOR NOT FOUND  
    -> BEGIN                                            
    -> SET finished = 1;                     
    -> END;                                   
    ->                                                                                                                   
    -> OPEN stud_cursor;                                                                                                 
    -> L: LOOP                                                                                                           
    ->                                                                                                                    
    -> FETCH stud_cursor into sname,totmarks;                                                                            
    ->                                                                                                                   
    -> IF (finished = 1) THEN                                                                                            
    -> LEAVE L;                                                                                                          
    -> END IF;                                                                                                           
    ->                                                                                                                   
    -> IF(sname NOT IN(select result.name from result)) THEN                                                             
    -> call insresult(rno,sname);                                                                                        
    -> set rno = rno + 1;                                                                                                
    -> END IF;                                                                                                           
    -> END LOOP;                                                                                                         
    ->                                                                                                                   
    -> CLOSE stud_cursor;                                                                                                
    -> end;//                                                                                                    
Query OK, 0 rows affected (0.01 sec)                    
mysql>                                                   
mysql> delimiter ;              
mysql>     
mysql> select * from result;
Empty set (0.00 sec)   
mysql>                  
mysql> call proc_Grade(); 
Query OK, 0 rows affected (0.01 sec)     
mysql>                 
mysql> select * from result;   
+--------+---------+---------------------+
| rollno | name    | class               |   
+--------+---------+---------------------+      
|      0 | Yashpal | Distinction Class   |     
|      1 | Kalash  | First Class         |    
|      2 | Utkarsh | Higher Second Class |       
|      3 | Omkar   | Distinction Class   |       
|      4 | Dhruv   | First Class         |       
|      5 | Mahavir | Higher Second Class |        
+--------+---------+---------------------+        
6 rows in set (0.00 sec)                          
mysql> insert into Stud_Marks values('A',988);          
Query OK, 1 row affected (0.01 sec)                     
mysql> call proc_Grade();   
Query OK, 0 rows affected (0.01 sec)    
mysql> select * from result;           
+--------+---------+---------------------+
| rollno | name    | class               |   
+--------+---------+---------------------+    
|      0 | Yashpal | Distinction Class   |    
|      1 | Kalash  | First Class         |    
|      2 | Utkarsh | Higher Second Class |    
|      3 | Omkar   | Distinction Class   |    
|      4 | Dhruv   | First Class         |    
|      5 | Mahavir | Higher Second Class |   
|      6 | A       | First Class         |    
+--------+---------+---------------------+    
7 rows in set (0.00 sec)                      
mysql> select * from stud_marks;              
+---------+-------------+                       
| name    | total_marks |                       
+---------+-------------+                       
| Yashpal |        1410 |                       
| Kalash  |         907 |                     
| Utkarsh |         864 |       
| Omkar   |        1015 |      
| Dhruv   |         953 |         
| Mahavir |         837 |         
| A       |         988 |         
+---------+-------------+             
7 rows in set (0.00 sec) 


