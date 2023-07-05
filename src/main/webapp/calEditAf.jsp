<%@page import="util.CalendarUtil"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
String date = request.getParameter("date");
String time = request.getParameter("time");
String title = request.getParameter("title");
String content = request.getParameter("content");

UserDto login = (UserDto)session.getAttribute("login");
String seqS = request.getParameter("seq");
int seq = Integer.parseInt(seqS);

String year = CalendarUtil.one(date.substring(0, 4));
String month = CalendarUtil.one(date.substring(5, 7));

CalendarDao dao = CalendarDao.getInstance();



String rdate = date.replace("-", "") + time.replace(":", "");
String wdate = date + " " + time;


//public CalendarDto(int seq, String id, String title, String content, String rdate, String wdate) {
CalendarDto dto =  new CalendarDto(seq, id, title, content, rdate, wdate);


boolean isUpdated = false;
isUpdated = dao.updateCalendar(dto);
if(isUpdated){ %>
	<script>
		location.href="./calendarList.jsp?year=<%=year%>&month=<%=month%>";
	</script>
	<%
}else{ %>
	<script>
		alert("업데이트 실패!");
	</script>
<%
}

%>