package com.nbk.nboard;

import java.sql.*;

public class NBoardBean {
	
	private int num;
	private String nName;
	private String pw;
	private String subject;
	private String content;
	private int readcount;
	private Date date;
	private String filename;
	private String filerealname;
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getnName() {
		return nName;
	}
	public void setnName(String nName) {
		this.nName = nName;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}

	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFilerealname() {
		return filerealname;
	}
	public void setFilerealname(String filerealname) {
		this.filerealname = filerealname;
	}
	
	@Override
	public String toString() {
		return "NBoardBean [num=" + num + ", nName=" + nName + ", pw=" + pw + ", subject=" + subject + ", content="
				+ content + ", readcount=" + readcount + ", date=" + date + ", filename=" + filename + ", filerealname=" + filerealname
				+ "]";
	}
	
	
	
	
}
