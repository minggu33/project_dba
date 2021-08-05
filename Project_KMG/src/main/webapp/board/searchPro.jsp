<%@page import="com.nbk.cmt.CmtDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.nbk.board.BoardBean"%>
<%@page import="com.nbk.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<style>
.page{
	text-align: center;
}

</style>




<jsp:include page="../header/header.jsp" />
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		
		String sk = request.getParameter("sk");
		String sv = request.getParameter("sv");
	
		BoardDAO bdao = new BoardDAO();
		
		List boardList
		= bdao.searchList(sk,sv);
		
		System.out.println(sk);
		System.out.println(sv);
	
		request.setAttribute("boardlist", boardList);
	
		CmtDAO cdao = new CmtDAO();
	
	%>


<article style="text-align: center;">

		<h1>DBA 게시판</h1>
		<br><br>
		<table class="table table-hover">
		<thead>
			<tr>
				<td>번호</td>
				<td style="width: 400px;">제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>
		</thead>
			<%
			for (int i = 0; i < boardList.size(); i++) {
				BoardBean bb = (BoardBean) boardList.get(i);
				int cmtCnt = cdao.getCmtCnt(bb.getNum());
			%>
			<tr>
				<td><%=bb.getNum()%></td>
				<td><a style="text-decoration: none;"
					href="content.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject()%>
					[<%=cmtCnt %>]		
					</a>

				</td>
				<td><%=bb.getnName()%></td>
				<td><%=bb.getDate()%></td>
				<td><%=bb.getReadcount()%></td>
				<%
				}
				%>		
		</table>
		
		<form action="writeForm.jsp" method="post">
			<input class="btn btn-primary" style="float: right;" type="submit" value="글쓰기 ">
		</form>
	
	<!-- 게시판 검색기능  -->
		<form action="searchPro.jsp" method="post">
			<select name="sk">
				<option value="nName">작성자</option>
				<option value="subject">글 제목</option>
			</select>
			<input type="text" name="sv">
			<input type="submit" value="검색">		
		</form>
		
	</article>
		
	<script src="../js/jquery-3.6.0.js" ></script>
</body>
</html>