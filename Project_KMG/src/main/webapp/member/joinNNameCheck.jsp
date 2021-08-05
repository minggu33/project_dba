<%@page import="com.nbk.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
	
		String nName =request.getParameter("usernName");
	 
	
		MemberDAO mdao = new MemberDAO();
		 
		int result = mdao.nNameCheck(nName); 
		
		if(result == 1){
			out.print(1);
			
		}else{
			out.print(0);

		}
	
	%>