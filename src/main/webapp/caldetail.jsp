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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

<%
UserDto login = (UserDto)session.getAttribute("login");
String seqS = request.getParameter("seq");
CalendarDao dao = CalendarDao.getInstance();
CalendarDto dto =  dao.getCalender(Integer.parseInt(seqS));
%>
<body>
	<h2>나의 일정</h2>
	<div class="tableContainer">
		<form>
			<table border="1" class="table">
				<col width="80"/><col width="500"/>
				<tr>
					<td class="p-2" colspan="2" align="center">
						Hello, <%=login.getId() %>
						<input type="hidden" name ="id" value = "<%=login.getId() %>">
					</td>
				</tr>
				<tr>
					<th class="table-primary">일정</th>
					<td>
						<input type="date" name="date" id="date" readonly="true" disabled="true"/>&nbsp;
						<input type="time" name="time" id="time" readonly="true" disabled="true"/>&nbsp;
					</td>
				</tr>
				<tr>
					<th class="table-primary">제목</th>
					<td>
						<div class="m-2"><%=dto.getTitle() %></div>
						<input type="hidden" name="title" size="75" value="<%=dto.getTitle() %>" readonly="true"/>
					</td>
				</tr>
				<tr>
					<th class="table-primary">내용</th>
					<td>
						<div class="m-2"><%=dto.getContent() %></div>
						<input type="hidden" name="title" size="75" value="<%=dto.getContent() %>" readonly="true"/>
						
					</td>
				</tr>
			</table>
			<div align="center">
				<input type="button" id="editBtn" value="수정"/>
				<input type="button" id="deleteBtn" value="삭제"/>
			</div>
		</form>
	</div>
</body>
<script>
let wdate = "<%=dto.getWdate()%>";
console.log(wdate);
$("#date").val(wdate.slice(0, 10));
$("#time").val(wdate.slice(11, 19));

$("#editBtn").on("click", ()=>{
	location.href ="./calEdit.jsp?seq=<%= seqS%>";
})

$("#deleteBtn").on("click", ()=>{
	location.href ="./calDeleteAf.jsp?seq=<%= seqS%>";
})
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
<style>
.tableContainer{
	display:flex;
	justify-content:center;
	align-items:start;
	flex-direction:row;
}

.tableContainer th {
  text-align: center;
}

</style>
</html>