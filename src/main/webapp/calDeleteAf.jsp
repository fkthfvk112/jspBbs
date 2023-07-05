<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String seqS = request.getParameter("seq");
int seq = Integer.parseInt(seqS);
CalendarDao dao = CalendarDao.getInstance();
CalendarDto dto = dao.getCalender(seq);

boolean isDeleted = dao.deleteCalendar(dto);
if(isDeleted){ %>
	<script>
		alert("삭제 완료!");
		location.href="./calendarList.jsp";
	</script>
<%	
}
else{ %>
	<script>
		alert("삭제 실패!");
		location.href="./calendarList.jsp";
	</script>
<%
}

%>
