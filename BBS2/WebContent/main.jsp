<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"
	rel="stylesheet" />

<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!-- 뷰포트 -->

<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.css">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0" />

<title>JSP프로젝트 | 개인정보보호/정보보안 컨설팅</title>
<link rel="stylesheet"
	href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

<link rel='dns-prefetch' href='//s.w.org' />
<style type="text/css">
img.wp-smiley, img.emoji {
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

<link rel='stylesheet' id='fc-form-css-css'
	href='https://www.somansa.com/wp-content/plugins/formcraft3/assets/css/form.min.css?ver=3.2.26'
	type='text/css' media='all' />
<link rel='stylesheet' id='custom-css-css'
	href='https://www.somansa.com/wp-content/plugins/jbrix/custom.css?ver=4.7.13'
	type='text/css' media='all' />
<link rel='stylesheet' id='theme-bxslider-css'
	href='https://www.somansa.com/wp-content/themes/somansa/css/jquery.bxslider.css?ver=4.7.13'
	type='text/css' media='all' />
<link rel='stylesheet' id='theme-select-css'
	href='https://www.somansa.com/wp-content/themes/somansa/css/custom-select.css?ver=4.7.13'
	type='text/css' media='all' />
<link rel='stylesheet' id='theme-basic-style-css'
	href='https://www.somansa.com/wp-content/themes/somansa/style.css?ver=4.7.13'
	type='text/css' media='all' />
<link rel='stylesheet' id='theme-reset-css'
	href='https://www.somansa.com/wp-content/themes/somansa/css/reset.css?ver=4.7.13'
	type='text/css' media='all' />
<link rel='stylesheet' id='theme-style-css'
	href='https://www.somansa.com/wp-content/themes/somansa/css/style.css?ver=4.7.13'
	type='text/css' media='all' />
<link rel='stylesheet' id='theme-awesome-css'
	href='https://www.somansa.com/wp-content/themes/somansa/font/font-awesome-4.7.0/css/font-awesome.min.css?ver=4.7.13'
	type='text/css' media='all' />
<script type='text/javascript'
	src='https://www.somansa.com/wp-content/themes/somansa/js/jquery.1.12.4.min.js?ver=4.7.13'></script>
<link rel='https://api.w.org/' href='https://www.somansa.com/wp-json/' />
<link rel="EditURI" type="application/rsd+xml" title="RSD"
	href="https://www.somansa.com/xmlrpc.php?rsd" />
<link rel="wlwmanifest" type="application/wlwmanifest+xml"
	href="https://www.somansa.com/wp-includes/wlwmanifest.xml" />
<meta name="generator" content="WordPress 4.7.13" />
<link rel="canonical" href="https://www.somansa.com/consulting/" />
<link rel='shortlink' href='https://www.somansa.com/?p=12' />
<link rel="alternate" type="application/json+oembed"
	href="https://www.somansa.com/wp-json/oembed/1.0/embed?url=https%3A%2F%2Fwww.somansa.com%2Fconsulting%2F" />
<link rel="icon"
	href="https://www.somansa.com/wp-content/uploads/2018/02/cropped-faviconsomansa-32x32.png"
	sizes="32x32" />
<link rel="icon"
	href="https://www.somansa.com/wp-content/uploads/2018/02/cropped-faviconsomansa-192x192.png"
	sizes="192x192" />
<link rel="apple-touch-icon-precomposed"
	href="https://www.somansa.com/wp-content/uploads/2018/02/cropped-faviconsomansa-180x180.png" />
<meta name="msapplication-TileImage"
	content="https://www.somansa.com/wp-content/uploads/2018/02/cropped-faviconsomansa-270x270.png" />

<meta name="google-site-verification"
	content="aurEQQMf24mw_ZzRqCEAWmiml9u8-Twp8ZEwTykwhyg" />
<meta name="naver-site-verification"
	content="b5964c146573abb3928cfdf872e4bb607b7eb64d" />

</head>
<body class="page-template-default page page-id-12">

	<%
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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
				<li><a href="loginForm.jsp"></a></li>
				<li><a href="LoginForm3.jsp">로그인</a></li>
				<li><a href="join.jsp">회원가입</a></li>
			</ul></li>
	</ul>
	<%
		} else {
	%>
	<ul class="nav navbar-nav navbar-right">
		<li class="dropdown"><a href="#" class="dropdown-toggle"
			data-toggle="dropdown" role="button" aria-haspopup="true"
			aria-expanded="false">[<%=userID%>] 님 환영합니다<span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li><a href="main.jsp">로그아웃</a></li>
			</ul></li>
	</ul>
	<%
		}
	%>
	<div id="wrapper">
		<div id="header_wrap">
			<div class="header">
				<h1>
					<a href="/"><img
						src="http://localhost:18090/BBS2/image/LOGO2.jpg" alt=""
						class="logo"></a>
				</h1>
				<p class="mMeun_btn">
					<span></span>
				</p>
				<div id="m_bg"></div>
				<ul class="nav">
					<li><a href="sollution.jsp">솔루션</a></li>
					<li><a href="conselting.jsp">컨설팅</a></li>
					<li><a href="uploads.jsp">자료실</a></li>
					<li><a href="bbs2.jsp">게시판</a></li>
					<li><a href="mypage2.jsp">마이페이지</a>
					<li><a href="information.jsp">회사소개</a>
				</ul>
			</div>
		</div>
		<!--header_wrap-->

		<div id="primary" class="content-area">
			<main id="main" class="site-main" role="main">
			<article id="post-15"
				class="post-12 page type-page status-publish hentry">
				<div class="entry-content">
					<div class="sub_title">
						<p class="txt">Information Security</p>
					</div>
					<div id="myCarousel" class="carousel slide" data-ride="carousel">
						<!--페이지-->
						<ol class="carousel-indicators">
							<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
							<li data-target="#myCarousel" data-slide-to="1"></li>
							<li data-target="#myCarousel" data-slide-to="2"></li>
						</ol>
						<!--페이지-->
						<div class="carousel-inner">
							<!--슬라이드1-->
							<div class="item active">
								<img src="image/slide4.jpg" style="width: 200%; height: 300px;"
									alt="First slide">
								<div class="container">
									<div class="carousel-caption">
										<h1></h1>
										<p></p>
									</div>
								</div>
							</div>
							<!--슬라이드1-->

							<!--슬라이드2-->
							<div class="item">
								<img src="image/slide1.jpg" style="width: 100%; height: 300px;"
									data-src="" alt="Second slide">
								<div class="container">
									<div class="carousel-caption">
										<h1></h1>
										<p></p>
									</div>
								</div>
							</div>
							<!--슬라이드2-->
							<!--슬라이드3-->
							<div class="item">
								<img src="image/slide2.jpg" style="width: 100%; height: 300px;"
									data-src="" alt="Third slide">
								<div class="container">
									<div class="carousel-caption">
										<h1></h1>
										<p></p>
									</div>
								</div>
							</div>
							<!--슬라이드3-->
						</div>
						<!--이전, 다음 버튼-->
						<a class="left carousel-control" href="#myCarousel"
							data-slide="prev"><span
							class="glyphicon glyphicon-chevron-left"></span></a> <a
							class="right carousel-control" href="#myCarousel"
							data-slide="next"><span
							class="glyphicon glyphicon-chevron-right"></span></a>
					</div>
					<!--section_wrap-->
				</div>
				<div class="section_wrap">
					<ul class="fix_icon">
						<li><a href="okopok5019@naver.com">
								<div>
									<p>
										<i class="fa fa-envelope-o" aria-hidden="true"
											style="font-size: 40px;"></i>
									</p>
									<p>이메일문의</p>
								</div>
						</a></li>
						<li>
							<div>
								<p>
									<i class="fa fa-phone" aria-hidden="true"
										style="font-size: 40px;"></i>
								</p>
								<p>
									전화문의<br />010-5514-7885
								</p>
							</div>
						</li>
						<li>
							<div>
								<p>
									<i class="fa fa-phone" aria-hidden="true"
										style="font-size: 40px;"></i>
								</p>
								<p>
									컨설팅 사업 본부<br />010-5321-4406
								</p>
							</div>
						</li>
					</ul>

				</div>
				<div class="sectionwrap bg_gray02">
					<div class="section">
						<div class="sub_cont">
							<div class="dbi_cont">
								<div class="blue_box">
									<p>해커들은 당신의 트래픽을 언제 어디서든 훔쳐 보고 있습니다!</p><br>
									<div class="white_box white_box03">
										<div style="text-align: left">
											<ul>
												<li>https 는 필수 입니다. 해커는 당신의 인터넷 활동 을 모두 감시 하고 있습니다 
													http  로 접속한 당신은 모든 데이터 를 노출합니다.<br>
													https SSL/TLS 암호 프로토콜 는 당신의 인터넷 활동 을 암호화 합니다 그 누구도 감시 할 수 없습니다.<br>
													https 를 사용하는 홈페이지 가 바로 HSJ홈페이지 입니다.<br>
												</li>
											</ul>
										</div>
									</div>
									<div class="blue_box" style="width: 100%; height: 100px;"
										style="text-align:left">
										<p>
											7년간 유해사이트 4,100만 회 보안업데이트<br>5년간 악성코드 <br>2,700만회
											보안업데이트
										</p>
										<p></p>
									</div>
									<div class="white_box white_box03">
										<div>
											<ul>
												<li>악성코드사이트 암호화웹사이트 비업무사이트 및 넷앱스 등 유해사이트를 2010년부터
													2017년까지 8년간 총 6,800만 회<br> 보안업데이트하였습니다. 악성코드는 2012년부터
													2017년까지 6년 연속 총 6,400만 회 보안업데이트하였습니다. 30분 간격 보안업데이트<br>,
													일 1회 ‘웹키퍼 악성코드 데일리 카톡’, 주 1회 ‘웹키퍼 위클리’, 연 1회 ‘웹키퍼 애뉴얼’ 등
													보안업데이트<br> 공시시스템과 악성코드분석센터운영, 1000여개 고객사를 통한
													자동수집/분석시스템 등 6년간 구축해온 국내최대 인프라를 <br>통해 가장 빠르고 정확한
													보안업데이트 내역을 고객들에게 제공하고 있습니다
												</li>
											</ul>
										</div>
									</div>
									<div class="blue_box">
										<p>
											웹트래픽의 72%는 SSL/TLS!<br>SSL/TLS 가시성 확보를 통한 악성코드/유해사이트
											접속차단
										</p>
									</div>
									<div class="white_box white_box03">
										<div>
											<ul>
												<li>웹키퍼는 웹프록시를 이용해 SSL/TLS 가시성 확보 및 복호화를 통한 악성코드/유해사이트
													접속을 차단합니다. <br>구글서비스는 웹메일, 드라이브는 차단하고 캘린더, 검색기능은
													허용합니다. 구글번역기를 통한 악성코드/유해사이트<br> 우회접속을 차단합니다. 페이스북 계정별
													차단이 가능해 도박, 음란 등 불법/유해계정은 차단하고 회사홍보페이지 접속은 <br>허용할 수
													있습니다.<br /> 소만사는 자동화된 분석툴로 웹서비스를 통한 DB내 개인정보 과다조회를 정확하게
													컨설팅 할 수 있는 유일한 회사입니다.
												</li>
											</ul>
										</div>
									</div>
									<div class="blue_box">
										<p>
											국내유일 <br />개인정보 유출현황분석에 특화된 컨설팅
										</p>
									</div>
								</div>
								<div class="white_box white_box06">
									<div>
										<p>DDOS 차단</p>
									</div>
									<div>
										<p>악성코드 탐지</p>
									</div>
									<div>
										<p>통합 솔루션</p>
									</div>
								</div>

								<div class="section_wrap">
									<div class="section">
										<div class="main_cont">
											<div class="notice">
												<div>
													<div class="frame_wrap">
														<p>
															<iframe width="480" height="283"
																src="https://www.youtube.com/embed/rOSnPyCRJ78"
																frameborder="0" allowfullscreen=""></iframe>
														</p>
													</div>
												</div>
												<div>
													<div class="vision">
														<div class="vision_wrap">
															<div class="headline">
																<p class="title">악성코드 사이트 암호화 웹 사이트 비 업무 사이트 및 넷 앱스 등 유해 사이트 차단
															</div>

														</div>
														<font color="white"><br><br><br><br><br>
