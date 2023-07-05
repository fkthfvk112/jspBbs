<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String seq_s = request.getParameter("seq");
String userId = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

int seq = Integer.parseInt(seq_s);
BbsDao dao = BbsDao.getInstance();
BbsDto dto = new BbsDto(userId, title, content);

int count = dao.updateBbs(dto, seq);

if(count != 0){
%>
<script>
alert("수정 성공");
location.href = "bbsDetail.jsp?seq=<%=seq%>";
</script>
<% }else{%>
<script>
alert("수정 실패");
</script>
<%} %>