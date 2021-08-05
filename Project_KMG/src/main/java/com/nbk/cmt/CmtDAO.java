package com.nbk.cmt;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.*;

public class CmtDAO {
	
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql ="";
	
	
	//getConnection()
	private Connection getConnection() {
		
		
		try {
			
			Context initCTX = new InitialContext();
			
			DataSource ds =
					(DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");
			
			conn = ds.getConnection();
			
			System.out.println("드라이버 로드, 디비연결 성공! ");
			System.out.println(conn);
			
			
			
		} catch (NamingException | SQLException e) {
						e.printStackTrace();
		}
		
		
		return conn;
				
	} // getConnection() 
	
	
	// closeDB()
	public void closeDB() {
		
		if(rs != null)
			try {
				rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch (SQLException e) {
								e.printStackTrace();
			}
		
	} // closeDB( ) 끝 
	
	
	
	
	
	//insertCmt(cb)
	public void insertCmt(CmtBean cb) {
		int num = 0;
		
		
		try {
			conn = getConnection();
			
			sql = "select max(num) from cmt_kmg";
			
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				
				num = rs.getInt(1)+1;
				
			}
			
			
			sql = "insert into cmt_kmg "
					+ "values(?,?,?,?,now(),?)"; 
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setInt(2, cb.getb_num());
			pstmt.setString(3, cb.getnName());
			pstmt.setString(4, cb.getComment());
			pstmt.setString(5, cb.getIp());
			
			
			pstmt.executeUpdate();
			
			System.out.println("sql구문 실행완료 : 댓글쓰기 완료! ");
			
		} catch (SQLException e) {
			System.out.println("DB 연결 실패!");
				e.printStackTrace();
		}finally {
			closeDB();
		}		
		
	}//insertCmt(cb)
	
	//getCmtList()
	public ArrayList getCmtList(int b_num) {
		ArrayList cmtListAll = new ArrayList();
		
		CmtBean cb = null;
		
		try {
			conn = getConnection();
			
			sql = "select * from cmt_kmg where b_num=?";
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, b_num);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				cb = new CmtBean();
				
				cb.setNum(rs.getInt("num"));
				cb.setb_num(rs.getInt("b_num"));
				cb.setnName(rs.getString("nName"));
				cb.setComment(rs.getString("comment"));
				cb.setC_date(rs.getDate("c_date"));
				cb.setIp(rs.getString("ip"));
				
				cmtListAll.add(cb);
			}
			
			System.out.println("글 번호에 해당하는 댓글 정보 저장완료!");
			
		} catch (SQLException e) {
				e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		return cmtListAll;
		
	}	//getCmtList() 끝 
	
	// getCmt(num,b_num)
	public CmtBean getCmt(int num, int b_num) {
			CmtBean cb = null;
			
			
			
			
			try {
				conn = getConnection();
				
				sql = "select * from cmt_kmg where num=? and b_num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				
				pstmt.setInt(2, b_num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					cb = new CmtBean();
					
					cb.setNum(rs.getInt("num"));
					cb.setb_num(rs.getInt("b_num"));
					cb.setnName(rs.getString("nName"));
					cb.setComment(rs.getString("comment"));
					
					
				}
				
				System.out.println("댓글 정보에 해당하는 댓글 정보 저장완료! ");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
		
		return cb;
		
	}//getCmt(num,b_num)
	
	//updateCmt(cb)
	public int updateCmt(CmtBean cb) {
		int check = -1;
		
		
		try {
			conn = getConnection();
			
			sql = "select nName from cmt_kmg where num=? and b_num=?";
			
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setInt(1, cb.getNum());
			 pstmt.setInt(2, cb.getb_num());

			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 if(cb.getnName().equals(rs.getString("nName"))) {
					 
					 sql ="update cmt_kmg set comment=?, c_date=now() where num=? and b_num=?";
					
					 pstmt=conn.prepareStatement(sql);
					 
					 pstmt.setString(1, cb.getComment());
					 pstmt.setInt(2, cb.getNum());
					 pstmt.setInt(3, cb.getb_num());
					 
					 check = pstmt.executeUpdate();
					 
				 }else {
					 
					 check = 0;
				 }
			 }else {
				 check = -1;
			 }
			 
			 System.out.println("댓글 수정 완료!"+check);
			 
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return check;
		
	}//updateCmt(cb)
	
	//deleteCmt(cb)
	public int deleteCmt(CmtBean cb) {
		int check = -1;
		
		try {
			conn = getConnection();
			
			sql = "select nName from cmt_kmg where num=? and b_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cb.getNum());
			pstmt.setInt(2, cb.getb_num());
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				
				if(cb.getnName().equals(rs.getString("nName"))) {
					
					sql = "delete from cmt_kmg where num=? and b_num=?";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, cb.getNum());
					pstmt.setInt(2, cb.getb_num());
					
					check = pstmt.executeUpdate();
					
				}
				
			}else {
				check = -1;
			}
			
			System.out.println("댓글 삭제 완료! "+check);
			
			
		} catch (SQLException e) {
				e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return check;
		
	}//deleteCmt(cb)
	// getCmtCnt(bb.getNum())
	public int getCmtCnt(int num) {
		int cnt = 0;
		
		try {
			conn = getConnection();
			
			sql = "select count(*) from cmt_kmg where b_num=? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			System.out.println("SQL 구문 실행완료! ");
			System.out.println("댓글 개수 : "+cnt+"");
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return cnt;
	} // getCmtCnt(bb.getNum())
}
