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
	<h1>webapp/member/deletePro.jsp</h1>

	<%
		request.setCharacterEncoding("utf-8");
	
		String pw = (String)session.getAttribute("pw");
	

	%>

	<jsp:useBean id="mb" class="com.nbk.member.MemberBean" />
	<jsp:setProperty property="*" name="mb" />

	<%
		
		
		MemberDAO mdao = new MemberDAO();
	
		int check = mdao.deleteMember(mb);
		
		if(check ==1){
			session.invalidate();
			%>
	<script type="text/javascript">
				alert("회원탈퇴 완료 ! ");
				location.href="../company/welcome.jsp";
				
				</script>


	<% 
		}else if(check == 0){
			%>
	<script type="text/javascript">
				alert("비밀번호 오류! ");
				history.back();
			</script>

	<% 
			
		}else{
			%>
	<script type="text/javascript">
			alert("없는 아이디! ");
		 	history.back();
			</script>

	<% 
		}
	%>




</body>
</html>