<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<style>
@import url('https://fonts.googleapis.com/css?family=Numans');

html,body{

background-image: url('http://getwallpapers.com/wallpaper/full/a/5/d/544750.jpg');

background-size: cover;
background-repeat: no-repeat;
height: 100%;
font-family: 'Numans', sans-serif;
}

.container{
height: 100%;
align-content: center;
}

.card{
height: 490px;
margin-top: auto;
margin-bottom: auto;
width: 400px;
background-color: rgba(0,0,0,0.5) !important;
}

.social_icon span{
font-size: 60px;
margin-left: 10px;
color: #FFC312;
}

.social_icon span:hover{
color: white;
cursor: pointer;
}

.card-header h3{
color: white;
}

.social_icon{
position: absolute;
right: 20px;
top: -45px;
}

.input-group-prepend span{
width: 50px;
background-color: #FFC312;
color: black;
border:0 !important;
}

input:focus{
outline: 0 0 0 0  !important;
box-shadow: 0 0 0 0 !important;

}

.remember{
color: white;
}

.remember input
{
width: 20px;
height: 20px;
margin-left: 15px;
margin-right: 5px;
}

.login_btn{
color: black;
background-color: #FFC312;
width: 100px;
}

.login_btn:hover{
color: black;
background-color: white;
}

.links{
color: white;
}

.links a{
margin-left: 4px;
}
</style>
	<title>Login Page</title>
   <!--Made with love by Mutiullah Samim -->
	<!--Bootsrap 4 CDN-->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    
    <!--Fontawesome CDN-->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

	<!--Custom styles-->
	<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<div class="container">
	<div class="d-flex justify-content-center h-100">
		<div class="card">
			<div class="card-header">
				<h3>Sign In</h3>
				<div class="d-flex justify-content-end social_icon">
					<span><i class="fab fa-facebook-square"></i></span>
					<span><i class="fab fa-google-plus-square"></i></span>
					<span><i class="fab fa-twitter-square"></i></span>
				</div>
			</div>
			<div class="card-body">
				<form action="joinAction.jsp" method="post" name="boardWriteForm" onsubmit="return post_check()">
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-user"></i></span>
						</div>
						<input type="text" name="userID" class="form-control" placeholder="아이디"> 
					</div>
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-key"></i></span>
						</div>
						
						<input type="password" name="userPassword" class="form-control" placeholder="비밀번호">
					</div>
					
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-key"></i></span>
						</div>
						
						<input type="password" name="userNewPassword" class="form-control" placeholder="비밀번호 확인">
					</div>
					
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-"></i></span>
						</div>
						<input type="text" name="userName" class="form-control" placeholder="이름">
					</div>
										
				<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-"></i></span>
						</div>
						<input type="text" name="userEmail" class="form-control" placeholder="이메일">
					</div>
					
					<div class="input-group form-group center" data-toggle="buttons">
						<label class="btn btn-primary active"> <input
						 type="radio" name="userGender" autocomplete="off" value="남자"
						 checked>남자
						</label> <label class="btn btn-primary"> <input type="radio"
						 name="userGender" autocomplete="off" value="여자" >여자
					    </label>
					</div>
					
					<div class="row align-items-center remember">
						<input type="checkbox">Remember Me
					</div>
					
					<div class="form-group">
						<input type="submit" value="Join" class="btn float-right login_btn">
					</div>
				</form>
			</div>
			
			<div class="card-footer">
				<div class="d-flex justify-content-center links">
					Don't have an account?<a href="loginForm3.jsp">Login</a>
				</div>
				<div class="d-flex justify-content-center">
					<a href="#">Forgot your password?</a>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function post_check() // 회원가입 유효성 검사 체크 함수
{
 //HTML의 form name="boardWriteForm"
 //유효성체크하고 싶은 값의 id, name="content_pwd", maxlength="16"
  var userPassword = document.boardWriteForm.userPassword;

  if(userPassword.value.length<8) {
    alert("비밀번호는 8자리 이상입니다");
    return false;
  }
  
  if(!userPassword.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
    alert("비밀번호는 영문,숫자,특수문자 를 혼용하여 8~16자를 입력해주세요.");
    return false;
  }
  return true;
}

</script>


</body>
</html>



