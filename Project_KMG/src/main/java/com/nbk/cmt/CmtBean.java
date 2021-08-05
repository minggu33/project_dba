package com.nbk.cmt;

import java.sql.*;

public class CmtBean {
	private int num;
	private int b_num;
	private String nName;
	private String comment;
	private Date c_date;
	private String ip;
	
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
		public int getb_num() {
			return b_num;
		}
		public void setb_num(int b_num) {
			this.b_num = b_num;
	}
	public String getnName() {
		return nName;
	}
	public void setnName(String nName) {
		this.nName = nName;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getC_date() {
		return c_date;
	}
	public void setC_date(Date c_date) {
		this.c_date = c_date;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	
	@Override
	public String toString() {
		return "CmtBean [num=" + num +", b_num="+b_num+ ", nName=" + nName + ", comment=" + comment + ", c_date=" + c_date + ", ip=" + ip
				+ "]";
	}
	
	
	
}
