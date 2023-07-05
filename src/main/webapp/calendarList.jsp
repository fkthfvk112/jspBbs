<%@page import="dto.UserDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CalendarDao"%>
<%@page import="util.CalendarUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="dto.CalendarDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserDto userDto = (UserDto)session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

<body>
<%
	Calendar cal = Calendar.getInstance();
	cal.set(Calendar.DATE, 1);//현재 월을 1일로 맞춰준다.
	
	String syear = request.getParameter("year");
	String smonth = request.getParameter("month");
	
	//현재 연도 구함 (처음 페이지 세팅)
	int year = cal.get(Calendar.YEAR);
	if(CalendarUtil.nvl(syear) == false){//파라미터 값 존재
		year = Integer.parseInt(syear);
	}
	
	int month = cal.get(Calendar.MONTH + 1);
	if(CalendarUtil.nvl(smonth) == false){//파라미터 값 존재
		month = Integer.parseInt(smonth);
	}
	
	if(month < 1){
		month = 12;
		year--;
	}
	
	if(month > 12){
		month = 1;
		year++;
	}
	
	cal.set(year, month-1, 1);
	
	//요일
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	String pY = String.format("<a href='calendarList.jsp?year=%d&month=%d' style='font-size:30px; color:black; text-decoration:none'>"
							+ "<span>◀</span>"
							+ "</a>", year-1, month);
	
	String nY = String.format("<a href='calendarList.jsp?year=%d&month=%d' style='font-size:30px; color:black; text-decoration:none'>"
			+ "<span>▶</span>"
			+ "</a>", year+1, month);
	
	
	String pM = String.format("<a href='calendarList.jsp?year=%d&month=%d' style='font-size:30px; color:black; text-decoration:none'>"
			+ "<span>◁</span>"
			+ "</a>", year, month-1);
	
	String nM = String.format("<a href='calendarList.jsp?year=%d&month=%d' style='font-size:30px;color:black; text-decoration:none'>"
			+ "<span>▷</span>"
			+ "</a>", year, month+1);
	
	CalendarDao dao = CalendarDao.getInstance();
	List<CalendarDto> list = dao.getCalendarList(userDto.getId(), year + CalendarUtil.two(month + ""));
	
%>
<div align="center" class="tableDiv">
	<table border=1 class='table'>
		<col width="120"/><col width="120"/><col width="120"/><col width="120"/><col width="120"/><col width="120"/><col width="120"/>
		<tr height="80">
			<td colspan="7" align="center">
				<%=pY %>&nbsp<%=pM %>&nbsp
					<font style="color:#3c3c3c; font-size:40px; font-family:fantasy;">
						<%=String.format("%d년&nbsp;&nbsp;%2d월", year, month) %>
					</font>
				&nbsp<%=nM %>&nbsp<%=nY %>
			</td>
		</tr>
		<tr height="30" style="background-color:#8ecae6; color:white;";>
			<th class="table-info">sun</th>
			<th class="table-info">mon</th>
			<th class="table-info">the</th>
			<th class="table-info">wen</th>
			<th class="table-info">thu</th>
			<th class="table-info">pri</th>
			<th class="table-info">sat</th>
		</tr>
		<tr height="120" align="left" valign="top">
			<%
			for(int i = 1; i < dayOfWeek; i++){
			%>
			
			<td style="background-color:#eeeeee">&nbsp;</td>
			<%
			}
			//날짜
			int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			for(int i = 1; i <= lastday; i++){
			%>

			<td style="color:#3c3c3c; padding-top:5px">
				<%=CalendarUtil.daylist(year, month, i) %>&nbsp;&nbsp;<%=CalendarUtil.calwrite(year, month, i) %>
				<%=CalendarUtil.makeTable(year, month, i, list) %>
			</td>	
			<%
				if((i + dayOfWeek -1)%7 ==0 && i != lastday){
					%>
					</tr><tr height="120" align="left" valign="top">
					<%
				}
			}
			
			cal.set(Calendar.DATE, lastday);//아래쪽 빈칸을 추가하기 위해 마지막 날짜로 설정
			int weekday = cal.get(Calendar.DAY_OF_WEEK);
			for(int i = 0;i < 7 - weekday; i++){
			%>
			<td style="background-color:#eeeeee">&nbsp;</td>
			<%
			}
			%>
		</tr>
	</table>
</div>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<style>
	.tableDiv {
	  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2), 0 4px 8px rgba(0, 0, 0, 0.1);
	  margin:5em;
	  padding:2em;
	}
</style>
</html>