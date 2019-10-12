<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 뷰포트 -->
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<!-- 스타일시트 참조  -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<title>jsp 게시판 웹사이트</title>
	<style type="text/css">
		a, a:hover {
			color: #000000;
			text-decoration: none;
		}
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0"/>
	<title>JSP프로젝트  | 개인정보보호/정보보안 컨설팅</title>
	<link rel='dns-prefetch' href='//s.w.org' />
		<style type="text/css">
img.wp-smiley,
img.emoji {
	display: inline !important;
	border: none !important;
	box-shadow: none !important;
	height: 1em !important;
	width: 1em !important;
	margin: 0 .07em !important;
	vertical-align: -0.1em !important;
	background: none !important;
	padding: 0 !important;
}
</style>
<link rel='stylesheet' id='fc-form-css-css'  href='https://www.somansa.com/wp-content/plugins/formcraft3/assets/css/form.min.css?ver=3.2.26' type='text/css' media='all' />
<link rel='stylesheet' id='custom-css-css'  href='https://www.somansa.com/wp-content/plugins/jbrix/custom.css?ver=4.7.13' type='text/css' media='all' />
<link rel='stylesheet' id='theme-bxslider-css'  href='https://www.somansa.com/wp-content/themes/somansa/css/jquery.bxslider.css?ver=4.7.13' type='text/css' media='all' />
<link rel='stylesheet' id='theme-select-css'  href='https://www.somansa.com/wp-content/themes/somansa/css/custom-select.css?ver=4.7.13' type='text/css' media='all' />
<link rel='stylesheet' id='theme-basic-style-css'  href='https://www.somansa.com/wp-content/themes/somansa/style.css?ver=4.7.13' type='text/css' media='all' />
<link rel='stylesheet' id='theme-reset-css'  href='https://www.somansa.com/wp-content/themes/somansa/css/reset.css?ver=4.7.13' type='text/css' media='all' />
<link rel='stylesheet' id='theme-style-css'  href='https://www.somansa.com/wp-content/themes/somansa/css/style.css?ver=4.7.13' type='text/css' media='all' />
<link rel='stylesheet' id='theme-awesome-css'  href='https://www.somansa.com/wp-content/themes/somansa/font/font-awesome-4.7.0/css/font-awesome.min.css?ver=4.7.13' type='text/css' media='all' />
<script type='text/javascript' src='https://www.somansa.com/wp-content/themes/somansa/js/jquery.1.12.4.min.js?ver=4.7.13'></script>
<link rel='https://api.w.org/' href='https://www.somansa.com/wp-json/' />
<link rel="EditURI" type="application/rsd+xml" title="RSD" href="https://www.somansa.com/xmlrpc.php?rsd" />
<link rel="wlwmanifest" type="application/wlwmanifest+xml" href="https://www.somansa.com/wp-includes/wlwmanifest.xml" /> 
<meta name="generator" content="WordPress 4.7.13" />
<link rel="canonical" href="https://www.somansa.com/consulting/" />
<link rel='shortlink' href='https://www.somansa.com/?p=12' />
<link rel="alternate" type="application/json+oembed" href="https://www.somansa.com/wp-json/oembed/1.0/embed?url=https%3A%2F%2Fwww.somansa.com%2Fconsulting%2F" />
<link rel="icon" href="https://www.somansa.com/wp-content/uploads/2018/02/cropped-faviconsomansa-32x32.png" sizes="32x32" />
<link rel="icon" href="https://www.somansa.com/wp-content/uploads/2018/02/cropped-faviconsomansa-192x192.png" sizes="192x192" />
<link rel="apple-touch-icon-precomposed" href="https://www.somansa.com/wp-content/uploads/2018/02/cropped-faviconsomansa-180x180.png" />
<meta name="msapplication-TileImage" content="https://www.somansa.com/wp-content/uploads/2018/02/cropped-faviconsomansa-270x270.png" />

<meta name="google-site-verification" content="aurEQQMf24mw_ZzRqCEAWmiml9u8-Twp8ZEwTykwhyg" />
<meta name="naver-site-verification" content="b5964c146573abb3928cfdf872e4bb607b7eb64d"/>

