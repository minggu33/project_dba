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
	<h1>webapp/board/c_deletePro.jsp</h1>

	<jsp:useBean id="cb" class="com.nbk.ncmt.NCmtBean" />
	<jsp:setProperty property="*" name="cb" />

	<%
		System.out.println(cb);
	
		String pageNum = request.getParameter("pageNum");
	
		NCmtDAO ncdao = new NCmtDAO();
		
		int check = ncdao.deleteNCmt(cb); 
	
		if(check == 1){
			
			%>
	<script type="text/javascript">
						alert("댓글 삭제 완료!");
						location.href="ncontent.jsp?num=<%=cb.getb_num()%>";
				 
				</script>
	<% 
		}else{
			%>
	<script type="text/javascript">
				alert("댓글 정보 없음!!");
				history.back();
			</script>
	<% 
		}
		
	%>


</body>
</html>