<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<script src="../js/jquery-3.6.0.js" ></script>
<style>

.log{
	float: right;
}

</style>


</head>
<body>
<header>

<%
		String nName = (String)session.getAttribute("nName");
		
if(nName == null){
	nName="";
}
	if(nName.equals("")){
%>

<div class="log">
<button class="btn login" onclick="location.href='../member/login.jsp'">login</button>  
<button class="btn join" onclick="location.href='../member/join.jsp'">join</button>
</div>

<% 
	}else{
%>
<div class="log">
<a class="btn"><%=nName %> 님 환영합니다!</a>
<button class="btn" onclick="location.href='../member/update.jsp'">개인정보 수정</button>
<button class="btn" onclick="location.href='../member/logout.jsp'">Logout</button> 
<% 
	}
%>
</div>
<br><br>

<!-- The navigation menu -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="../company/welcome.jsp">HOME</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon" id="navbarText"></span>
    </button>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0" >
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="../notice/notice.jsp">Notice</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../map/map.jsp">Map for playground</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../board/list.jsp">Board</a>
        </li>
        <%if(nName.equals("밍구스")){ %>
        <li class="nav-item" id="navbarText">
          <a class="nav-link" href="../contact/mailForm.jsp">Mail</a>
        </li>
        <%
        } 
        %>
      </ul>
      <span class="navbar-text">
        Welcome to DBA
      </span>
    </div>
  </div>
</nav>


</header>

</body>
</html>