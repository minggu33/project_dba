<%@page import="com.nbk.nboard.NBoardDAO"%>
<%@page import="com.nbk.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>webapp/board/deletePro.jsp</h1>


	<%
	String pageNum = request.getParameter("pageNum");

	String nName = (String) session.getAttribute("nName");
	%>

	<jsp:useBean id="nb" class="com.nbk.nboard.NBoardBean" />
	<jsp:setProperty property="*" name="nb" />

	<%
	System.out.println("삭제 정보 : " + nb);

	NBoardDAO ndao = new NBoardDAO();

	ndao.deleteNBoard(nb);  

	System.out.println("글 정보 삭제 완료!");
	%>
	<script type="text/javascript">
		alert("글 삭제를 완료하였습니다! ");
		location.href = "notice.jsp";
	</script>


</body>
</html>