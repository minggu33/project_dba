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

	<jsp:useBean id="bb" class="com.nbk.board.BoardBean" />
	<jsp:setProperty property="*" name="bb" />

	<%
	System.out.println("삭제 정보 : " + bb);

	BoardDAO bdao = new BoardDAO();

	bdao.deleteBoard(bb);

	System.out.println("글 정보 삭제 완료!");
	%>
	<script type="text/javascript">
		alert("글 삭제를 완료하였습니다! ");
		location.href = "list.jsp";
	</script>


</body>
</html>