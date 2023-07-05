package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DatabaseConnection;
import db.DbClose;
import dto.BbsDto;

public class BbsDao {
	private static BbsDao bbsDao = null;
	private BbsDao() {};
	
	public static BbsDao getInstance() {
		if(bbsDao == null) {
			bbsDao = new BbsDao();
		}
		return bbsDao;
	}
	
	public int bbsWrite(BbsDto dto) {
		
		String sql = " 	insert into bbs(id, ref, step, depth, "
				+ "						title, content, wdate, del, readcount) "
				+ " 	values(?, (select ifnull(max(ref), 0)+1 from bbs b), 0, 0, "
				+ "						?, ?, now(), 0, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DatabaseConnection.getInstance();
			System.out.println("............bbswrite 1/3");
			System.out.println(dto.getId());
			System.out.println(dto.getTitle());
			System.out.println(dto.getContent());
			
			psmt = conn.prepareStatement(sql);


			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			
			
			System.out.println("............bbswrite 2/3");

			count = psmt.executeUpdate();
			System.out.println("............bbswrite 3/3");
		}
		catch(Exception e) {
			System.out.println("에러 : " + e);
		}
		finally{
			DbClose.close(psmt, conn, null);
		}

		System.out.println("카운트" + count);
		return count;
	}
	public BbsDto getBbsAll(int seq) {
		String sql = "select * from bbs where seq=?";
		Connection conn = DatabaseConnection.getInstance();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		BbsDto dto = null;
		
		try {
			System.out.println("............getBbsAll 1/3");
			psmt = conn.prepareStatement(sql);
			System.out.println("............getBbsAll 2/3");
			psmt.setInt(1, seq);
			rs = psmt.executeQuery();
			System.out.println("............getBbsAll 3/3");
			
			if(rs.next()) {
				dto = new BbsDto(rs.getInt("seq"), rs.getString("id"), rs.getInt("ref"), rs.getInt("step"),
						rs.getInt("depth"), rs.getString("title"), rs.getString("content"),
						rs.getString("wdate"), rs.getInt("del"), rs.getInt("readCount"));
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		return dto;
	}
	public BbsDto getBbs(int seq) {
		String sql = "select * from bbs where seq=?";
		Connection conn = DatabaseConnection.getInstance();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		BbsDto dto = null;
		
		try {
			System.out.println("............getBbs 1/3");
			psmt = conn.prepareStatement(sql);
			System.out.println("............getBbs 2/3");
			psmt.setInt(1, seq);
			rs = psmt.executeQuery();
			System.out.println("............getBbs 3/3");

			if(rs.next()) {
				//public BbsDto(String id, String title, String content) {
				dto = new BbsDto(rs.getString("id"),  rs.getString("title"), rs.getString("content"));
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		return dto;
	}
	
	public List<BbsDto> getBbsList(){
		String sql = " select seq, id, ref, step ,depth, title, content, wdate, del, readcount "
				+ " from bbs "
				+ " order by ref desc, step asc ";
		Connection conn = DatabaseConnection.getInstance();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println("execute Query complete");
			while(rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1),
						rs.getString(2),
						rs.getInt(3),
						rs.getInt(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getInt(9),
						rs.getInt(10)
						);
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("error : " + e);
			e.printStackTrace();
		} finally {
			DbClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	public List<BbsDto> getBbsSearchList(String choice, String search){
		String sql = " select seq, id, ref, step ,depth, title, content, wdate, del, readcount "
				+ " from bbs ";
		
		if(choice.equals("title")) {
			sql += " where title like '%" + search + "%' ";
		}
		else if(choice.equals("content")) {
			sql += " where content like '%" + search + "%' ";

		}
		else if(choice.equals("writer")) {
			sql += " where id= '" + search + "' ";
		}
		sql += " order by ref desc, step asc ";
		
		Connection conn = DatabaseConnection.getInstance();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println("execute Query complete");
			while(rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1),
						rs.getString(2),
						rs.getInt(3),
						rs.getInt(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getInt(9),
						rs.getInt(10)
						);
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("error : " + e);
			e.printStackTrace();
		} finally {
			DbClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	/* 페이징 구현 */
	public int getAllBbs(String choice, String search) {
		String sql = " select count(*) from bbs";
		if(choice.equals("title")) {
			sql += " where title like '%" + search + "%' ";
		}
		else if(choice.equals("content")) {
			sql += " where content like '%" + search + "%' ";

		}
		else if(choice.equals("writer")) {
			sql += " where id= '" + search + "' ";
		}

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		try {
			conn = DatabaseConnection.getInstance();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbClose.close(psmt, conn, rs);
		}
		
		return count;
	}
	
	public List<BbsDto> getBbsPageList(String choice, String search, int pageNumber){
		
		String sql = " select seq, id, ref, step ,depth, title, content, wdate, del, readcount "
				+ " from bbs ";
		
		if(choice.equals("title")) {
			sql += " where title like '%" + search + "%' ";
		}
		else if(choice.equals("content")) {
			sql += " where content like '%" + search + "%' ";

		}
		else if(choice.equals("writer")) {
			sql += " where id= '" + search + "' ";
		}
		sql += " order by ref desc, step asc ";
		
		sql += " limit " + (pageNumber * 10) + ", 10";
		
		Connection conn = DatabaseConnection.getInstance();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println("execute Query complete");
			while(rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1),
						rs.getString(2),
						rs.getInt(3),
						rs.getInt(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getInt(9),
						rs.getInt(10)
						);
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("error : " + e);
			e.printStackTrace();
		} finally {
			DbClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	public void answerUpdate(int seq) {
		String sql = " update bbs "
				+ "	set step=step+1"//스탭 1씩 추가
				+ " where ref=(select ref from (select ref from bbs a where seq=?) A) "//seq가 같을 경우 ref선택
				+ " 	and step > (select step from (select step from bbs b where seq=?) B) ";//현재 작성하는 답글의 step보다 큰 경우
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		conn = DatabaseConnection.getInstance();
		
		try {
			psmt = conn.prepareStatement(sql);
			System.out.println("answerupdate 1/6 ... success");
			
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			psmt.executeUpdate();
			System.out.println("answerupdate 2/6 ... success");
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbClose.close(psmt, conn, null);
		}
	}
	
	public boolean answerInsert(int seq, BbsDto dto) {
	    String sql = "insert into bbs(id, ref, step, depth, title, content, wdate, del, readcount) "
	            + "values (?, (select ref from bbs a where seq=?), (select step from bbs b where seq=?)+1, "
	            + "(select depth from bbs c where seq=?)+1, ?, ?, now(), 0, 0)";
	    int count = 0;
	    Connection conn = null;
	    PreparedStatement psmt = null;

	    conn = DatabaseConnection.getInstance();

	    try {
	        psmt = conn.prepareStatement(sql);
	        psmt.setString(1, dto.getId());
	        psmt.setInt(2, seq);
	        psmt.setInt(3, seq);
	        psmt.setInt(4, seq);
	        psmt.setString(5, dto.getTitle());
	        psmt.setString(6, dto.getContent());
	        System.out.println("answerInsert 5/6 ... success");

	        count = psmt.executeUpdate();
	        System.out.println("answerInsert 6/6 ... success");

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DbClose.close(psmt, conn, null);
	    }

	    return count > 0 ? true : false;
	}
	
	public int deleteBbs(int seq) {
        System.out.println("delete 1/3 ... success");

		String sql = "update bbs set del = 1 where seq = ?";
	    Connection conn = null;
	    PreparedStatement psmt = null;
	    conn = DatabaseConnection.getInstance();
        System.out.println("delete 2/3 ... success");
        int count = 0;
        
	    try {
	    	psmt = conn.prepareStatement(sql);
	    	psmt.setInt(1, seq);
            count = psmt.executeUpdate();
            System.out.println("delete 3/3 ... success");

	    }
	    catch (Exception e) {
	        System.out.println("delete Error" + e);
		}
	    
	    return count;
	}
	
	public int updateBbs(BbsDto dto, int seq) {
		
	    String sql = "UPDATE bbs "
	            + "SET title = ?, content = ? "
	            + "WHERE seq = ?";
	    int result = 0;

	    Connection conn = null;
	    PreparedStatement psmt = null;
	    conn = DatabaseConnection.getInstance();

	    try {
	        psmt = conn.prepareStatement(sql);
	        System.out.println("updateBbs 1/2 ... success");

	        psmt.setString(1, dto.getTitle());
	        psmt.setString(2, dto.getContent());
	        psmt.setInt(3, seq);
	        result = psmt.executeUpdate();
	        System.out.println("updateBbs 2/2 ... success");
	    } catch (Exception e) {
	        System.out.println(e);
	    } finally {
	        DbClose.close(psmt, conn, null);
	    }
	    return result;
	}

	
}
