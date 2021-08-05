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
	<h1>webapp/nboard/nUpdatePro.jsp</h1>

	<% 
		request.setCharacterEncoding("utf-8");
	
		String pageNum = request.getParameter("pageNum");
		
		String nName = (String)session.getAttribute("nName");
	
	%>

	<jsp:useBean id="nb" class="com.nbk.nboard.NBoardBean" />
	<jsp:setProperty property="*" name="nb" />

	<%
		nb.setnName(nName);
	
		System.out.println("수정할 정보  : "+nb);
	
		
		NBoardDAO ndao = new NBoardDAO();
		
		int check = ndao.updateNBoard(nb);
		
		if(check ==1){
			%>
	<script type="text/javascript">
			alert("정보수정 완료! ");
			location.href="notice.jsp?pageNum=<%=pageNum%>";
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