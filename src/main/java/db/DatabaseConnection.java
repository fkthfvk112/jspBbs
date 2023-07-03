package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
	private Connection conn;
	private static DatabaseConnection dbc;
	private DatabaseConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "4228");
			System.out.println("Success : Data base Connection");
		} catch (SQLException e) {
			System.out.println("fail : Data base Connection" + e);
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			System.out.println("fail : Class not found" + e);
			e.printStackTrace();
		}
	}
	
	public static Connection getInstance() {
		
		dbc = new DatabaseConnection();
		
		return dbc.conn;
	}
}
