<%@page import="dto.UserDto"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	response.setCharacterEncoding("UTF-8");
	String inputId = request.getParameter("id");
	String inputPwd = request.getParameter("pwd");
	UserDao dao = UserDao.getInstance();
	UserDto dto = dao.login(inputId, inputPwd);
	if(dto == null){
		pageContext.forward("login.jsp");
		System.out.println("login fail");
	}
	else{
		System.out.println("login success");
		session.setAttribute("login", dto);
		response.sendRedirect("bbslist.jsp");
	}
	
%>