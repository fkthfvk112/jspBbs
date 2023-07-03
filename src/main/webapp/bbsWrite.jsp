<%@page import="dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
UserDto mem = (UserDto)session.getAttribute("login");
%>
	<div align="center">
	<form id="frm" method="post">
		<table border="1">
		<col width="200"><col width="500">
		
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" name="id" size="50" value="<%=mem.getId() %>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" id="title" name="title" size="50" placeholder="제목을 기입">
			</td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="20" cols="50" id="content" name="content" placeholder="내용을 기입"></textarea>
			</td>
		</tr>
		
		</table>
		<br>
		<!-- <input type="submit" value="글쓰기"> -->
		<button type="button" class="writeBtn" onclick="confirm()">글쓰기</button>
	</form>
</div>
</body>
<script>
	const confirm = ()=>{
		if($("#title").val().length <= 5){
			alert("제목의 글자 수가 모자랍니다.")
			return
		}
		else if($("#content").val().length <= 5){
			alert("내용의 글자 수가 모자랍니다.")
			return
		}
		$("#frm").attr("action", "bbsWriteAf.jsp").submit();
	}
</script>
</html>
