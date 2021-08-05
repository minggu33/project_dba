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
	<h1>webapp/board/writePro.jsp</h1>

	<% 
		request.setCharacterEncoding("utf-8");
	
		String pageNum = request.getParameter("pageNum");
		
		String nName = (String)session.getAttribute("nName");
	
	%>

	<jsp:useBean id="bb" class="com.nbk.board.BoardBean" />
	<jsp:setProperty property="*" name="bb" />

	<%
		bb.setnName(nName);
	
		System.out.println("수정할 정보  : "+bb);
	
		
		BoardDAO bdao = new BoardDAO();
		
		int check = bdao.updateBoard(bb);
		
		if(check ==1){
			%>
	<script type="text/javascript">
			alert("정보수정 완료! ");
			location.href="list.jsp?pageNum=<%=pageNum%>";
			</script>
	<% 
			
	}else if(check ==0){
	%>
	<script type="text/javascript">
		alert("작성자가 아닙니다 ! ");
		history.back();
	</script>
	<% 
}else{
	%>
	<script type="text/javascript">
		alert("글 정보 없음 ");
		history.back();
	</script>
	<%
	}		
	%>


</body>
</html>