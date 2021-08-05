<%@page import="com.nbk.member.MemberDAO"%>
<%@page import="com.nbk.member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">

<style type="text/css">
.project_kmg_join {
	display: block!important;
}

.project_kmg_join div {
	margin: 0 auto;
}

</style>

<%
String id = (String) session.getAttribute("id");

System.out.println(id);
MemberDAO mdao = new MemberDAO();

MemberBean mb = null;

mb = mdao.updateBf(id);
%>





</head>
<body>
	
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../header/header.jsp" />

		<!-- 헤더들어가는 곳 -->
	<br>
			<h1 align="center">회원정보 수정</h1>
		
					<form class="row g-3 project_kmg_join" action="updatePro.jsp" method="post" name="fr" id="fr">
					  <div class="col-md-2">
					    <label for="id1" class="form-label">아이디</label>
					    <input type="text" class="form-control" id="id1" name="id" value="<%=mb.getId()%>" readonly>
					  <div class="check_font" id="id_check"></div>
					  </div>
					  <div class="col-md-2">
					    <label for="pw" class="form-label">비밀번호</label>
					    <input type="password" class="form-control" id="pw" name="pw">
					  </div>
					  <div class="col-md-2">
					    <label for="name" class="form-label">이름</label>
					    <input type="text" class="form-control" id="name" name="name" value="<%=mb.getName()%>">
					  </div>
					  <div class="col-md-2">
					    <label for="age" class="form-label">나이</label>
					    <input type="number" class="form-control" id="age" name="age">
					  </div>
					  <div class="col-md-2">
					    <label for="email" class="form-label">이메일</label>
					    <input type="email" class="form-control" id="email" name="email" value="<%=mb.getEmail()%>">
					  </div>
					  <div class="col-md-2">
					    <label for="nName" class="form-label">닉네임</label>
					    <input type="text" class="form-control" id="nName" name="nName" value="<%=mb.getnName()%>" readonly>
					  </div><br>
					 
					  <div class="col-md-2">
					    <label for="phone" class="form-label">전화번호</label>
					    <input type="text" class="form-control" id="phone" name="phone" value="<%=mb.getPhone()%>">
					  </div>
					  <br>
					<div class="col-3" style="margin:0 auto;">
					   <input type="submit" id="submit" value="정보수정" class="btn btn-primary">
				 		<button class="btn btn-primary" type="button" onclick="location.href='deleteForm.jsp?id=<%=id %>'" >회원 탈퇴</button>
					 </div>		 
			</form>



</body>
</html>