package user;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
	private static UserDAO instance = new UserDAO(); //�����
	
	public static UserDAO getInstance() {//�����
		return instance;//�����
	}//�����

	// dao : �����ͺ��̽� ���� ��ü�� ���ڷμ�
	// ���������� db���� ȸ������ �ҷ����ų� db�� ȸ������ ������
	private Connection conn=null; // connection:db�������ϰ� ���ִ� ��ü
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;

	public UserDAO() { // ������ ����ɶ����� �ڵ����� db������ �̷�� �� �� �ֵ�����
		try {
			String dbURL = "jdbc:mysql://127.0.0.1:3307/bbs";//?&autoReconnect=true&failOverReadOnly=false&maxReconnects=10"; // localhost:3306 ��Ʈ�� ��ǻ�ͼ�ġ�� mysql�ּ�
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // ������ �������� ���
			System.out.println("error1 : "+e.getMessage());
		}
	}
	// �α��� �޼ҵ�
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userId = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) { 
				if(rs.getString(1).equals(userPassword)) {
					return 1; // �α��� ������ 1 return
				} else
					return 0; // ��й�ȣ ����ġ
			}
			return -1; // ���̵� ���� ����
		} catch (Exception e) {
			System.out.println("error : " + e.getMessage());
		}
		return -2; // DB Error
	}
	//ȸ������ �޼ҵ�
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
		return -1; // DB ����
	}
	//��й�ȣ ���� �ڵ�
	public int update(String userID , String userNewPassword) {
		String SQL = "update user set userPassword = ? where userID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userNewPassword);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("���� �߻�"+e);
		}
		return -1; //�����ͺ��̽� ����
	}
	public int delete(String userID){
		String SQL = "delete from user where userID = ? ";
	    try{
		PreparedStatement pstmt = conn.prepareStatement(SQL);
	    pstmt.setString(1, userID);
		return pstmt.executeUpdate();
	   } catch (Exception ex) {
		 ex.printStackTrace();
		 System.out.println("���� �߻�"+ex);
	}
	return -1; //�����ͺ��̽� ����
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

