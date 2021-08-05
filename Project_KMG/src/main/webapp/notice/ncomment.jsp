<%@page import="com.nbk.ncmt.NCmtDAO"%>
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
	<h1>webapp/notice/ncomment.jsp</h1>

	<%
	request.setCharacterEncoding("utf-8");

	String nName = (String) session.getAttribute("nName");

	if (nName == null) {
	%>
	<script type="text/javascript">
	var r = confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?");
	
	if(r){
		location.href="../member/login.jsp";
	}else{
		history.back();
	}
	</script>

	<%
	} else {
	%>
	<jsp:useBean id="cb" class="com.nbk.ncmt.NCmtBean" />
	<jsp:setProperty property="*" name="cb" />

	<%
	
	System.out.println("글쓰기 정보 :" + cb);

	cb.setIp(request.getRemoteAddr());

	NCmtDAO cdao = new NCmtDAO();

	cdao.insertNCmt(cb);
	%>

	<script type="text/javascript">
		alert("댓글 작성 완료!");
		location.href="ncontent.jsp?num=<%=cb.getb_num()%>";
	</script>
	<%
	}
	%>

</body>
</html>