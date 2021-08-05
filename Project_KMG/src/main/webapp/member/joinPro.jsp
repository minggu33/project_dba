<%@page import="com.nbk.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>main/webapp/member/joinPro.jsp</h1>

	<%
	request.setCharacterEncoding("utf-8");
	%>

	<jsp:useBean id="mb" class="com.nbk.member.MemberBean" />
	<jsp:setProperty property="*" name="mb" />

	<%
	String postcode = request.getParameter("postcode");
	String address = request.getParameter("address");
	String detailAddress = request.getParameter("detailAddress");

	String addr = "(" + postcode + ")" + address + detailAddress;

	mb.setAdd(addr);

	MemberDAO mdao = new MemberDAO();

	mdao.memberJoin(mb);
	%>

	<script type="text/javascript">
		alert("회원가입 완료!");
		location.href = "login.jsp";
	</script>


</body>
</html>