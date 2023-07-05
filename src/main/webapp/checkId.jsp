<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
response.setCharacterEncoding("UTF-8");

UserDao dao = UserDao.getInstance();
String s_id = request.getParameter("id");
System.out.println("s_id " + s_id);

boolean result = dao.validId(s_id);
System.out.println("s_id " + result);

if(result){
	out.println("valid");
}else{
	out.println("nonValid");
}

%>