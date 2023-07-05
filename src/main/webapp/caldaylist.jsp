<%@page import="util.CalendarUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

String rdate = CalendarUtil.two(year) + CalendarUtil.two(month) + CalendarUtil.two(day);
CalendarDao dao = CalendarDao.getInstance();
List<CalendarDto> list = new ArrayList<CalendarDto>();

list = dao.getCalendarListByYMD(login.getId(), rdate);

CalendarDto currentDto = null;

%>
<body>
	<h2>오늘의 일정</h2>
	<div class="container">
		<div class="tableDiv">
			<table border="1" class="table">
				<col width="70"/><col width="100"/>
				<tr>
					<th class="table-primary">일정</th>
					<td>
						<input type="date" name="date" id="date" readonly="true" disabled="true"/>&nbsp;
						<input type="time" name="time" id="time" readonly="true" disabled="true"/>&nbsp;
					</td>
				</tr>
				<tr>
					<th class="table-primary">일정명</th>
					<td>
						<input type="text" name="title" id="title" size="40" value="" readonly="true"/>
					</td>
				</tr>
				<tr>
					<th class="table-primary">내용</th>
					<td>
						<textarea name="content" id="content" cols="43" rows="15"  readonly="true"></textarea>
					</td>
				</tr>
			</table>
		</div>
		<div class="tableDiv">
			<table border="1" class="table2 table">
				<col width="200"/><col width="200"/> <!-- 시간, 제목 -->
				
				<tr>
					<th><h5 class="ms-3">일정 시간</h5></th>
					<th><h5 class="ms-3">일정 제목</h5></th>
				</tr>
				<% for(CalendarDto dto : list) { %>
					<tr class="mySchedule" seq="<%=dto.getSeq()%>">
						<td>
							<div class="time ms-2"><%= dto.getWdate() %></div>
						</td>
						<td>
							<div class="title ms-2"> <%= CalendarUtil.dot3(dto.getTitle()) %> </div>
						</td>
					</tr>
					<%} %>
			</table>
		</div>
	</div>
</body>
<script>
	$(".mySchedule").on("click", function(){
		console.log($(this).attr("seq"));
		$.ajax({
			  url: "showScheduleDetail.jsp",
			  method: "GET",
			  data: {
				  seq:$(this).attr("seq")
				  },
			  success: function(response) {
			    console.log(response);
			    let resJson = JSON.parse(response);
			    console.log(resJson);
			  	randerTable(resJson);
			  },
			  error: function(xhr, status, error) {
			    console.error(error)
			  }
			});
		let randerTable = (resJson)=>{
			let yyyymmdd = (resJson.wdate).slice(0, 10);
			let time = (resJson.wdate).slice(11, 19);
			$("#date").val(yyyymmdd);
			$("#time").val(time);
			$("#title").val(resJson.title);
			$("#content").val(resJson.content);
		}
	})
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
<style>
.container{
	display:flex;
	justify-content:center;
	align-items:start;
	flex-direction:row;
	flex-wrap: wrap;

}


.tableDiv{
	width:400px;
	margin:15px;
}
.table{
	min-width:300px;
}
.table2{
	margin-top:1.5em;
}
</style>
</html>