mysql> create database trig;
Query OK, 1 row affected (0.00 sec)  
mysql>
mysql> use trig; 
Database changed  
mysql>           
mysql> create table Library(book_id int primary key,title varchar(40),isbn bigint, author varchar(20),copies int);
Query OK, 0 rows affected (0.01 sec)   
mysql>                              
mysql> create table library_audit(book_id int,title varchar(40),isbn bigint, author varchar(20),copies int);       
Query OK, 0 rows affected (0.01 sec)
mysql>  
mysql>  
mysql> /*BEFORE INSERT TRIGGER*/     
mysql>     
mysql> DELIMITER //   
mysql>          
mysql> CREATE TRIGGER t1  
-> BEFORE INSERT        
-> ON Library FOR EACH ROW
-> BEGIN
-> INSERT INTO library_audit values(book_id,title,isbn,author,copies);   
-> END;                                                                
-> //   
Query OK, 0 rows affected (0.00 sec)  
mysql>                     
mysql> /*AFTER INSERT TRIGGER*/ 
mysql>                       
mysql> CREATE TRIGGER t2     
-> AFTER INSERT              
-> ON Library FOR EACH ROW   
-> BEGIN                     
->   INSERT INTO library_audit values(NEW.book_id,NEW.title,NEW.isbn,NEW.author,NEW.copies);
-> END;  
-> //        
Query OK, 0 rows affected (0.00 sec)  
mysql>
mysql> DELIMITER ; 
mysql>                               
mysql> insert into Library values(1,'Hamlet',9503424234,'Shakesphere',5);    
Query OK, 1 row affected (0.00 sec)                                         
mysql> insert into Library values(2,'Othello',9503425334,'Shakesphere',6);  
Query OK, 1 row affected (0.00 sec)                                         
mysql> insert into Library values(3,'Deep Work',4853985543,'Cal Newport',4); 
Query OK, 1 row affected (0.00 sec)                                          
mysql> insert into Library values(4,'Ikigai',4824285543,'Hector Garcia',10); 
Query OK, 1 row affected (0.00 sec)                                          
mysql> insert into Library values(5,'Night',4853385543,'William Blake',7);   
Query OK, 1 row affected (0.00 sec)                                          
mysql> insert into Library values(6,'The Dark Room',3634636463,'R.K.Narayan',20);   
Query OK, 1 row affected (0.00 sec)                                                 
mysql>                                                                              
mysql> select * from Library;                                                       
+---------+---------------+------------+---------------+--------+                   
| book_id | title         | isbn       | author        | copies |                   
+---------+---------------+------------+---------------+--------+                   
|       1 | Hamlet        | 9503424234 | Shakesphere   |      5 |                   
|       2 | Othello       | 9503425334 | Shakesphere   |      6 |                   
|       3 | Deep Work     | 4853985543 | Cal Newport   |      4 |                   
|       4 | Ikigai        | 4824285543 | Hector Garcia |     10 |                   
|       5 | Night         | 4853385543 | William Blake |      7 |                   
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     20 |                   
+---------+---------------+------------+---------------+--------+                   
6 rows in set (0.00 sec)                                                            
mysql>
mysql> select * from library_audit;                                                 

