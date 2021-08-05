<%@page import="com.nbk.nboard.NBoardBean"%>
<%@page import="com.nbk.nboard.NBoardDAO"%>
<%@page import="com.nbk.board.BoardBean"%>
<%@page import="com.nbk.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">

<jsp:include page="../header/header.jsp" />

<style type="text/css">
.container{
	display: flex;
}

</style>

</head>
<body>
	<%
	String nName = (String) session.getAttribute("nName");

	int num = Integer.parseInt(request.getParameter("num"));

	String pageNum = request.getParameter("pageNum");

	NBoardDAO ndao = new NBoardDAO();

	NBoardBean nb = ndao.getNBoard(num);
	%>


<div class="container">
<div class="item" style="width: 10%"></div>
<div class="item">
		<h1 style="margin-top: 10%; text-align: center;">글 수정하기</h1>

		
			<form action="nUpdatePro.jsp?pageNum=<%=pageNum%>" method="post">
			<div class="row">
<div class="col-md-6">
<div class="form-group">
<label for="nName">NAME</label>
<input type="text" class="form-control" name="nName" id="nName" placeholder="Enter name" value="<%=nName%>" readonly>
</div>
</div>
		<div class="col-md-6">
		<input type="hidden" name="num" value="<%=nb.getNum()%>">

</div>		
				<div class="form-group">
<label for="subject">Title</label>
<input type="text" class="form-control" name ="subject" id="subject" placeholder="Enter title" value="<%=nb.getSubject()%>" required>
</div>
				<div class="form-group">
<label for="content">Comment</label>
<textarea class="form-control" rows="10" name="content" id="content"  required><%=nb.getContent()%></textarea> 

	<br>
				
<input type="submit" value="수정하기" class="btn btn-primary" style="margin: 0 auto;"> 
<input type="reset" value="다시쓰기" class="btn btn-primary" style="margin: 0 auto;"> 
<input type="button" value="Back" onclick="history.back(1)" class="btn btn-primary" style="margin: 0 auto;">

			</form>
	
</div>
<div class="item"></div>
</div>	


</body>
</html>