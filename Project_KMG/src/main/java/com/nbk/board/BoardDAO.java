package com.nbk.board;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.*;

public class BoardDAO {

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
	
	
	//insertBoard(bb)
	public void insertBoard(BoardBean bb) {
		int num = 0;
		
		
		try {
			conn = getConnection();
			
			sql = "select max(num) from board_kmg";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				num = rs.getInt(1)+1;
				
			}
			System.out.println("글 번호 : "+num);
			
			// sql (insert작성 & pstmt 객체 생
			sql = "insert into board_kmg "
					+ "values(?,?,?,?,?,?,?,?,?,now(),?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getnName());
			pstmt.setString(3, bb.getPw());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, bb.getReadcount());
			pstmt.setInt(7, num);
			pstmt.setInt(8, bb.getRe_lev());
			pstmt.setInt(9, bb.getRe_seq());
			pstmt.setString(10, bb.getIp());
			pstmt.setString(11, bb.getFilename());
			pstmt.setString(12, bb.getFilerealname());
			
			pstmt.executeUpdate();
			
			System.out.println("sql구문 실행완료 : 글쓰기 완료! ");
			
			
			
		} catch (SQLException e) {
				System.out.println("DB 연결실패!!");
				e.printStackTrace();
		}finally{
			closeDB();
		}
			
		
	}//insertBoard(bb)
	
	//getBoardCount
	public int getBoardCount() {
		int cnt=0;
		
		
		try {
			conn = getConnection();
			
			sql = "select count(*) from board_kmg";
			
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			System.out.println("SQL 구문 실행완료! ");
			System.out.println("글 개수 : "+cnt+"");
			
			
		} catch (SQLException e) {
			System.out.println(" 게시판 글 개수 에러 발생 ");
					e.printStackTrace();
		}finally {
			closeDB();
		}
	
		
		return cnt;
	}//getBoardCount
	
	//getBoardList()
	public ArrayList getBoardList() {
		
		ArrayList boardListAll = new ArrayList();
		
		BoardBean bb = null;
		
		
		try {
			conn = getConnection();
			
			sql = "select * from board_kmg";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				bb = new BoardBean();
				
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setFilename(rs.getString("filename"));
				bb.setIp(rs.getString("ip"));
				bb.setnName(rs.getString("nName"));
				bb.setNum(rs.getInt("num"));
				bb.setPw(rs.getString("pw"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				
				boardListAll.add(bb);
				
			}
			
			System.out.println("게시판 모든정보 저장완료! ");
			System.out.println("총"+boardListAll.size()+"개");
			
		} catch (SQLException e) {
				e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		
		
			return boardListAll;
	}//getBoardList()
	
	//getBoardList(startRow,pageSize)
	public ArrayList getBoardList(int startRow,int pageSize){
		
		ArrayList boardList = new ArrayList();
		
		BoardBean bb = null;
		
		
		try {
			conn = getConnection();
			
			sql = "select * from board_kmg "
					+ "order by re_ref desc, re_seq asc "
					+ "limit ?,?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				bb = new BoardBean();
				
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setFilename(rs.getString("filename"));
				bb.setIp(rs.getString("ip"));
				bb.setnName(rs.getString("nName"));
				bb.setNum(rs.getInt("num"));
				bb.setPw(rs.getString("pw"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				
				boardList.add(bb);
				
			}
			
			System.out.println("게시판 모든정보 저장완료!  ");
			System.out.println("총 "+boardList.size()+"개 ");
			
			
		} catch (SQLException e) {
				e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		
		return boardList;
		
	}//getBoardList(startRow,pageSize)
	
	//getBoard(num)
	public BoardBean getBoard(int num) {
		BoardBean bb = null;
		
		
		try {
			conn = getConnection();
			
			sql = "select * from board_kmg where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				bb = new BoardBean();
				
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setFilename(rs.getString("filename"));
				bb.setFilerealname(rs.getString("filerealname"));
				bb.setIp(rs.getString("ip"));
				bb.setnName(rs.getString("nName"));
				bb.setNum(rs.getInt("num"));
				bb.setPw(rs.getString("pw"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				
				
			}
			
			System.out.println("글 번호에 해당하는 글 정보 저장완료! ");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return bb;
	}//getBoard(num)
	
	//updateReadcount(num)
	public void updateReadcount(int num) {
		
		
		try {
			conn = getConnection();
			
			sql = "update board_kmg set readcount=readcount+1 "
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
	
	//updateBoard(bb)
	public int updateBoard(BoardBean bb) {
		int check = -1;
		
		
		try {
			conn = getConnection();
			
			sql = "select nName from board_kmg where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bb.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(bb.getnName().equals(rs.getString("nName"))) {
					
					sql = "update board_kmg set subject=?,content=? where num=?";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, bb.getSubject());
					pstmt.setString(2, bb.getContent());
					pstmt.setInt(3, bb.getNum());
					
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
	}//updateBoard(bb)
	
	//deleteBoard(bb)
	public void deleteBoard(BoardBean bb) {
	
		
		try {
			conn = getConnection();
			
			sql = "delete from board_kmg where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bb.getNum());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
				e.printStackTrace();
		}finally{
			closeDB();
		}	
		
	}//deleteBoard(bb)
	
	//searchList(sk,sv)
	
	public List searchList(String sk,String sv){
		
		List boardList = new ArrayList();
		BoardBean bb = null;
		
		
		try {
			conn = getConnection();
			
			sql = "select * from board_kmg where "+sk+" like '%"+sv+"%'";
			
			pstmt=conn.prepareStatement(sql);
			

			
			System.out.println(pstmt.toString());
			
			rs = pstmt.executeQuery();
			
			System.out.println("@@@@@@@@@@@@@@@@@@");
			
			
			while(rs.next()){
				bb = new BoardBean();
				
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setFilename(rs.getString("filename"));
				bb.setFilerealname(rs.getString("filerealname"));
				bb.setIp(rs.getString("ip"));
				bb.setnName(rs.getString("nName"));
				bb.setNum(rs.getInt("num"));
				bb.setPw(rs.getString("pw"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
			
				boardList.add(bb);
				
				System.out.println("@@@@@@@@@@@@@@@@@@2222222");
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}

		
		return boardList;
	}//searchList(sk,sv)
	
	//setReco(bum,user_num,reco)
	public void setReco(int bnum,String user_num, int reco){
		
		
		int num = 0;

			
			try {
				conn = getConnection();
				
				sql = "select max(num) from reco_board";
				
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					num = rs.getInt(1)+1;
				}
				
				sql = "insert into reco_board(num,b_num,user_num,reco) "
						+ "values(?,?,?,?)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				pstmt.setInt(2, bnum);
				pstmt.setString(3, user_num);
				pstmt.setInt(4, reco);
				
				pstmt.executeUpdate();
				
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				closeDB();
			}
		
		
		
	
	}
	//setReco(bum,user_num,reco)
	
	
	
}
