<%@page import="dto.UserDto"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	UserDao dao = UserDao.getInstance();
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("userName");
	String email = request.getParameter("email");
	
	System.out.println(id + pwd + name + email);
	
	UserDto dto = new UserDto(id, pwd, name, email, 1);
	
	int result = dao.signUp(dto);
	if(result >= 1){
		%>
		<script>
			alert("회원가입 성공!");
			location.href = "bbslist.jsp";
		</script>
		<%
	}
	else{
		%>
		<script>
			alert("회원가입 실패!");
			location.href = "singUp.jsp";
		</script>
	<%
	}
	
%>
