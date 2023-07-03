package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DatabaseConnection;
import db.DbClose;
import dto.UserDto;

public class UserDao {
	private static UserDao userDao = null;
	
	private UserDao() {
		
	}
	
	public static UserDao getInstance() {
		if(userDao == null) {
			userDao = new UserDao();
		}
		
		return userDao;
	}
	
	public UserDto login(String id, String pwd){
		UserDto dto = null;
		String sql = "select id, pwd, name, email, auth from user where id=? and pwd=?";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		try {
			System.out.println("---1---");
			conn = DatabaseConnection.getInstance();
			System.out.println("---2---");
			psmt = conn.prepareStatement(sql);
			System.out.println("---3---");
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			rs = psmt.executeQuery();
			System.out.println("---4---");

			if(rs.next()) {
				String userId = rs.getString("id");
				String userPwd = rs.getString("pwd");
				String userName = rs.getString("name");
				String userEmail = rs.getString("email");
				int userAuth = rs.getInt("auth");
				System.out.println(userId + userPwd + userName + userEmail);
				dto = new UserDto(userId, userPwd, userName, userEmail, userAuth);
			}
		}
		catch(Exception e) {
			System.out.println("오류 : " + e);
		}
		finally {
			DbClose.close(psmt, conn, rs);
		}
		
		return dto;
	}
}
