<%@page import="util.CalendarUtil"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	String date = request.getParameter("date");
	String time = request.getParameter("time");
	
	String year = CalendarUtil.one(date.substring(0, 4));
	String month = CalendarUtil.one(date.substring(5, 7));
	
	date = date.replace("-", "");
	time = time.replace(":", "");
	
	String rdate = date + time;
	
	CalendarDao dao = CalendarDao.getInstance();
	boolean isS = dao.addCalendar(new CalendarDto(id, title, content, rdate));
	if(isS){
		%>
		<script>
		alert('일정이 추가되었습니다.');
		location.href = "calendarList.jsp?year=<%=year%>&month=<%=month%>";
		</script>
		<%
	}else{
		%>
		<script>
		alert('오류 : 일정이 추가되지 않았습니다.');
		location.href = "calendarList.jsp?year=<%=year%>&month=<%=month%>";
		</script>
		<%
	}
%>