<%@page import="util.BbsUtil"%>
<%@page import="java.util.List"%>
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

	String choice = request.getParameter("choice");
	String search = request.getParameter("search");
	
	if(choice == null){
		choice = "";
	}
	if(search == null){
		search = "";
	}
	//현재 페이지 넘버
	
	String sPageNumber = request.getParameter("pageNumber");
	int pageNumber = 0;
	if(sPageNumber != null && !sPageNumber.equals("")){
		pageNumber = Integer.parseInt(sPageNumber);
	}
	
	BbsDao dao = BbsDao.getInstance();
	List<BbsDto> list = dao.getBbsPageList(choice, search, pageNumber);
	
	//글의 총 수 
	int count = dao.getAllBbs(choice, search);
	
	//페이지 계산
	int pageBbs = count/10;// 1페이지에 10개의 게시글
	if(count %10 > 0){
		pageBbs = pageBbs + 1;
	}//나머지가 있으면 페이지 1개 추가
	
%>
<h1>게시판</h1>
<div align="center">
	<table border="1">
	<col width="70"/><col width="600"/><col width="100"/><col width="150"/>
	<thead>
		<th>번호</th>
		<th>제목</th>
		<th>조회수</th>
		<th>작성자</th>
	</thead>
		
		<tbody>
		<% if(list == null || list.size() == 0){ %>
			<tr>
				<td colspan="4">작성된 글이 없습니다.</td>
			</tr>
		<% } else{ %>
		<%	for(int i = 0; i < list.size(); i++){ 
			BbsDto bbs = list.get(i);
		%>
		<tr>
		    <td><%= i + 1 %></td>
		    <td><a href="bbsDetail.jsp?seq=<%=bbs.getSeq()%>">
		    	<%=BbsUtil.arrow(bbs.getDepth()) %>
		    	<span><%=BbsUtil.titleDot(bbs.getTitle()) %></span>
		    </a></td>
		    <td><%=bbs.getReadCount() %></td>
		    <td><%=bbs.getId() %></td>
		</tr>
		<% }
		}
		%>
		</tbody>
	</table>
	<br />
	<%
	
		for(int i = 0; i < pageBbs; i++){
			if(pageNumber == i){//현재 페이지
				%>
				<span style="font-size:15px; color:blue; font-weight: bold;"><%=i+1%></span>
				<%
			}
			else{//이외
				%>
				<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i%>)" style="color:black; font-weight:bold;">
					<span style="font-size:15px;">[<%=i+1%>]</span>
				</a>
				<%
			}
		}
	%>
	
	<form>
		<select id="choice" name="choice" value="<%=choice %>">
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="writer">작성자</option>
		</select>
		<input type="text" id="search" name="search" value="<%=search%>"/>
		<button onclick="searchBtn()">검색</button>
	</form>
	<% if(session.getAttribute("login") != null){ %> 
		<a href="bbsWrite.jsp">글쓰기</a>
	<% } %>
</div>
<script>
//Java -> Js
let search = "<%=search%>";
if(search != ""){
	let obj = document.querySelector("#choice");
	obj.value = "<%=choice%>";
	obj.setAttribute("selected", "selected");
}

function searchBtn() {
    let choice = document.querySelector("#choice").value;
    let search = document.querySelector("#search").value;

    if (choice.trim() === "") {
        alert("카테고리를 선택해주세요.");
        return;
    }

    if (search.trim() === "") {
        alert("검색어를 입력해주세요.");
        return;
    }

    location.href = "bbslist.jsp?choice=" + choice + "&search=" + search;
}

function goPage(pageNum){
    let choice = document.querySelector("#choice").value;
    let search = document.querySelector("#search").value;
	
    location.href = "bbslist.jsp?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
}
</script>


</body>
<style>
	a{
		text-decoration: none;
		color:black;
	}
</style>
</html>