</font>

														<div class="bx-wrapper"
															style="max-width: 100%; margin: 0px auto;">
															<div class="bx-viewport"
																style="width: 100%; overflow: hidden; position: relative; height: 59px;">
																<ul
																	style="width: 515%; position: relative; transition-duration: 0s; transform: translate3d(-1314px, 0px, 0px);">
																	<li
																		style="float: left; list-style: none; position: relative; width: 438px;"
																		class="bx-clone"></li>
																</ul>
															</div>
															<div class="bx-controls"></div>
														</div>
													</div>


													<div class="news">
														<div class="headline">
															<p>
																<span>NEWS</span>
															</p>
														</div>
														https 는 필수 입니다. 해커는 당신의 인터넷 활동 을 모두 감시 하고 있습니다 http 로 접속한 당신은 모든 데이터 를 노출합니다.
https SSL/TLS 암호 프로토콜 는 당신의 인터넷 활동 을 암호화 합니다 그 누구도 감시 할 수 없습니다.
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="footer_wrap">
					<div class="footer">
						<div class="top">
							<ul>
								<li><a href="/introduce/ceo/">회사소개</a></li>
								<li><a href="/introduce/recruit/recruitment/">인재채용</a></li>
							</ul>
						</div>
					</div>
					<div class="footer">

						<div style="text-align: left">
							<br>영향평가, 개인정보 관리체계 인증(PIMS) <br> 정보보호관리체계인증(KISA ISMS)
							<br>ISO 27001인증 <br>웹어플리케이션진단 <br>국가 주요정보통신 기반시설
							취약점 분석/평가 <br>개인정보보호교육
						</div>
						<div>
							<div>
								<h2>
									<img src="/wp-content/themes/somansa/images/logo.png" alt="">
								</h2>
							</div>
							<span> 대표번호 : 010-5514-7885 <span>|</span>
								제품구매:010-5514-7885 (okopok5019@naver.com) <span>|</span> <br>유지관리
								: 010-5514-7885 (okopok5019@naver.com) <a
								href="/privacy_policy/">개인정보처리방침</a> <br> 서울특별시 강서구 방화동 (c)
								2019 HS co.,ltd. all rightsreserved.<br>
							</span>
						</div>
					</div>
				</div>
		</div>
	</div>
	<!--section_wrap-->
	<script type='text/javascript'
		src='https://www.somansa.com/wp-includes/js/wp-embed.min.js?ver=4.7.13'></script>
	<!--스크립트 영역-->
	<script
		src="//cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenMax.min.js"></script>
	<script
		src="//maps.google.com/maps/api/js?key=AIzaSyCh9XhLYPf5bsOaLFePTcuszRgc5oXIU68"></script>
	<script src="/wp-content/themes/somansa/js/gmaps.js"></script>
	<script src="/wp-content/themes/somansa/js/jquery.bxslider.min.js"></script>
	<script src="/wp-content/themes/somansa/js/custom-select.js"></script>
	<script src="/wp-content/themes/somansa/js/site_function.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>

</body>
</html>