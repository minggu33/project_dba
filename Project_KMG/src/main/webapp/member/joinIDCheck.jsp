<%@page import="com.nbk.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<%
	
		String id =request.getParameter("userid");
	 
	
		MemberDAO mdao = new MemberDAO();
		
		int result = mdao.idCheck(id); 
		
		if(result == 1){
			out.print(1);
			
		}else{
			out.print(0);

		}
	
	%>
