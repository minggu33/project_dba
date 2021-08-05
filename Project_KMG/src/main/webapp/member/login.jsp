<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">

<style type="text/css">
.container{
	text-align: center;
	padding-top: 10%;
}

</style>
<script type="text/javascript">
function fun(){
	
	if(document.lgfr.id.value==""){
		alert('아이디를 입력하시오.');
		document.lgfr.id.focus();

		return false;
	}
	
	if(document.lgfr.pw.value==""){
		alert('비밀번호를 입력하시오.');
		document.lgfr.pw.focus();
		return false;
	}
	
	
}



</script>




</head>
<body>

		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../header/header.jsp" />

	
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->
<div class="container">
    <div class="row">
		<div class="span12">
			<form class="form-horizontal" name="lgfr" action='loginPro.jsp' method="post">
			  <fieldset>
			    <div id="legend">
			      <legend class="">Login</legend>
			    </div>
			    <div class="control-group">
			      <!-- Username -->
			      <label class="control-label"  for="username">UserID</label>
			      <div class="controls">
			        <input type="text" id="id" name="id" placeholder="" class="input-xlarge">
			      </div>
			    </div>
			    <div class="control-group">
			      <!-- Password-->
			      <label class="control-label" for="password">Password</label>
			      <div class="controls">
			        <input type="password" id="pw" name="pw" placeholder="" class="input-xlarge">
			      </div>
			    </div>
			    <div class="control-group">
			      <!-- Button -->
			      <div class="controls">
			      <br>
			        <button class="btn btn-success" type="submit" onclick="return fun()">Login</button>
			        <button class="btn btn-success" type="button" onclick="location.href='join.jsp'">회원가입</button>
			      </div>
			    </div>
			  </fieldset>
			</form>
		</div>
	</div>
</div>


	
	<script src="../js/jquery-3.6.0.js"></script>
</body>
</html>