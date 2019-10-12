package user;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
	private static UserDAO instance = new UserDAO(); //지우기
	
	public static UserDAO getInstance() {//지우기
		return instance;//지우기
	}//지우기

	// dao : 데이터베이스 접근 객체의 약자로서
	// 실질적으로 db에서 회원정보 불러오거나 db에 회원정보 넣을때
	private Connection conn=null; // connection:db에접근하게 해주는 객체
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;

	public UserDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
		try {
			String dbURL = "jdbc:mysql://127.0.0.1:3307/bbs";//?&autoReconnect=true&failOverReadOnly=false&maxReconnects=10"; // localhost:3306 포트는 컴퓨터설치된 mysql주소
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // 오류가 무엇인지 출력
			System.out.println("error1 : "+e.getMessage());
		}
	}
	// 로그인 메소드
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userId = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) { 
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공시 1 return
				} else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음 오류
		} catch (Exception e) {
			System.out.println("error : " + e.getMessage());
		}
		return -2; // DB Error
	}
	//회원가입 메소드
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
	    	pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}
	//비밀번호 변경 코드
	public int update(String userID , String userNewPassword) {
		String SQL = "update user set userPassword = ? where userID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userNewPassword);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("예외 발생"+e);
		}
		return -1; //데이터베이스 오류
	}
	public int delete(String userID){
		String SQL = "delete from user where userID = ? ";
	    try{
		PreparedStatement pstmt = conn.prepareStatement(SQL);
	    pstmt.setString(1, userID);
		return pstmt.executeUpdate();
	   } catch (Exception ex) {
		 ex.printStackTrace();
		 System.out.println("예외 발생"+ex);
	}
	return -1; //데이터베이스 오류
	}
	
	
	
	public List<User> getMembers(){
		List<User> memberList = null;
		ResultSet rs = null;
		try {
			String sql = "select * from user";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				memberList = new ArrayList<User>();
				do {
					User user = new User();
					user.setUserID(rs.getString("userId"));
					user.setUserPassword(rs.getString("userPassword"));
					user.setUserGender(rs.getString("userGender"));
					user.setUserName(rs.getString("userName"));
					user.setUserEmail(rs.getString("userEmail"));
					memberList.add(user);
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("insert Exception : " + e.getMessage());
	/*
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception eee) {
					System.out.println("rs release exception : " + eee.getMessage());
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception ee) {
					System.out.println("insert release exception : " + ee.getMessage());
				}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception ee) {
					System.out.println("connection release exception : " + ee.getMessage());
				}
			}
		}
		*/
		
	}
		return memberList;

	}
}

