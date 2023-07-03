<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userId = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

BbsDao dao = BbsDao.getInstance();
BbsDto dto = new BbsDto(userId, title, content);

int complete = dao.bbsWrite(dto);

if(complete > 0){
%>
<script>
	alert("글이 추가 되었습니다.");
	location.href = 'bbslist.jsp';
</script>
<% }else{ %>
<script>
alert("실패");
</script>
<%} %>
<%
%>
