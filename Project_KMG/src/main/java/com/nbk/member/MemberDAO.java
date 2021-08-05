package com.nbk.member;

import java.sql.*;

import javax.naming.*;
import javax.sql.*;

public class MemberDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";

	private Connection getConnection() {

		try {
			Context initCTX = new InitialContext();

			DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");

			conn = ds.getConnection();

			System.out.println("드라이버 로드, 디비연결 성공!");
			System.out.println(conn);

		} catch (NamingException | SQLException e) {

			e.printStackTrace();
		}

		return conn;
	}

	public void closeDB() { // 자원해제 코

		try {

			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // 자원해제 코드

	public void memberJoin(MemberBean mb) {
			int num = 0;
			
		try {
			conn = getConnection();
			
			sql = "select max(user_num) from user_kmg";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				num = rs.getInt(1)+1;
				
			}
					
			
			

			sql = "insert into user_kmg values(?,?,?,?,?,?,?,?,now(),?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPw());
			pstmt.setString(3, mb.getName());
			pstmt.setInt(4, mb.getAge());
			pstmt.setString(5, mb.getEmail());
			pstmt.setString(6, mb.getnName());
			pstmt.setString(7, mb.getAddr());
			pstmt.setString(8, mb.getPhone());
			pstmt.setInt(9, num);
			
			pstmt.executeUpdate();

			System.out.println("sql 구문 실행완료! : 회원정보입력완료");

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			closeDB();
		}

	} // memberJoin 끝

//login
	public int login(MemberBean mb) {
		int check = -1;

		try {
			conn = getConnection();

			sql = "select pw from user_kmg where id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, mb.getId());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (mb.getPw().equals(rs.getString("pw"))) {

					check = 1;

				} else { // 비밀번호가 틀림
					check = 0;
				}
			} else { // 정보없음
				check = -1;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return check;

	} // login 끝

	// idCheck
	public int idCheck(String id) {
		int result = -1;

		try {
			conn = getConnection();

			sql = "select * from user_kmg where id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = 1; // 회원이 있음 -> 해당아이디 사용 불가

			} else {
				result = 0; // 회원이 없음 -> 해당아이디 사용 가능
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return result;
	}// idCheck 끝

	// nNameCheck
		public int nNameCheck(String nName) {
			int result = -1;

			try {
				conn = getConnection();

				sql = "select * from user_kmg where nName=?";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, nName);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					result = 1; // 회원이 있음 -> 해당닉네임 사용 불가

				} else {
					result = 0; // 회원이 없음 -> 해당닉네임 사용 가능
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return result;
		}// nNameCheck 끝
	
	
	
//userInfo(String id)
	public MemberBean userInfo(String id) {
		MemberBean mb = new MemberBean();

		try {

			conn = getConnection();

			sql = "select * from user_kmg where id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				mb.setnName(rs.getString("nName"));
				mb.setAge(rs.getInt("age"));
				mb.setEmail(rs.getString("email"));
				mb.setName(rs.getString("name"));
				mb.setUser_num(rs.getInt("user_num"));
				mb.setPhone(rs.getString("phone"));
				mb.setId(rs.getString("id"));
			}

			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();

		}

		return mb;
	}
// userInfo(String id) 끝 

//updateBf
	public MemberBean updateBf(String id) {

		MemberBean mb = new MemberBean();
		mb = null;

		try {

			conn = getConnection();

			sql = "select * from user_kmg where id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				mb = new MemberBean();

				mb.setId(rs.getString("id"));
				mb.setPw(rs.getString("pw"));
				mb.setName(rs.getString("name"));
				mb.setAge(rs.getInt("age"));
				mb.setEmail(rs.getString("email"));
				mb.setnName(rs.getString("nName"));
				mb.setAdd(rs.getString("addr"));
				mb.setPhone(rs.getString("phone"));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return mb;
	}// updateBf 끝

// updateAf
	public int updateAf(MemberBean mb) {
		int check = -1;

		try {
			conn = getConnection();

			System.out.println(mb);

			sql = "select pw from user_kmg where id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, mb.getId());

			rs = pstmt.executeQuery();

			if (rs.next()) {

				if (mb.getPw().equals(rs.getString("pw"))) {
					// 모두 일치! 업데이트하면댐
					sql = "update user_kmg set name=?, age=?, email=?, nName=?, phone=?, addr=? where id=?";

					pstmt = conn.prepareStatement(sql);

					pstmt.setString(1, mb.getName());
					pstmt.setInt(2, mb.getAge());
					pstmt.setString(3, mb.getEmail());
					pstmt.setString(4, mb.getnName());
					pstmt.setString(5, mb.getPhone());
					pstmt.setString(6, mb.getAddr());
					pstmt.setString(7, mb.getId());

					check = pstmt.executeUpdate();

				} else {
					// 잘못된 비번 (아이디는 있음)
					check = 0;
				}

			} else {
				// 아이디가 없음
				check = -1;

			}

			System.out.println("회원정보  수정완료 !" + check);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeDB();
		}

		return check;
	}
//updateAf 끝 

//deleteMember
	public int deleteMember(MemberBean mb) {
		int check = -1;

		try {
			conn = getConnection();

			sql = "select pw from user_kmg where id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, mb.getId());

			rs = pstmt.executeQuery();

			if (rs.next()) {

				if (mb.getPw().equals(rs.getString("pw"))) {

					sql = "delete from user_kmg where id=?";

					pstmt = conn.prepareStatement(sql);

					pstmt.setString(1, mb.getId());

					check = pstmt.executeUpdate();

					System.out.println("회원탈퇴 완료!");

				} else {
					check = 0;
				}
			} else {
				check = -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return check;
	}
//deleteMember 끝 

}
