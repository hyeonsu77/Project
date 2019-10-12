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
	<!-- 스타일시트 참조  -->
	<link rel="stylesheet" href="css/bootstrap.css">
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
			int pageNumber = 1; //기본 페이지 넘버
			//페이지넘버값이 있을때
			if (request.getParameter("pageNumber") != null) {
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}
		%>
				<%
					//라긴안된경우
					if (userID == null) {
				%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="loginForm3.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul></li>
				</ul>
				<%
					} else {
				%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><font color="red"> |</font> [<%=userID %>]  님 환영합니다 <font color="red">|</font><span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logout.jsp">로그아웃</a></li>
						</ul></li>
				</ul>
				<%
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
									<li><a href="uploads.jsp">자료실</a>
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
    <p class="txt">자료실</p>
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
	<div class="section">
        <div class="sub_cont">
			<div class="dbi_cont">
            	<p class="dbi_tit">고객의 소중한 정보를 보호하기 위해 가이드 라인을 제공합니다.</p>
            </div>
        </div>
    </div>		
</div>

<div class="section_wrap">
    <div class="section">
        <div class="main_cont">
            <div class="solution_cont">
                <p class="tit_h3">  <span>Solution</span></p>
				<div>
					<div>
                        <p>개인정보<br />접근통제</p>
                        <a href="http://localhost:18090/BBS2/filedownload.jsp" alt="DB 접근통제 접근제어 DB방화벽">DB 접근통제 DB-i</a>
                        
					</div>
					<div>
                        <p>개인정보<br />DLP</p>
                        <a href="http://localhost:18090/BBS2/filedownload.jsp" alt="내부정보 유출방지 솔루션">네트워크DLP Mail-i</a>

					</div>
					<div>
                        <p>유해사이트<br />차단</p>
                        <a href="http://localhost:18090/BBS2/filedownload.jsp" alt="유해사이트 차단 비업무사이트 차단 솔루션">유해사이트차단 WebKeeper</a>
					</div>
					<div>
                        <p>랜섬웨어 백신<br />서비스</p>
                        <a href="http://localhost:18090/BBS2/filedownload.jsp">Wanacry Anti Viruse</a>
 
				  </div>
                  <div>
                      <p>DDOS<br />솔루션</p>
                      <a href="http://localhost:18090/BBS2/filedownload.jsp">Ddos 공격 차단</a>
                  </div>
				</div>
            </div>
        </div>
    </div>
</div>

<!-- section_wrrap Start -->

<div class="section_wrap bg_gray">
    <div class="section">
        <div class="main_cont">
            <div class="consulting_cont">
                <p class="tit_h3"> privacy <span>consulting</span> </p>
                <a href="/consulting/">
					<div>
						<p></p>
						<p class="intro_txt">개인정보 법규정에 최적화,법의 의도를 읽어내는 컨설팅
							<br /> 개인정보보호법, 정보통신망법, 신용정보법 등 개인정보 법규정에 최적화되어있습니다. <!-- 개인정보보호 정보보안 ISMS PIMS PIPL 컨설팅--> </p>
                	</div>
				</a>
            </div>
        </div>
    </div>
</div>


<!-- section _ wrap start  -->
<div class="section_wrap bg_sky">
    <div class="section">
        <div class="main_cont">
            <div class="service_cont">
                <p class="tit_h3"> <span>보안성 지속</span>서비스</p>
                <p class="intro_txt">보안은 지속 가능성이 핵심입니다. <br/> 보안의 허점은 끊임없이 발생하고 해커들의 공격은 날이 갈수록 거세집니다.
                    <br /> 보안에 꾸준히 투자하는 것, 그것이 바로 보안투자비용을 절감하는 길 입니다.  </p>
                <div class="report">
                    <div>
                        <a href="http://localhost:18090/BBS2/filedownload.jsp">
                            <div>
                                <p><img src="https://www.somansa.com/wp-content/uploads/2017/10/prire.png" alt="GDPR. 전 유럽연합에 적용되는 개인정보보호법. 핵심은 개인정보의 보호와 활용의 균형"></p>
                                <p>프라이버시 리포트 </p>
                            </div>
                           <!-- <p>프라이버시 리포트<span> 데이터 중심 보안체계 변동</span></p> -->
                        </a>
                    </div>
                    <div>
                        <a href="http://localhost:18090/BBS2/filedownload.jsp">
                            <div>
                             
                                <p> </p>
                            </div>
                            <!-- <p>웹키퍼 보안업데이트<span>37주차 (2017. 09. 11 ~  09. 15)</span></p> -->
                        </a>
                    </div>
                    <div>
                        <a href="http://localhost:18090/BBS2/filedownload.jsp">
                            <div>
                                <p><img src="https://www.somansa.com/wp-content/uploads/2017/09/malre-1.png" alt="HSJ 워너크라이 분석보고서 wannacry"></p>
                                <p>악성코드 분석리포트
                                </p>
                            </div>
                            <!-- <p>악성코드 분석리포트<span>WannaCry 2차 분석보고서</span></p> -->
						</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!--footer_wrap Start -->
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
