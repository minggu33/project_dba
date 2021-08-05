<%@page import="com.nbk.ncmt.NCmtBean"%>
<%@page import="com.nbk.ncmt.NCmtDAO"%>
<%@page import="com.nbk.cmt.CmtBean"%>
<%@page import="com.nbk.cmt.CmtDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<div id="wrap">
<jsp:include page="../header/header.jsp" />

</head>
<body>
	<%
	int num = Integer.parseInt(request.getParameter("num"));

	int b_num = Integer.parseInt(request.getParameter("b_num"));

	NCmtDAO ncdao = new NCmtDAO();

	NCmtBean cb = ncdao.getNCmt(num, b_num);  

	String pageNum = request.getParameter("pageNum");
	%>
	<article>
<fieldset>
	<h2>댓글 수정하기</h2>

	
		<form
			action="nc_updatePro.jsp?b_num=<%=cb.getb_num()%>&pageNum=<%=pageNum%> %>"
			method="post">
			<input type="hidden" name="num" value="<%=cb.getNum()%>"> 
			글쓴이: <input type="text" name="nName" value="<%=cb.getnName()%>" readonly><br> <br>
			내용 : <textarea rows="20" cols="80" name="comment" required><%=cb.getComment()%></textarea>

			<hr>

			<input type="submit" value="글 수정하기">
		</form>
	</fieldset>
</article>
</div>
</body>
</html>