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
	<h1>webapp/member/updatePro.jsp</h1>
	
	<%
			request.setCharacterEncoding("utf-8");
		
			String id = (String) session.getAttribute("id");
			
			if(id == null){
				System.out.println("아이디 없음 -> 로그인페이지로! ");
			 	response.sendRedirect("login.jsp");
			}
	%>

	<jsp:useBean id="mb" class="com.nbk.member.MemberBean"/>	
	<jsp:setProperty property="*" name="mb"/>
	<%
		System.out.println(mb);
		MemberDAO mdao = new MemberDAO();
		
		int check = mdao.updateAf(mb);
	
		System.out.println("check : "+ check);
		
		if(check == 1){
					// 1 정상적 수정 완료
			 %>
			 <script type="text/javascript">
			 	alert("정보수정 완료! ");
			 	location.href="../company/welcome.jsp";
			 </script>
			 <% 
		}else if(check ==0){
					// 0  비밀번호 오류 - 수정실패
					%>
					<script type="text/javascript">
					alert("비밀번호 오류!");
					history.back();
					</script>
					<% 
		}else{
			// -1  없는아이디  - 수정실패 
			%>
			<script type="text/javascript">
			alert("없는 아이디입니다.");
			history.back();
			</script>
			<%
		}
	
	
	%>
	
	
</body>
</html>