<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- userdao의 클래스 가져옴 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userNewPassword" /> 
<jsp:setProperty name="user" property="userID" /> 

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
		userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'loginForm3.jsp'");
		script.println("</script>");
	}
	if(user.getUserID() == null || user.getUserPassword() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				UserDAO userDAO = new UserDAO(); //인스턴스생성
				int result2 = userDAO.login(user.getUserID(), user.getUserPassword());
				if(result2 == 0){
					PrintWriter script = response.getWriter(); //비밀번호 불일치
					script.println("<script>");
					script.println("alert('비밀번호가 틀립니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				
				if(result2 != 0){
			//	UserDAO userDAO = new UserDAO(); //인스턴스생성
				int result = userDAO.delete(user.getUserID());				
				if(result == -1){ // 아이디가 기본키기. 중복되면 오류.
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('데이터베이스 오류.')");
					script.println("history.back()");
					script.println("</script>");
				}
				//가입성공
				else if(result == 1 && result2 != 0) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('회원탈퇴 완료 저희 홈페이지를 이용해주셔서 감사합니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
			}
			}	
			%>
</body>
</body>
</html>