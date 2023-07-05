<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
int seq = Integer.parseInt(request.getParameter("seq"));
BbsDao dao = BbsDao.getInstance();
BbsDto dto = dao.getBbs(seq);
dao.deleteBbs(seq);
%>

<script>
location.href = "bbslist.jsp";
</script>