</head>
<body class="page-template-default page page-id-12">
	<%
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		} 
		//로그인 안한 경우
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");			
		}
	%>
	<div id="wrapper">
			<div id="header_wrap">
					<div class="header">
							<h1><a href="main.jsp"><img src="http://localhost:18090/BBS2/image/LOGO2.jpg" alt="" class="logo"></a></h1>
							<p class="mMeun_btn">
								<span></span>
							</p>
							<div id="m_bg"></div>
							<ul class="nav">
									<li><a href="sollution.jsp">솔루션</a>
								</li>
									<li><a href="conselting.jsp">컨설팅</a></li>
									<li><a href="/security-service/webkeeper/webkeeper-report/latest-report/">자료실</a>
									</li>
									<li><a href="bbs2.jsp">게시판</a>
									</li>
									<li><a href="mypage2.jsp">마이페이지</a>
									<li><a href="information.jsp">회사소개</a>
							</ul>
					</div>
			</div>
			<!--header_wrap-->



<div id="primary" class="content-area">
	<main id="main" class="site-main" role="main">
		<article id="post-12" class="post-12 page type-page status-publish hentry">
	<div class="entry-content">
		<div class="sub_title">
    <p class="txt">소통의 공간</p>
</div>
<!--section_wrap-->
<div class="section_wrap">
	<ul class="fix_icon">
                <li>
                    <a href="okopok5019@naver.com">
                        <div>
                            <p><i class="fa fa-envelope-o" aria-hidden="true" style="font-size:40px;"></i></p>
                            <p>이메일문의</p>
                        </div>
                    </a>
                </li>
				<li>
                    <div>
                        <p><i class="fa fa-phone" aria-hidden="true" style="font-size:40px;"></i></p>
                        <p>전화문의<br />010-5514-7885</p>
                    </div>
                </li>
                                <li>
                    <div>
                        <p><i class="fa fa-phone" aria-hidden="true" style="font-size:40px;"></i></p>
                        <p>컨설팅 사업 본부<br />010-5321-4406</p>
                    </div>
                </li>
            </ul>
</div>
<br>
<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %> ">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">글
								수정 </th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>" ></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;" ><%= bbs.getBbsContent() %></textarea></td>
						</tr>
					</tbody>
				</table>	
				<button type="submit" class="btn btn-primary pull-right" >글수정</button>
			</form>
		</div>
	</div>
        <div class="sectionwrap">
            <div class="section">
                <div class="sub_cont">
                    <div class="dbi_cont">
                        <p class="dbi_tit">게시판</p>
                        <p class="dbi_tex">고객들과 소통할수 있는 공간입니다.<br /> 웹어플리케이션진단, 국가 주요정보통신 기반시설 취약점 분석/평가, 개인정보보호교육
                  </div>
                </div>
            </div>
        </div>
 
﻿<div id="footer_wrap">
    <div class="footer">
        <div class="top">
            <ul>
                <li><a href="/introduce/ceo/">회사소개</a></li>
                <li><a href="/introduce/recruit/recruitment/">인재채용</a></li>
            </ul>
        </div>
    </div>
    <div class="footer">
        <div class="bottom">
            <div>
                <h2><img src="/wp-content/themes/somansa/images/logo.png" alt=""></h2>
            </div>
            <div>
                <p>대표번호 : 010-5514-7885 <span>|</span>
                    <br/> 제품구매 : 010-5514-7885 (okopok5019@naver.com) <span>|</span> <br/>유지관리 : 010-5514-7885 (okopok5019@naver.com)
                    <br /><a href="/privacy_policy/">개인정보처리방침</a></p>
                <p>서울특별시 강서구 방화동
                    <br /> (c) 2019 HS co.,ltd. all rights reserved. </p>
            </div>
        </div>
    </div>
</div>
</div>
<!--section_wrap-->
<script type='text/javascript' src='https://www.somansa.com/wp-includes/js/wp-embed.min.js?ver=4.7.13'></script>
<!--스크립트 영역-->
<script src="//cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenMax.min.js"></script>
<script src="//maps.google.com/maps/api/js?key=AIzaSyCh9XhLYPf5bsOaLFePTcuszRgc5oXIU68"></script>
<script src="/wp-content/themes/somansa/js/gmaps.js"></script>
<script src="/wp-content/themes/somansa/js/jquery.bxslider.min.js"></script>
<script src="/wp-content/themes/somansa/js/custom-select.js"></script>
<script src="/wp-content/themes/somansa/js/site_function.js"></script>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<!-- 부트스트랩 JS  -->
		<script src="js/bootstrap.js"></script>
</body>
</html>