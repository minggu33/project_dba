<%@page import="com.nbk.ncmt.NCmtBean"%>
<%@page import="com.nbk.ncmt.NCmtDAO"%>
<%@page import="com.nbk.nboard.NBoardBean"%>
<%@page import="com.nbk.nboard.NBoardDAO"%>
<%@page import="com.nbk.cmt.CmtBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.nbk.cmt.CmtDAO"%>
<%@page import="com.nbk.board.BoardBean"%>
<%@page import="com.nbk.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">


<jsp:include page="../header/header.jsp" />

<style>
.c_tb{
	text-align: center;
	width:720px;
}

.m_tb{
	width:720px;
	height:800px;
	border-collapse: inherit;
	text-align: center;
	font-size: 14px;
}
#div1{
    width:50em;
    height:40em;
    
}
.cover{
	margin-left: 30%;
}
</style>

</head>
<body>

	<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	String pageNum = request.getParameter("pageNum");

	String nName = (String) session.getAttribute("nName");

	NBoardDAO ndao = new NBoardDAO();

	NBoardBean nb = ndao.getNBoard(num); 

	int b_num = num;

	String cNum = "l" + num + "l";

	Cookie[] cookies = request.getCookies();

	String s = Integer.toString(num);

	int check = 0;

	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals("CookName")) {

		String value = cookies[i].getValue();
		Cookie cookie = cookies[i];

		if (value.indexOf(s) < 0) {

			System.out.println("인덱스 번호 :" + value.indexOf(num));

			ndao.updateReadcount(num); 
			value += "l" + num + "l";
			cookie.setValue(value);
			response.addCookie(cookie);

		}

		check = 1;
			}
		}
	}

	if (check == 0) {
		

		ndao.updateReadcount(num);

		Cookie cookie = new Cookie("CookName", cNum);

		// 필요한 설정
		cookie.setMaxAge(60 * 60 * 24); // 600초 => 10분

		// 클라이언트에 전달 (응답객체에 담아서)
		response.addCookie(cookie);

	}

	NCmtDAO cdao = new NCmtDAO();

	// 댓글 리스트 불러오기 
	ArrayList nCmtList = cdao.getNCmtList(b_num);

	if (nName == null) {
		nName = "";
	}
	%>

	<script type="text/javascript">
	function yesorno(){
		if (confirm("정말 삭제하시겠습니까? ")){
			location.href="deletePro.jsp?num=<%=nb.getNum()%>&pageNum=<%=pageNum%>;"
			} else {
				return;
			}
		}
	</script>

<br><br>
	<article>
	<div class="cover">
		<table border="1" class="m_tb">
			<tr>
				<td>글번호</td>
				<td><%=nb.getNum()%></td>
				<td>조회수</td>
				<td><%=nb.getReadcount()%></td>
			</tr>
			<tr>
				<td>글쓴이</td>
				<td><%=nb.getnName()%></td>
				<td>작성일</td>
				<td><%=nb.getDate()%></td>
			</tr>
			<tr>
				<td>글 제목</td>
				<td colspan="3"><%=nb.getSubject()%></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td colspan="3">
				<% if(nb.getFilename()!=null){ %>
				<a href="filedown.jsp?filename=<%=nb.getFilename()%>"> 
									<%=nb.getFilename() %>
				<%
				}
				%>
				</td>
			</tr>
			<tr>
				<td colspan="4"><div  id="div1" contenteditable="true">
				<%if(nb.getFilename() !=null){ %>
				<img src="../upload/<%=nb.getFilename() %>" style="width:600px; height: 300px;" ><br>
				<%
				}
				%>
				<%=nb.getContent()%></td>
			</tr>
			<%
			if (nName.equals(nb.getnName())) {
			%>
			<tr>
				<td colspan="4" align="center"><input type="button" value="수정하기"
					onclick="location.href='nUpdateForm.jsp?num=<%=nb.getNum()%>&pageNum=<%=pageNum%>';">
					<input type="button" value="삭제하기" onclick="yesorno();">

					<input type="button" value="목록으로"
					onclick="location.href='notice.jsp?pageNum=<%=pageNum%>';"></td>
			</tr>
			<%
			} else {
			%>
			<tr>
				<td colspan="4" align="center"><input type="button" value="목록으로"
					onclick="location.href='notice.jsp?pageNum=<%=pageNum%>';"></td>
			</tr>
			<%
			}
			%>
		</table>

		<table class="c_tb">
			<tr style="background-color: orange">
				<td width="65" align="center">작성자</td>
				<td width="450" align="center">댓글</td>
				<td colspan="2"></td>
				<td align="center">작성일</td>
			</tr>

			<%
			for (int i = 0; i < nCmtList.size(); i++) {
				NCmtBean cb = (NCmtBean) nCmtList.get(i);
			%>
			<tr style="vertical-align: top">
				<td><%=cb.getnName()%></td>
				<td><%=cb.getComment()%></td>
				<%
				if (cb.getnName().equals(nName)) {
				%>
				<td><input type="button" value="수정"
					onclick="location.href='nc_updateForm.jsp?b_num=<%=nb.getNum()%>&num=<%=cb.getNum()%>&pageNum=<%=pageNum%>';"></td>
				<td><input type="button" value="삭제"
					onclick="location.href='nc_deletePro.jsp?b_num=<%=nb.getNum()%>&num=<%=cb.getNum()%>&nName=<%=cb.getnName()%>&pageNum=<%=pageNum%>';"></td>
				<td><%=cb.getC_date()%></td>
				<%
				}else{
				%>
				<td></td>
				<td></td>
				<td><%=cb.getC_date()%></td>
				<%
				}
				}
				%>
			
		</table>
<br>
		<form action="ncomment.jsp?pageNum=<%=pageNum%>" method="post" >
			<h4>댓글쓰기</h4>
			<input type="hidden" name="nName" value="<%=nName%>">
			 <input type="hidden" name="b_num" value="<%=nb.getNum()%>">
			<textarea name="comment" style="width: 720px; height: 60px;"
				placeholder="댓글을 입력하세요. 댓글은 당신의 인격을 나타냅니다. " required></textarea>
			<br> <input type="submit" value="등록">
		</form>
</div>
	</article>
<script src="../js/jquery-3.6.0.js" ></script>
</body>
</html>