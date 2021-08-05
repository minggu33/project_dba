<%@page import="com.nbk.cmt.CmtDAO"%>
<%@page import="com.nbk.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.nbk.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	BoardDAO bdao = new BoardDAO();

	int cnt = bdao.getBoardCount();

	int pageSize = 8;

	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;

	int endRow = currentPage * pageSize;

	bdao.getBoardList();

	ArrayList boardList = bdao.getBoardList(startRow, pageSize);
	
	
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
					href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject()%>
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

<div class="page" style="width: 0; margin: 0 auto;">
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
										<li class="page-item"><a class="page-link" href="list.jsp?pageNum=<%=startPage-pageBlock%>">Previous</a></li>
										<%
									}
									
									//숫자 1....5
									for(int i=startPage;i<=endPage;i++){
										%>
										<li class="page-item"><a class="page-link" href="list.jsp?pageNum=<%=i%>"><%=i %></a></li>
										<%
									}
									
									//다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
									if(endPage < pageCount){
										%>
										<li class="page-item"><a class="page-link" href="list.jsp?pageNum=<%=startPage+pageBlock%>">Next</a></li>
										<%
									}
								}
								%>
						    
						  </ul>
						  
</div>
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