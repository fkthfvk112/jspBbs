<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<div class="container view">
	<h1>회원가입</h1>
	<div class="card cardView">
		<form action="signUpAf.jsp" id="siginUpForm" method="post">
			<div class="mb-3">
				<label for="userId" class="form-label">아이디</label>
				<input type="text" class="form-control" id="userId" placeholder="아이디를 입력하세요" name="id">
				<button type="button" class="btn btn-light check" onclick="checkId() ">ID 체크</button>
				<input type="checkbox" id="idCheckBox" disabled  />
			</div>

			<div class="mb-3">
				<label for="password" class="form-label">비밀번호</label>
				<input type="password" class="form-control" id="password" placeholder="비밀번호를 입력하세요" name="pwd">
			</div>
			<div class="mb-3">
				<label for="passwordValid" class="form-label">비밀번호 확인</label>
				<input type="password" class="form-control" id="passwordValid" placeholder="비밀번호를 입력하세요">
			</div>
			<div class="mb-3">
				<label for="username" class="form-label">이름</label>
				<input type="text" class="form-control" id="username" placeholder="사용자명을 입력하세요" name="userName">
			</div>
			<div class="mb-3">
				<label for="userEmail" class="form-label">이메일</label>
				<input type="text" class="form-control" id="userEmail" placeholder="이메일을 입력하세요" name="email">
			</div>
			<div class="btnDiv">
				<button type="button" class="btnConfirm btn btn-primary">회원가입</button>
			</div>
		</form>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
<script>
$(".btnConfirm").on("click", ()=>{
	//비밀번호 검사
	if($("#password").val() != $("#passwordValid").val()){
		alert("비밀번호를 확인해주세요! 비밀번호 불일치!");
		return;
	}
	if($("#password").val().length <= 5){
		alert("비밀번호가 너무 짧습니다.");
		return;
	}
	
	//아이디 검사
	if (!$("#idCheckBox").is(":checked")){
		alert("아이디를 검사해주세요.");
		return;
	}
	
	if($("#username").val().length <= 3){
		alert("유저 이름이 너무 짧습니다. (3글자 이상)");
		return;
	}
	
	
	//이메일 검사
	let isEmail = $("#userEmail").val().includes("@");
	if(!isEmail){
		alert("이메일 형식이 아닙니다.");
		return;
	}
	$("#siginUpForm").submit();
	
})

function idChecked(valid){
	if(valid == "nonValid") return false;
	else true;
}

function checkId(){
	$.ajax({
		url: 'checkId.jsp',
		method: 'POST',
		data: {
			id:$("#userId").val()
		},
		success: function(response) {
			console.log(response);
			if(response.trim() == "nonValid"){
				alert("사용 불가능한 아이디입니다.");
				$("#idCheckBox").prop("checked", false);
			}
			else{
				alert("사용 가능한 아이디입니다.");
				$("#idCheckBox").prop("checked", true);
			}
		},
		error: function(xhr, status, error) {
			alert("오류!");
		}
	});
}
</script>
<style>
	body{
		background-image: url("./images/loginBackground.png");
		background-repeat: no-repeat;
		background-position: center;
		background-size: cover;
	
	}
	.view{
		padding: 2em;
		margin: 2em;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	.cardView {
		padding: 2em;
		margin: 2em;
		min-width:300px;
	}
	
	.btnDiv{
		text-align:center;
	}
	
	.check{
		font-size:5px;
	}

</style>
</html>

