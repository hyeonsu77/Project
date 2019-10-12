<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>    
<%@ page import="java.io.PrintWriter"%>
<%
   request.setCharacterEncoding("utf8");
   String bbsId = request.getParameter("bbsID");
   
   Connection conn = null;
   PreparedStatement pstmt = null;
   
   try{
	  String dbURL = "jdbc:mysql://127.0.0.1:3307/bbs";
      String dbId = "root";
      String dbPass = "root";
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(dbURL, dbId, dbPass);
      String sql = "delete from bbs where bbsID = ?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, bbsId);
      pstmt.executeUpdate();
      response.sendRedirect("user.jsp");
      
   }catch(Exception e){
      System.out.println("Exception : " + e.getMessage());
   }
   PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('해당 게시글을 삭제 하였습니다.')");
		script.println("history.back()");
		script.println("</script>");
%>
