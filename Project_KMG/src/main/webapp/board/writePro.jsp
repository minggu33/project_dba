<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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

%>

<jsp:useBean id="bb" class="com.nbk.board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>

<%
	
	String path = request.getRealPath("/upload");
	
	System.out.println("파일저장되는 실제 경로 : "+path);
	
	// 2) 파일의 크기를 지정 -> 10MB
	int maxSize = 30*1024*1024;
	
	// 파일 업로드 => Multipart 객체를 생성
	MultipartRequest multi  
	= new MultipartRequest(
							request,
							path,
							maxSize,
							"utf-8",
						new DefaultFileRenamePolicy()
							);


	String nName = multi.getParameter("nName"); 
	String subject = multi.getParameter("subject");
	// String filename = multi.getParameter("filename"); (x)
	String content = multi.getParameter("content");
	
	// -> 서버에 올라가는 파일의 이름(중복 처리)
	String filename = multi.getFilesystemName("file");
	// -> 서버에 올라가는 파일이름 X 파일 자체의 이름
	String oFileName = multi.getOriginalFileName("file"); 
	
	String pw = multi.getParameter("pw");
	
	bb.setnName(nName);
	bb.setSubject(subject);
	bb.setContent(content);
	bb.setFilename(filename);
	bb.setFilerealname(oFileName);
	bb.setPw(pw);
	// ip정보 추가
	bb.setIp(request.getRemoteAddr());
	
	
	
	System.out.println("글쓰기정보:  "+bb);
	
	BoardDAO bdao = new BoardDAO();
	
	bdao.insertBoard(bb); 
	
	response.sendRedirect("list.jsp");


%>



</body>
</html>