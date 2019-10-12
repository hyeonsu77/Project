<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>    
<%@ page import="java.io.PrintWriter"%>
<%    
   request.setCharacterEncoding("utf8");
   String uId = request.getParameter("userId");
   
   Connection conn = null;
   PreparedStatement pstmt = null;
   
   try{
	  String dbURL = "jdbc:mysql://127.0.0.1:3307/bbs";
      String dbId = "root";
      String dbPass = "root";
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(dbURL, dbId, dbPass);
      String sql = "delete from user where userID = ?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, uId);
      pstmt.executeUpdate();
      response.sendRedirect("user.jsp");
      
      PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('사용자를 삭제 하였습니다.')");
		script.println("history.back()");
		script.println("</script>");
		
   }catch(Exception e){
      System.out.println("Exception : " + e.getMessage());
   }
   
%>
