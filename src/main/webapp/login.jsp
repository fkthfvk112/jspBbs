<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
</head>
<body>
<div class="container">
	<div class="card m-3 p-3 cardView" align="center">
		<form action="loginAf.jsp" method="post">
			<h2>Log In</h2>
			<input class="mb-2 mt-3" type="text" name="id" placeholder="Id"/>
			<br />
			<input class="mb-3" type="password" name="pwd" placeholder="Password"/>
			<br />
			<button class="btn btn-primary">로그인</button>
			<button class="btn btn-primary" type="button" onclick="signUp()">회원가입</button>
		</form>
	</div>
</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>

</body>
<script>
	function signUp(){
		location.href = "signUp.jsp";
	}
</script>
<style>
	body{
		background-image: url("./images/loginBackground.png");
		background-repeat: no-repeat;
		background-position: center;
		background-size: cover;
	
	}
	.container{
		margin-top:80px;
		display: flex;
		justify-content: center;
		align-items: center;
		flex-direction: column;
	}
	.cardView {
		width:300px;
	}

</style>
</html>
