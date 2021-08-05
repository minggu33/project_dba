<%@page import="com.nbk.cmt.CmtBean"%>
<%@page import="com.nbk.cmt.CmtDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">

<jsp:include page="../header/header.jsp" />

</head>
<body>
	<%
	int num = Integer.parseInt(request.getParameter("num"));

	int b_num = Integer.parseInt(request.getParameter("b_num"));

	CmtDAO cdao = new CmtDAO();

	CmtBean cb = cdao.getCmt(num, b_num);

	String pageNum = request.getParameter("pageNum");
	%>
<article>
	<h2>댓글 수정하기</h2>

	<fieldset>
		<form
			action="c_updatePro.jsp?b_num=<%=cb.getb_num()%>&pageNum=<%=pageNum%> %>"
			method="post">
					<input type="hidden" name="num" value="<%=cb.getNum()%>"> 
			글쓴이: <input type="text" name="nName" value="<%=cb.getnName()%>" readonly><br> <br>
			내용 :<textarea rows="20" cols="80" name="comment" required><%=cb.getComment()%></textarea>

			<hr>

			<input type="submit" value="글 수정하기">
		</form>
	</fieldset>
</article>

</body>
</html>