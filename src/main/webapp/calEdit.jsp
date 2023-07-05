<%@page import="dao.CalendarDao"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<%
UserDto login = (UserDto)session.getAttribute("login");
String seqS = request.getParameter("seq");
CalendarDao dao = CalendarDao.getInstance();
CalendarDto dto =  dao.getCalender(Integer.parseInt(seqS));

%>
<body>
	<h2>나의 일정</h2>
	<form action="calEditAf.jsp" method="get">
		<input type="hidden" name="seq" value="<%= seqS %>" />
		<table border="1">
			<col width="200"/><col width="500"/>
			<tr>
				<th>아이디</th>
				<td>
					<%=login.getId() %>
					<input type="hidden" name ="id" value = "<%=login.getId() %>">
				</td>
			</tr>
			<tr>
				<th>일정</th>
				<td>
					<input type="date" name="date" id="date" />&nbsp;
					<input type="time" name="time" id="time" />&nbsp;
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" size="80" value="<%=dto.getTitle() %>"/>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="content" id="content" cols="80" rows="20" ><%=dto.getContent() %></textarea>
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="submit" id="editBtn" value="수정 완료"/>
		</div>
	</form>
</body>
<script>
let wdate = "<%=dto.getWdate()%>";
/* console.log(wdate);
$("#date").val(wdate.slice(0, 10));

console.log(wdate.slice(0, 10));
$("#time").val(wdate.slice(11, 19));

console.log(wdate.slice(11, 19));

 */
</script>
</html>