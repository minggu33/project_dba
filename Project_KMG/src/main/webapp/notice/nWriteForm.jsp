<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<style type="text/css">
.container{
	display: flex;
}


</style>

<jsp:include page="../header/header.jsp" />


<%

String nName = (String)session.getAttribute("nName");

if (nName == null) {
	nName = "";
}

if (!nName.equals("밍구스")) {
%>
<script type="text/javascript">

alert("관리자만 글쓰기가 가능합니다.");
history.back();

</script>
<%
}
%>
</head>
<body>
<div class="container">
<div class="item" style="width: 10%"></div>
<div class="item">
		<h1 style="margin-top: 10%; text-align: center;">게시판 글쓰기</h1>

		
			<form action="nWritePro.jsp" method="post" enctype="multipart/form-data">
			<div class="row">
<div class="col-md-6">
<div class="form-group">
<label for="nName">NAME</label>
<input type="text" class="form-control" name="nName" id="nName" placeholder="Enter name" value="<%=nName%>" readonly>
</div>
</div>
		<div class="col-md-6">
<div class="form-group">
<label for="pw">Password</label>
<input type="password" class="form-control" name="pw" id="pw" placeholder="Enter password">
</div>
</div>		
				<div class="form-group">
<label for="subject">Title</label>
<input type="text" class="form-control" name ="subject" id="subject" placeholder="Enter title" required>
</div>
				<div class="form-group">
<label for="content">Comment:</label>
<textarea class="form-control" rows="10" name="content" id="content" required></textarea> 
				<div class="form-group">
<label for="File">File</label>
<input type="file" id="File">
</div>
	<br>
				
<input type="submit" value="저장하기" class="btn btn-primary" style="margin: 0 auto;"> 
<input type="reset" value="다시쓰기" class="btn btn-primary" style="margin: 0 auto;"> 
<input type="button" value="Back" onclick="history.back(1)" class="btn btn-primary" style="margin: 0 auto;">

			</form>
	
</div>
<div class="item"></div>
</div>
</body>
</html>