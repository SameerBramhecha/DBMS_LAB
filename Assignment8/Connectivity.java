import java.util.*;
import java.sql.*;

public class Connectivity{
	
	public static void main(String[] args) {
		
		Scanner sc= new Scanner(System.in);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(
"jdbc:mysql://10.10.12.108/t31115db?characterEncoding=utf8","t31115","t31115");
			Statement st = con.createStatement();
			char c = 'Y';
			while(c == 'Y'||c=='y') {
				System.out.println("---MENU---");
				System.out.println("1. Display All Records");
				System.out.println("2. Insert Record");
				System.out.println("3. Update Record");
				System.out.println("4. Delete record");
				System.out.println("Enter Choice: ");
				int ch = sc.nextInt();
			switch(ch){
			case 1:
				ResultSet rs = st.executeQuery("select * from O_EmpId;");
				while(rs.next()) {
					System.out.println(rs.getInt(1)+"\t"+rs.getString(2)+"\t"
					+rs.getString(3));
				}
				break;
			case 2:
				System.out.println("Enter no of records to insert: ");
				int x = sc.nextInt();
				for(int i=0;i<x;i++) {
					System.out.println("Enter empid");
					int empid = sc.nextInt();
					System.out.println("Enter Name");
					String name = sc.next();
					System.out.println("Enter dept");
					String dept = sc.next();
					int result = st.executeUpdate("insert into O_EmpId values ("+empid+",'"+name+"','"+dept+"');");
					System.out.println(result+" records inserted");
				}
				
				break;
			case 3:
				System.out.println("Enter no of records to delete: ");
				int a = sc.nextInt();
				for(int i=0;i<a;i++) {
					System.out.println("Enter eid to update department : ");
					int empid = sc.nextInt();
					System.out.println("Enter new department: ");
					String department = sc.next();
					int result1 = st.executeUpdate("update O_EmpId set department = '"+department+"' where empid = "+empid+";");
					System.out.println(result1+ "records updated");
				}
				
				break;
			case 4:
				System.out.println("Enter no of records to delete: ");
				int n = sc.nextInt();
				for(int i=0;i<n;i++) {
					System.out.println("Enter empid to delete: ");
					int eid = sc.nextInt();
					int result2 = st.executeUpdate("delete from O_EmpId where empid = "+eid+";");
					System.out.println(result2+ "records deleted");
				}
				break;
			default: 
				System.out.println("Enter Valid Choice;");
				break;
			}
			System.out.println("Do you want to continue?(y/n)");
			c = sc.next().charAt(0);
			}
			con.close();
		}
		
		catch(Exception e) {
			
			System.out.println(e);
		}
		
		sc.close();
	}
	
}
//javac Connectivity.java
//java Connectivity
