<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
	
	<jsp:include page="../header/header.jsp" />
	
	<style type="text/css">
.container{
	display: flex;
}


</style>
	
	
<body>


<div class="container">
<div class="item" style="width: 40%"></div>

<div class="item">
<form action="mailSend.jsp" method="post">



<input type="hidden" class="form-control" name="sender" id="sender" placeholder="Enter name" value="kmg3167@gmail.com" readonly>


		<div class="col-md-12">
<div class="form-group">
<label for="receiver">받는사람 메일</label>
<input type="text" class="form-control" name="receiver" id="receiver" placeholder="받는사람 메일">
</div>
</div>		
				<div class="form-group">
<label for="subject">제목</label>
<input type="text" class="form-control" name ="subject" id="subject" placeholder="Enter title" required>
</div>
				<div class="form-group">
<label for="content">내용</label>
<textarea class="form-control" rows="10" name="content" id="content" required></textarea> </div>

<br>
<input type="submit" value="메일 보내기" class="btn btn-primary" style="margin: 0 auto;"> 


</form>



</div>
</div>
<div class="item"></div>


</body>
</html>