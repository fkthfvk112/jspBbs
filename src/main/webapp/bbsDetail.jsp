<%@page import="dto.UserDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int seq = Integer.parseInt(request.getParameter("seq"));
	BbsDao dao = BbsDao.getInstance();
	BbsDto dto = dao.getBbsAll(seq);
	if(dto.getDel() == 1) {
		System.out.println("삭제된 글" + dto.getDel());
%>
<script>
	alert("삭제된 글입니다.");
	location.href = "bbslist.jsp";
</script>
<%
	}
%>
<div align="center">
	제목: <div><%=dto.getTitle() %></div>
	아이디: <div><%=dto.getId() %></div>
	내용: <div><%=dto.getContent() %></div>
	
	<br />
	<button type="button" onclick="answerBbs(<%=dto.getSeq()%>)">답글</button>

<%

UserDto user = (UserDto)request.getSession().getAttribute("login");
if(user!=null&&user.getId().equals(dto.getId())){
%>
	<button type="button" onclick="updateBbs(<%=dto.getSeq()%>)">수정</button>
	<button type="button" onclick="deleteBbs(<%=dto.getSeq()%>)">삭제</button>
<%
}

%>

</div>
<script>
	function answerBbs(seq){
		location.href = "answer.jsp?seq=" + <%=seq%>;
	}
	
	function updateBbs(seq){
		location.href = "update.jsp?seq=" + <%=seq%>;
	}
	
	function deleteBbs(seq){
		location.href = "delete.jsp?seq=<%=seq%>";

	}

</script>

</body>
</html>