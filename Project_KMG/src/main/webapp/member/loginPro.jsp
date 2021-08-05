<%@page import="com.nbk.member.MemberBean"%>
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
	<h1>main/member/loginPro.jsp</h1>

	<%
	request.setCharacterEncoding("utf-8");
	%>

	<jsp:useBean id="mb" class="com.nbk.member.MemberBean" />
	<jsp:setProperty property="*" name="mb" />

	<%
	MemberDAO mdao = new MemberDAO();

	int check = mdao.login(mb);

	MemberBean mb2 = mdao.userInfo(mb.getId());
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@mb :"+mb2);

	
	if (check == 1) {
	%>
	<script type="text/javascript">
		alert("로그인 완료!");
	<%
		session.setAttribute("nName", mb2.getnName());
		session.setAttribute("id", mb.getId());
		session.setAttribute("user_num", mb2.getUser_num());
%>
		location.href = "../company/welcome.jsp";
	</script>
	<%
	} else if (check == 0) {
	%>
	<script type="text/javascript">
		alert("비밀번호 오류!");
		history.back();
	</script>
	<%
	} else {
	%>
	<script type="text/javascript">
		var r = confirm("비회원입니다.회원가입하시겠습니까?");

		if (r) {
			location.href = "join.jsp";
		} else {
			history.back();
		}
	</script>
	<%
	}
	%>




</body>
</html>