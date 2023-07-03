<%@page import="dto.UserDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int seq = Integer.parseInt(request.getParameter("seq"));
	BbsDao dao = BbsDao.getInstance();
	BbsDto dto = dao.getBbs(seq);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">

	<table border=1>
	<col width="200">	<col width="500">
	
	<tr>
		<th>작성자</th>
		<th><%=dto.getId() %></th>
	</tr>
	<tr>
		<th>작성일</th>
		<th><%=dto.getWdtate() %></th>
	</tr>
	<tr>
	<th>조회수</th>
		<th><%=dto.getReadCount() %></th>
	</tr>
	<tr>
	<th>제목</th>
		<th><%=dto.getContent() %></th>
	</tr>
	</table>
	
	<%
		UserDto login = (UserDto)session.getAttribute("login");
	%>
	<h2>답글</h2>
	<form action="answerAf.jsp?seq=<%=seq%>" method="post">
	<input type="hidden" name="seq" value="<%=dto.getSeq() %>"/>
	<table border="1">
		<col width="200"/><col width="500"/>
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" name="id" size="50" readonly="readonly" value="<%=login.getId()%>"/>
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="title" size="50" />
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="10" cols="50" name="content"></textarea>
			</td>
		</tr>
	</table>
	<tr>
		<td>
			<button>글쓰기</button>
		</td>
	</tr>
	</form>
</div>

</body>
</html> 