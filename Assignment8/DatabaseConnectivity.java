

import java.sql.*;

public class DatabaseConnectivity {
	protected static Connection initializeDatabase() throws Exception{
		String dbDriver = "com.mysql.jdbc.Driver";
		
		Class.forName(dbDriver);
		
		String url = "jdbc:mysql://localhost:3306/te31115db?characterEncoding=utf8";
		String username = "root";
		String password = "sameer";
		Connection con = DriverManager.getConnection(url,username,password);
		
		return con;
	}
}
