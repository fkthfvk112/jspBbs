<%@page import="dto.UserDto"%>
<%@page import="util.CalendarUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	
	month = CalendarUtil.two(month);
	day = CalendarUtil.two(day);
	UserDto login = (UserDto)session.getAttribute("login");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>일정추가</h2>
	<form action="calwriteAf.jsp" method="post">
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
					<input type="text" name="title" size="80" />
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="content" id="content" cols="80" rows="20"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="일정추가"/>
				</td>
			</tr>
		</table>
	</form>
<script>
let year = "<%=year %>";
let month = "<%=month %>";
let day = "<%=day %>";

//2023-07-05
document.querySelector("#date").value = year + "-" + month + "-" + day;

let d = new Date();
document.querySelector("#time").value = d.getHours() + ":" + d.getMinutes();
</script>
</body>
</html>