package com.nbk.nboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.nbk.board.BoardBean;

public class NBoardDAO {

	
	private Connection conn = null;
	private PreparedStatement  pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	
	private Connection getConnection() {
		
		try {
			
			Context initCTX = new InitialContext();
			
			DataSource ds =
					(DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");
			
			conn = ds.getConnection();
			
			System.out.println("드라이버 로드, 디비연결 성공! ");
			System.out.println(conn);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	public void closeDB() {
		try {
			
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	
	
	//insertBoard(nb);
	public void insertBoard(NBoardBean nb) {
		int num = 0;
		
		
		try {
			conn = getConnection();
			
			sql = "select max(num) from nboard_kmg";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				num = rs.getInt(1)+1;
				
			}
			System.out.println("글 번호 : "+num);
			
			// sql (insert작성 & pstmt 객체 생
			sql = "insert into nboard_kmg "
					+ "values(?,?,?,?,?,?,now(),?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, nb.getnName());
			pstmt.setString(3, nb.getPw());
			pstmt.setString(4, nb.getSubject());
			pstmt.setString(5, nb.getContent());
			pstmt.setInt(6, nb.getReadcount());
			pstmt.setString(7, nb.getFilename());
			pstmt.setString(8, nb.getFilerealname());
			
			pstmt.executeUpdate();
			
			System.out.println("sql구문 실행완료 : 글쓰기 완료! ");
			
			
			
		} catch (SQLException e) {
				System.out.println("DB 연결실패!!");
				e.printStackTrace();
		}finally{
			closeDB();
		}
		
}//insertBoard(nb);
	
	
	//getBoardCount
		public int getBoardCount() {
			int cnt=0;
			
			
			try {
				conn = getConnection();
				
				sql = "select count(*) from nboard_kmg";
				
				
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					cnt = rs.getInt(1);
				}
				System.out.println("SQL 구문 실행완료! ");
				System.out.println("글 개수 : "+cnt+"");
				
				
			} catch (SQLException e) {
				System.out.println(" 공지사항  에러 발생 ");
						e.printStackTrace();
			}finally {
				closeDB();
			}
		
			
			return cnt;
		}//getBoardCount
	
		//getBoardList()
		public ArrayList getBoardList() {
			
			ArrayList nBoardListAll = new ArrayList();
			
			NBoardBean nb = null;
			
			
			try {
				conn = getConnection();
				
				sql = "select * from nboard_kmg";
				
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				
				while(rs.next()) {
					nb = new NBoardBean();
					
					nb.setContent(rs.getString("content"));
					nb.setDate(rs.getDate("date"));
					nb.setFilename(rs.getString("filename"));
					nb.setnName(rs.getString("nName"));
					nb.setNum(rs.getInt("num"));
					nb.setPw(rs.getString("pw"));
					nb.setReadcount(rs.getInt("readcount"));
					nb.setSubject(rs.getString("subject"));
					
					nBoardListAll.add(nb);
					
				}
				
				System.out.println("공지사항 모든정보 저장완료! ");
				System.out.println("총"+nBoardListAll.size()+"개");
				
			} catch (SQLException e) {
					e.printStackTrace();
			}finally {
				closeDB();
			}
			
			
			
			
			return nBoardListAll;
		}//getBoardList()
		
		//getBoardList(startRow,pageSize)
		public ArrayList getBoardList(int startRow,int pageSize){
			
			ArrayList nBoardList = new ArrayList();
			
			NBoardBean nb = null;
			
			
			try {
				conn = getConnection();
				
				sql = "select * from nboard_kmg "
						+ "order by num desc "
						+ "limit ?,?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					nb = new NBoardBean();
					
					nb.setContent(rs.getString("content"));
					nb.setDate(rs.getDate("date"));
					nb.setFilename(rs.getString("filename"));
					nb.setnName(rs.getString("nName"));
					nb.setNum(rs.getInt("num"));
					nb.setPw(rs.getString("pw"));
					nb.setReadcount(rs.getInt("readcount"));
					nb.setSubject(rs.getString("subject"));
					
					nBoardList.add(nb);
					
				}
				
				System.out.println("공지사항 모든정보 저장완료!  ");
				System.out.println("총 "+nBoardList.size()+"개 ");
				
				
			} catch (SQLException e) {
					e.printStackTrace();
			}finally {
				closeDB();
			}
			
			
			
			return nBoardList;
			
		}//getBoardList(startRow,pageSize)
		
		//getNBoard(num)
		public NBoardBean getNBoard(int num) {
			NBoardBean nb = null;
			
			
			try {
				conn = getConnection();
				
				sql = "select * from nboard_kmg where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					nb = new NBoardBean();
					
					nb.setContent(rs.getString("content"));
					nb.setDate(rs.getDate("date"));
					nb.setFilerealname(rs.getString("filerealname"));
					nb.setFilename(rs.getString("filename"));
					nb.setnName(rs.getString("nName"));
					nb.setNum(rs.getInt("num"));
					nb.setPw(rs.getString("pw"));
					nb.setReadcount(rs.getInt("readcount"));
					nb.setSubject(rs.getString("subject"));
					
					
				}
				
				System.out.println("글 번호에 해당하는 글 정보 저장완료! ");
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
			return nb;
		}//getNBoard(num)
	
	//updateReadcount(num)
		public void updateReadcount(int num) {
			
			
			try {
				conn = getConnection();
				
				sql = "update nboard_kmg set readcount=readcount+1 "
						+ "where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
				
				System.out.println("글 조회수 증가 완료! ");
				
			} catch (SQLException e) {
						e.printStackTrace();
			}finally {
				closeDB();
			}
		
		}//updateReadcount(num)
		
		//updateNBoard(nb)
		public int updateNBoard(NBoardBean nb) {
			int check = -1;
			
			
			try {
				conn = getConnection();
				
				sql = "select nName from nboard_kmg where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, nb.getNum());
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					if(nb.getnName().equals(rs.getString("nName"))) {
						
						sql = "update nboard_kmg set subject=?,content=? where num=?";
						
						pstmt = conn.prepareStatement(sql);
						
						pstmt.setString(1, nb.getSubject());
						pstmt.setString(2, nb.getContent());
						pstmt.setInt(3, nb.getNum());
						
						check = pstmt.executeUpdate();
						
					}else {
							// 잘못된 비밀번호 (글은 있음)
						check =0;
					}
					
				}else {
					// 글이 없음
					check = -1;
				}
				System.out.println("글 수정 완료! "+check);
				
			} catch (SQLException e) {
					e.printStackTrace();
			}finally {
				closeDB();
			}
					
			return check;		
		}//updateNBoard(nb)
		
		//deleteNBoard(nb)
		public void deleteNBoard(NBoardBean nb) {
		
			
			try {
				conn = getConnection();
				
				sql = "delete from nboard_kmg where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, nb.getNum());
				
				pstmt.executeUpdate();
			} catch (SQLException e) {
					e.printStackTrace();
			}finally{
				closeDB();
			}
			
			
			
		}//deleteNBoard(bb)
		
}