+---------+---------------+------------+---------------+--------+                   
| book_id | title         | isbn       | author        | copies |
+---------+---------------+------------+---------------+--------+                   
|    NULL | NULL          |       NULL | NULL          |   NULL |                   
|       1 | Hamlet        | 9503424234 | Shakesphere   |      5 |                   
|    NULL | NULL          |       NULL | NULL          |   NULL |
|       2 | Othello       | 9503425334 | Shakesphere   |      6 |                   
|    NULL | NULL          |       NULL | NULL          |   NULL |                   
|       3 | Deep Work     | 4853985543 | Cal Newport   |      4 |
|    NULL | NULL          |       NULL | NULL          |   NULL |                   
|       4 | Ikigai        | 4824285543 | Hector Garcia |     10 |
|    NULL | NULL          |       NULL | NULL          |   NULL |  
|       5 | Night         | 4853385543 | William Blake |      7 |   
|    NULL | NULL          |       NULL | NULL          |   NULL |   
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     20 |   
+---------+---------------+------------+---------------+--------+   
12 rows in set (0.00 sec)                                           
mysql>                                                              
mysql> /*BEFORE UPDATE TRIGGER*/                                    
mysql>                                                               
mysql> DELIMITER //                                                  
mysql>                                                               
mysql> CREATE TRIGGER t3                                             
-> BEFORE UPDATE                                                     
-> ON Library FOR EACH ROW                                           
-> BEGIN                                                             
->   INSERT INTO library_audit values(OLD.book_id,old.title,old.isbn,old.author,old.copies);   
-> END;                                                                              
-> //                                                                                
Query OK, 0 rows affected (0.01 sec)                                                 
mysql>                                                                               
mysql> /*AFTER UPDATE TRIGGER*/                                                      
mysql>                                                                               
mysql> CREATE TRIGGER t4                                                             
-> AFTER UPDATE                                                                      
-> ON Library FOR EACH ROW                                                           
-> BEGIN                                                                             
->   INSERT INTO library_audit values(NEW.book_id,NEW.title,NEW.isbn,NEW.author,NEW.copies);    
-> END;                                                                                       
-> //                                                                                         
Query OK, 0 rows affected (0.00 sec)                                                          
mysql>                                                                                        
mysql> DELIMITER ;                                                                            
mysql> select * from Library;                                                                       
+---------+---------------+------------+---------------+--------+                                     
| book_id | title         | isbn       | author        | copies |                                     
+---------+---------------+------------+---------------+--------+                                     
|       1 | Hamlet        | 9503424234 | Shakesphere   |      5 |                                     
|       2 | Othello       | 9503425334 | Shakesphere   |      6 |                                     
|       3 | Deep Work     | 4853985543 | Cal Newport   |      4 |                                     
|       4 | Ikigai        | 4824285543 | Hector Garcia |     10 |                                     
|       5 | Night         | 4853385543 | William Blake |      7 |                                     
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     20 |                                     
+---------+---------------+------------+---------------+--------+                                     
6 rows in set (0.00 sec)                                                                              
mysql>                                                                                                
mysql> select * from library_audit;                                                                   
+---------+---------------+------------+---------------+--------+                                     
| book_id | title         | isbn       | author        | copies |                                     
+---------+---------------+------------+---------------+--------+
|    NULL | NULL          |       NULL | NULL          |   NULL |                                     
|       1 | Hamlet        | 9503424234 | Shakesphere   |      5 |                                 
|    NULL | NULL          |       NULL | NULL          |   NULL | 
|       2 | Othello       | 9503425334 | Shakesphere   |      6 | 
|    NULL | NULL          |       NULL | NULL          |   NULL | 
|       3 | Deep Work     | 4853985543 | Cal Newport   |      4 | 
|    NULL | NULL          |       NULL | NULL          |   NULL | 
|       4 | Ikigai        | 4824285543 | Hector Garcia |     10 | 
|    NULL | NULL          |       NULL | NULL          |   NULL | 
|       5 | Night         | 4853385543 | William Blake |      7 | 
|    NULL | NULL          |       NULL | NULL          |   NULL | 
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     20 | 
+---------+---------------+------------+---------------+--------+ 
12 rows in set (0.00 sec)                                         
mysql>                                                                 
mysql> update Library set copies = 15 where title = 'The Dark Room';   
Query OK, 1 row affected (0.01 sec)                                    
Rows matched: 1  Changed: 1  Warnings: 0                               
mysql>                                                                 
mysql> select * from library_audit;                                    
+---------+---------------+------------+---------------+--------+      
| book_id | title         | isbn       | author        | copies |      
+---------+---------------+------------+---------------+--------+      
|    NULL | NULL          |       NULL | NULL          |   NULL |      
|       1 | Hamlet        | 9503424234 | Shakesphere   |      5 |      
|    NULL | NULL          |       NULL | NULL          |   NULL |      
|       2 | Othello       | 9503425334 | Shakesphere   |      6 |      
|    NULL | NULL          |       NULL | NULL          |   NULL |      
|       3 | Deep Work     | 4853985543 | Cal Newport   |      4 |      
|    NULL | NULL          |       NULL | NULL          |   NULL |      
|       4 | Ikigai        | 4824285543 | Hector Garcia |     10 |      
|    NULL | NULL          |       NULL | NULL          |   NULL |      
|       5 | Night         | 4853385543 | William Blake |      7 |      
|    NULL | NULL          |       NULL | NULL          |   NULL |      
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     20 |      
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     20 |      
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     15 |      
+---------+---------------+------------+---------------+--------+      
14 rows in set (0.00 sec)                                              
mysql>                                                                 
mysql> select * from Library;                                          
+---------+---------------+------------+---------------+--------+      
| book_id | title         | isbn       | author        | copies |      
+---------+---------------+------------+---------------+--------+      
|       1 | Hamlet        | 9503424234 | Shakesphere   |      5 |      
|       2 | Othello       | 9503425334 | Shakesphere   |      6 |      
|       3 | Deep Work     | 4853985543 | Cal Newport   |      4 |      
|       4 | Ikigai        | 4824285543 | Hector Garcia |     10 |      
|       5 | Night         | 4853385543 | William Blake |      7 |      
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     15 |      
+---------+---------------+------------+---------------+--------+      
6 rows in set (0.00 sec)                                               
mysql>                                                                 
mysql>                                                                 
mysql> /*BEFORE DELETE TRIGGER*/                                       
mysql>                                                                 
mysql> DELIMITER //                                                    
mysql>                                                                 
mysql> CREATE TRIGGER t5                                               
-> BEFORE DELETE                                                       
-> ON Library FOR EACH ROW                                             
-> BEGIN                                                               
->   INSERT INTO library_audit values(OLD.book_id,old.title,old.isbn,old.author,old.copies);       
-> END;                 
-> //                                                                  
Query OK, 0 rows affected (0.01 sec)                                   
mysql>                                                                 
mysql> /*AFTER DELETE TRIGGER*/                                        
mysql> CREATE TRIGGER t6                                               
-> AFTER DELETE                                                        
-> ON Library FOR EACH ROW                                             
-> BEGIN                                                               
->   INSERT INTO library_audit values(OLD.book_id,old.title,old.isbn,old.author,old.copies);     
-> END;                                                                                          
-> //  
Query OK, 0 rows affected (0.00 sec)             
mysql>                                           
mysql> DELIMITER ;                                
mysql>                                            
mysql> select * from Library;                     
+---------+---------------+------------+---------------+--------+          
| book_id | title         | isbn       | author        | copies |          
+---------+---------------+------------+---------------+--------+          
|       1 | Hamlet        | 9503424234 | Shakesphere   |      5 |          
|       2 | Othello       | 9503425334 | Shakesphere   |      6 |          
|       3 | Deep Work     | 4853985543 | Cal Newport   |      4 |          
|       4 | Ikigai        | 4824285543 | Hector Garcia |     10 |          
|       5 | Night         | 4853385543 | William Blake |      7 |          
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     15 |          
+---------+---------------+------------+---------------+--------+          
6 rows in set (0.00 sec)                                                   
mysql>                                                                     
mysql> select * from library_audit;
+---------+---------------+------------+---------------+--------+          
| book_id | title         | isbn       | author        | copies |          
+---------+---------------+------------+---------------+--------+          
|    NULL | NULL          |       NULL | NULL          |   NULL |          
|       1 | Hamlet        | 9503424234 | Shakesphere   |      5 |          
|    NULL | NULL          |       NULL | NULL          |   NULL |          
|       2 | Othello       | 9503425334 | Shakesphere   |      6 |          
|    NULL | NULL          |       NULL | NULL          |   NULL |          
|       3 | Deep Work     | 4853985543 | Cal Newport   |      4 |          
|    NULL | NULL          |       NULL | NULL          |   NULL |          
|       4 | Ikigai        | 4824285543 | Hector Garcia |     10 |          
|    NULL | NULL          |       NULL | NULL          |   NULL |          
|       5 | Night         | 4853385543 | William Blake |      7 |          
|    NULL | NULL          |       NULL | NULL          |   NULL |          
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     20 |           
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     20 |     
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     15 |    
+---------+---------------+------------+---------------+--------+    
14 rows in set (0.00 sec)                                            
mysql>                                                               
mysql> delete from Library where book_id = 4;                        
Query OK, 1 row affected (0.01 sec)                                  
mysql>                                                               
mysql> select * from library_audit;                                  
+---------+---------------+------------+---------------+--------+    
| book_id | title         | isbn       | author        | copies |    
+---------+---------------+------------+---------------+--------+    
|    NULL | NULL          |       NULL | NULL          |   NULL |    
|       1 | Hamlet        | 9503424234 | Shakesphere   |      5 |    
|    NULL | NULL          |       NULL | NULL          |   NULL |    
|       2 | Othello       | 9503425334 | Shakesphere   |      6 |    
|    NULL | NULL          |       NULL | NULL          |   NULL |    
|       3 | Deep Work     | 4853985543 | Cal Newport   |      4 |    
|    NULL | NULL          |       NULL | NULL          |   NULL |    
|       4 | Ikigai        | 4824285543 | Hector Garcia |     10 |    
|    NULL | NULL          |       NULL | NULL          |   NULL |    
|       5 | Night         | 4853385543 | William Blake |      7 |    
|    NULL | NULL          |       NULL | NULL          |   NULL |    
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     20 |    
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     20 |    
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     15 |    
|       4 | Ikigai        | 4824285543 | Hector Garcia |     10 |    
|       4 | Ikigai        | 4824285543 | Hector Garcia |     10 |    
+---------+---------------+------------+---------------+--------+    
16 rows in set (0.00 sec)                                            
mysql>                                                               
mysql> select * from Library;                                        
+---------+---------------+------------+---------------+--------+    
| book_id | title         | isbn       | author        | copies |    
+---------+---------------+------------+---------------+--------+    
|       1 | Hamlet        | 9503424234 | Shakesphere   |      5 |    
|       2 | Othello       | 9503425334 | Shakesphere   |      6 |    
|       3 | Deep Work     | 4853985543 | Cal Newport   |      4 |    
|       5 | Night         | 4853385543 | William Blake |      7 |    
|       6 | The Dark Room | 3634636463 | R.K.Narayan   |     15 |    
+---------+---------------+------------+---------------+--------+    
5 rows in set (0.00 sec)                                             
mysql>                                                               
mysql>                                                               
mysql> drop table library;                                           
Query OK, 0 rows affected (0.01 sec)                                 
mysql> drop table library_audit;                                     
Query OK, 0 rows affected (0.01 sec)                                 
mysql>                                                               
mysql> drop database trig;                                           
Query OK, 0 rows affected (0.01 sec)                                 
mysql> 
