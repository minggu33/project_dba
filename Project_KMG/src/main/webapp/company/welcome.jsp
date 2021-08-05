<%@page import="com.nbk.nboard.NBoardBean"%>
<%@page import="com.nbk.nboard.NBoardDAO"%>
<%@page import="com.nbk.cmt.CmtDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">


<style type="text/css">
#m_img {
	margin-top: 3%;
	max-width: 100%;
	height: 200px;
	background-size: cover;
	background-image: url("../images/bb.jpg");
	background-attachment: fixed;
}

#bd {
	    width: 80%;
    margin: 0 auto;
}
</style>

</head>
<body>

	<!-- 헤더가 들어가는 곳 -->
	<jsp:include page="../header/header.jsp" />
	<!-- 헤더가 들어가는 곳 -->


	<!-- 본문 들어가는 곳 -->
	<% 
	NBoardDAO ndao = new NBoardDAO();
	
	int cnt = ndao.getBoardCount();
	
	int pageSize = 8;
	
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	
	int endRow = currentPage * pageSize;
	
	ndao.getBoardList(); 
	
	ArrayList nBoardList = ndao.getBoardList(startRow, pageSize);
	
	String nName = (String)session.getAttribute("nName");
			
	System.out.println(nName);
	%>
	<!-- 내용 -->
	<h1 align="center">Welcome to DBA</h1>

	<div id="m_img" style="width: 100%; height: 550px;"></div>



	<div id="bd">
		<br>
		<br>
		<div align="center">
			<h2>공지사항</h2>
		</div>
		<table class="table table-hover">
			<thead>
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>
				</tr>
			</thead>
			<%
			for (int i = 0; i < nBoardList.size(); i++) {
				NBoardBean nb = (NBoardBean) nBoardList.get(i);

			%>
			<tr>
				<td><%=nb.getNum()%></td>
				<td><a style="text-decoration: none;"
					href="../notice/ncontent.jsp?num=<%=nb.getNum()%>&pageNum=<%=pageNum%>"><%=nb.getSubject()%></a>

				</td>
				<td><%=nb.getnName()%></td>
				<td><%=nb.getDate()%></td>
				<td><%=nb.getReadcount()%></td>
				<%
				}
				%>
			
		</table>

			<div class="page" style="width: 0; margin: 0 auto;" >
			
			<ul class="pagination">
				<%
								if(cnt != 0 ){
									
									int pageCount = cnt / pageSize + (cnt  % pageSize == 0? 0:1);
									
									int pageBlock = 2;
									
									int startPage = ((currentPage-1)/pageBlock) * pageBlock +1;
									
									int endPage = startPage + pageBlock-1;
									
									if(endPage > pageCount){
										endPage = pageCount;
									}
								
									if(startPage > pageBlock){
										%>
				<li class="page-item"><a class="page-link"
					href="../notice/notice.jsp?pageNum=<%=startPage-pageBlock%>">Previous</a></li>
				<%
									}
									
									//숫자 1....5
									for(int i=startPage;i<=endPage;i++){
										%>
				<li class="page-item"><a class="page-link"
					href="../notice/notice.jsp?pageNum=<%=i%>"><%=i %></a></li>
				<%
									}
									
									//다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
									if(endPage < pageCount){
										%>
				<li class="page-item"><a class="page-link"
					href="../notice/notice.jsp?pageNum=<%=startPage+pageBlock%>">Next</a></li>
				<%
									}
								}
								%>

			</ul>
			</div>
			</div>
	


	<!-- 내용 -->
	<!-- 본문 들어가는 곳 -->
	<!-- 푸터 들어가는 곳 -->

	<!-- 푸터 들어가는 곳 -->
	<script src="../js/jquery-3.6.0.js"></script>
</body>
</html>



