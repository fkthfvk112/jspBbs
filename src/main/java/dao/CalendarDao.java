package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DatabaseConnection;
import db.DbClose;
import dto.CalendarDto;

public class CalendarDao {
	private static CalendarDao dao = null;
	
	private CalendarDao() {
	}
	
	public static CalendarDao getInstance() {
		if(dao == null) {
			dao = new CalendarDao();
		}
		return dao;
	}
	
	public List<CalendarDto> getCalendarListByYMD(String id, String yyyymmdd){
		String sql = "select * from calendar where id = ? and substr(rdate, 1, 4) = ? and substr(rdate, 5, 4) = ?"
				+ "	order by wdate asc;";
		String yyyy = yyyymmdd.substring(0, 4);
		String mmdd = yyyymmdd.substring(4, 8);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			System.out.println("-----getCalendarListByYMD ---- 1/4 success");
			conn = DatabaseConnection.getInstance();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,  id);
			psmt.setString(2,  yyyy);
			psmt.setString(3,  mmdd);

			System.out.println("-----getCalendarListByYMD ---- 2/4 success");

			rs = psmt.executeQuery();
			System.out.println("-----getCalendarListByYMD ---- 3/4 success");

			while(rs.next()) {
				CalendarDto dto = new CalendarDto(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6)
						);
				list.add(dto);
			}
			System.out.println("-----getCalendarListByYMD ---- 4/4 success");

		}
		catch (SQLException e) {
			e.printStackTrace();
			System.out.println("-----getCalendarList ---- fail");
		}
		finally {
			DbClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<CalendarDto> getCalendarList(String id, String yyyyMM){
		String sql = "SELECT seq, id, title, content, rdate, wdate "
					+ " FROM ( "
					+ "   SELECT ROW_NUMBER() OVER (PARTITION BY SUBSTR(rdate, 1, 8) ORDER BY rdate ASC) AS rnum, "
					+ "       seq, id, title, content, rdate, wdate "
					+ "    FROM calendar "
					+ "   WHERE id = ? AND SUBSTR(rdate, 1, 6) = ? "
					+ " ) a "
					+ " WHERE rnum BETWEEN 1 AND 5; ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			System.out.println("-----getCalendarList ---- 1/4 success");
			conn = DatabaseConnection.getInstance();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,  id);
			psmt.setString(2,  yyyyMM);
			System.out.println("-----getCalendarList ---- 2/4 success");

			rs = psmt.executeQuery();
			System.out.println("-----getCalendarList ---- 3/4 success");

			while(rs.next()) {
				CalendarDto dto = new CalendarDto(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6)
						);
				list.add(dto);
			}
			System.out.println("-----getCalendarList ---- 4/4 success");

		}
		catch (SQLException e) {
			e.printStackTrace();
			System.out.println("-----getCalendarList ---- fail");
		}
		finally {
			DbClose.close(psmt, conn, rs);
		}
		return list;
	}

	public boolean addCalendar(CalendarDto dto) {
		String sql = " insert into calendar(id, title, content, rdate, wdate) "
				+ 	"	values(?, ?, ?, ?, now()) ";
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DatabaseConnection.getInstance();
			System.out.println("-----addCalendar ---- 1/3 success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getRdate());
			System.out.println("-----addCalendar ---- 2/3 success");
			
			count = psmt.executeUpdate();
			System.out.println("-----addCalendar ---- 3/3 success");

		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("-----addCalendar ---- fail");

		}finally {
			DbClose.close(psmt, conn, null);
		}
		return count > 0 ? true:false;
	}
	
	public boolean updateCalendar(CalendarDto dto) {
		String sql = " update calendar "
				+ 	"	set title=?, content=?, rdate=?, wdate=? "
				+	" where seq = ?";
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DatabaseConnection.getInstance();
			System.out.println("-----updateCalendar ---- 1/3 success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getRdate());
			psmt.setString(4, dto.getWdate());
			psmt.setInt(5, dto.getSeq());

			System.out.println("-----updateCalendar ---- 2/3 success");
			
			count = psmt.executeUpdate();
			System.out.println("-----updateCalendar ---- 3/3 success");

		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("-----updateCalendat ---- fail");

		}finally {
			DbClose.close(psmt, conn, null);
		}
		return count > 0 ? true:false;
	}
	
	public CalendarDto getCalender(int seq) {
		String sql = " select * from calendar where seq = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		CalendarDto dto = null;
		try {
			System.out.println("-----getCalender ---- 1/4 success");
			conn = DatabaseConnection.getInstance();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,  seq);
			System.out.println("-----getCalender ---- 2/4 success");
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				dto = new CalendarDto(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6)
						);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DbClose.close(psmt, conn, rs);
		}
		
		return dto;
	}
	
	public boolean deleteCalendar(CalendarDto dto) {
		String sql = " delete from calendar where seq = ? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			System.out.println("-----deleteCalendar ---- 1/3 success");
			conn = DatabaseConnection.getInstance();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,  dto.getSeq());
			System.out.println("-----deleteCalendar ---- 2/3 success");
			count = psmt.executeUpdate();
			System.out.println("-----deleteCalendar ---- 3/3 success");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return count >= 1 ?true:false;
	}
}
