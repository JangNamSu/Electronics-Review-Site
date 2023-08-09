<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<html>
<head>
	<title>Home</title>
	
<style>

	.title a{
		text-decoration: none;
	}
	
	.title{ 
		text-align: right;
		margin-right: 20;
	}
	
	#mainImg {
		margin: 0 auto;
		
		height: 600px;
		width: 600px;
	}
</style>

<!-- 부트스트랩 css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
</head>
<body>

<header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
      <a href="<%=request.getContextPath()%>/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
        <span class="fs-4">전자기기 리뷰사이트</span>
      </a>

      <ul class="nav nav-pills">
      
      	<c:if test="${nowUser eq 'admin'}">
      		<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
			<li class="nav-item"><a href="#" onclick=member_chk() class="nav-link">게시글 작성</a></li>
			<li class="nav-item"><a href="myMemoList?nowUser=${nowUser}" class="nav-link">내 게시글 보기</a></li>
			<li class="nav-item"><a href="myInfo?nowUser=${nowUser}" class="nav-link">내정보 보기</a></li>
			<li class="nav-item"><a href="allMemberInfo" class="nav-link">회원정보보기</a></li>
		</c:if>
		
		<c:if test="${nowUser !=null and nowUser != 'admin'}">
			<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
			<li class="nav-item"><a href="#" onclick=member_chk() class="nav-link">게시글 작성</a></li>
			<li class="nav-item"><a href="myMemoList?nowUser=${nowUser}" class="nav-link">내 게시글 보기</a></li>
			<li class="nav-item"><a href="myInfo?nowUser=${nowUser}" class="nav-link">내정보 보기</a></li>
		</c:if>
		
		<c:if test="${nowUser == null }">
			<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="sing_up_form" class="nav-link">회원가입</a></li>
			<li class="nav-item"><a href="#" onclick=member_chk() class="nav-link">게시글 작성</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>			
		</c:if>
		</ul>
		
</header>
	<c:if test="${nowUser == null }">
		<form id=frm1 action="login" method="post" style="margin-right: 20"; align="right">
			아이디 <input type="text" name="user_id" oninput = "login_chk()"> 
			비밀번호 <input type="password" name="user_pass" oninput = "login_chk()">
			<input type="submit" value="Login">
			<br><span class="login_chk" style="color:red; display:none;">로그인 실패! 아이디와 비밀번호를 확인해 주세요</span>
		</form>
	</c:if>

	<div class="title">
		<c:if test="${nowUser !=null and nowUser != 'admin'}">
			접속 ID : ${nowUser} 
			<a href="logout">[로그아웃]</a>
		</c:if>
		<c:if test="${nowUser eq 'admin'}">
			접속 ID : 관리자로 접속하였습니다
			<a href="logout">[로그아웃]</a>
		</c:if>
	</div>
	
	<br>
	<div id="mainImg">
		<img src="resources/img/homeImg.jpg" height="600px" width="600px">
	</div>
	

	
	<!-- 
<h1>
	전자기기 리뷰 사이트
</h1>

	<c:if test="${nowUser eq 'admin'}">
		<a href="<%=request.getContextPath()%>/">[Home]</a>
		<a href="list_view">[전체 게시물 보기]</a>
		<a href="allMemberInfo">[회원 정보 보기]</a>
		<hr>loginUser : 관리자로 접속하였습니다
		<a href="logout">[로그아웃]</a>
	</c:if>

	<c:if test="${nowUser !=null and nowUser != 'admin'}">
		<a href="<%=request.getContextPath()%>/">[Home]</a>
		<a href="#" onclick=member_chk()>[게시물 작성]</a>
		<a href="list_view">[전체 게시물 보기]</a>
		<a href="myMemoList?nowUser=${nowUser}">[내 게시물 보기]</a>
		<a href="myInfo?nowUser=${nowUser}">[내정보 보기]</a>
		<hr>loginUser : ${nowUser} 
		<a href="logout">[로그아웃]</a>
	</c:if>
	
	<c:if test="${nowUser == null }">
		<a href="<%=request.getContextPath()%>/">[Home]</a>
		<a href="sing_up_form">[회원가입]</a>
		<a href="#" onclick=member_chk()>[게시물 작성]</a>
		<a href="list_view">[전체 게시물 보기]</a><hr>
		<form action="login" method="post">
		아이디<input type = "text" name = "user_id">
		비밀번호<input type = "password" name = "user_pass">
		<input type="submit" value="Login">
		</form>
	</c:if>
 -->
</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>

	if("${msg}" != ""){
	//	alert("${msg}");
		//location.href="http://localhost:8088/electronics/";
		$('.login_chk').css("display","inline-block");
		//alert("아이디와 패스워드를 확인해 주세요");
		//alert(location.href)
		
	}
	
	function member_chk(){
		if("${nowUser}" == ""){
			alert("로그인 유저만 작성가능합니다");
			location.href=""; 
		}else{
			location.href="write_form";
		}
	}
	
	function login_chk(){
		$('.login_chk').css("display","none");
	}
	
</script>
</html>
