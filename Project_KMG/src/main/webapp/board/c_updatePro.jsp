<%@page import="com.nbk.cmt.CmtDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>webapp/board/c_updatePro.jsp</h1>
	<%
	request.setCharacterEncoding("utf-8");

	String pageNum = request.getParameter("pageNum");
	%>

	<jsp:useBean id="cb" class="com.nbk.cmt.CmtBean" />
	<jsp:setProperty property="*" name="cb" />

	<%
	System.out.println(cb);

	System.out.println("pageNum=" + pageNum);

	CmtDAO cdao = new CmtDAO();

	int check = cdao.updateCmt(cb);

	if (check == 1) {
	%>
	<script type="text/javascript">
		alert("정보 수정 완료! ");
		location.href="content.jsp?num=<%=cb.getb_num()%>&pageNum=<%=pageNum%>";
	</script>
	<%
	}
	%>


</body>
</html>