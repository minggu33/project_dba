<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">


<%
String id = (String) session.getAttribute("id");
%>

<script type="text/javascript">
	function fun1() {
		history.back();
	}
</script>

</head>
<body>
	<h1>회원 탈퇴</h1>

	아이디 :
	<%=id%>
	<form action="deletePro.jsp" method="post">
		<input type="hidden" name="id" value="<%=id%>"> 
		<input type="password" name="pw"> <input type="submit" value="탈퇴하기">
		<input type="button" value="돌아가기 " onclick="fun1();">
	</form>

</body>
</html>