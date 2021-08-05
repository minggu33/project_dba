<%@page import="com.nbk.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		request.setCharacterEncoding("utf-8");
		
		int bnum = Integer.parseInt( request.getParameter("bnum"));		
	
		String user_num = request.getParameter("user_num");
		
		int reco = Integer.parseInt(request.getParameter("reco"));
	
		BoardDAO bdao = new BoardDAO();
		
		// 중복값 체크 없이 그냥 일단 인설트만 가능
		bdao.setReco(bnum,user_num,reco);
		

	%>
<script type="text/javascript">
history.back();
</script>



</body>
</html>