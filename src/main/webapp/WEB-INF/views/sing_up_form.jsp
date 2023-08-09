<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#centerForm {
		text-align: center;
	}
	
	.col-sm-4 {
		display: inline-block;
		text-align: center;
		white-space: nowrap;
	}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
</head>
<body>
	<header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
	      <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
	        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
	        <span class="fs-4">회원가입</span>
	      </a>
	
		<ul class="nav nav-pills">
	      	<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
		</ul>
			
	</header>
	
	<div id="centerForm">
		<form action="sing_up_save" method="post" onsubmit="return chk()"
			encType="multipart/form-data">
			<div class="mb-3">
				<div class="col-sm-4" style="text-align: left;">
					<label for="inputId" class="col-sm-2 col-form-label" >아이디</label>
					<input type="text" class="form-control" name="m_id" id="id" oninput = "checkId()" required>
					<span class="id_ok" style="color:green; display:none;">사용 가능한 아이디 입니다</span>
					<span class="id_already" style="color:red; display:none;">중복된 아이디입니다!</span>
					<span class="id_chk" style="color:red; display:inline-block;">영어와 숫자 조합 6글자 이상 12글자 이하 입력</span>
				</div>
			</div>
			<div class="mb-3">
				<div class="col-sm-4" style="text-align: left;">
					<label for="inputName" class="col-sm-2 col-form-label">이름</label>
					<input type="text" class="form-control" name="m_name" required>
				</div>
			</div>
			<div class="mb-3">
				<div class="col-sm-4" style="text-align: left;">
					<label for="inputPassword" class="col-sm-2 col-form-label">패스워드</label>
					<input type="password" class="form-control" name="m_pass" id="pw" oninput = "checkPw()" required>
					<span class="pw_ok" style="color:green; display:none;">사용 가능한 비밀번호 입니다</span>
					<span class="pw_chk" style="color:red; display:inline-block;">6글자 이상 12글자 이하 특수문자 1개 이상 입력</span>
				</div>
			</div>
			<div class="mb-3">
				
				<div class="col-sm-4" style="text-align: left;">
					<label for="inputFile" class="col-sm-2 col-form-label" style="white-space: nowrap;">프로필사진</label>
					<input class="form-control" type="file" name="file">
				</div>
			</div>
			<br>
			<div class="col-sm-4">
				<input type="submit" id="submit" value="회원가입">
			</div>
		</form>
	</div>


	<!-- 
	<a href="<%=request.getContextPath()%>/">[Home]</a>
	<a href="sing_up_form">[회원가입]</a>
	<a href="list_view">[전체 게시물 보기]</a>
	<hr>
	<h2> 아래 정보를 입력해 주세요</h2>
	<form action = "sing_up_save" method="post" onsubmit="return chk()"
	encType="multipart/form-data">
		아이디<br><input type="text" name="m_id"><br>
		이름<br><input type="text" name="m_name"><br>
		패스워드<br><input type="text" name="m_pass"><br>
		프로필사진<br><input type="file" name="file">
	<br><input type="submit" value="회원가입">
	
	</form>
 -->
</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	const check_eng = /[a-zA-Z]/;
	const check_num= /[0-9]/;
	const check_spc = /[\{\}\[\]\/?.;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\'"]/g;
	const check_engNum = /^[a-zA-Z0-9]+$/;
	
	function chk(){
		var m_id = document.getElementsByName("m_id")[0].value;
		var m_pass = document.getElementsByName("m_pass")[0].value;
		var m_name = document.getElementsByName("m_name")[0].value;
	
		if(check_engNum.test(m_id)){
			if(m_id.length >= 6 && check_num.test(m_id)){
				//alert("사용가능한 아이디 입니다.")	
			}else{
				alert("아이디는 영어와 숫자 조합 6글자 이상만 가능합니다.[1]")
				return false;
			}
		}else{
			alert("아이디는 영어와 숫자 조합 6글자 이상만 가능합니다.[2]")
			return false;
		}
		
		if(m_name == ""){
			alert("이름을 입력해주세요");
			return false;
		}
		
		if(m_pass.length >= 6){
			
		}else{
			alert("비밀번호는 6글자 이상입니다.")
			return false;
		}
		
		if(check_spc.test(m_pass)){
			//alert("사용가능한 비밀번호입니다")
			alert("회원가입 완료");
		}else if(!check_spc.test(m_pass)){
			alert("비밀번호는 특수문자 1개 이상은 필수입니다.");
			return false;
		}
		
// 		if(check_spc.test(m_pass)){	// 조건이 참이면
// 			//alert("사용가능한 비밀번호입니다")
// 			alert("회원가입 완료");
// 		}else{	// 조건이 참이 아니면
// 			alert("리턴값은 : "+check_spc.test(m_pass));
// 			alert("비밀번호는 특수문자 1개 이상은 필수입니다.");
// 			return false;
// 		}
		
// 		if(!check_spc.test(m_pass)){	
// 			alert("비밀번호는 특수문자 1개 이상은 필수입니다.")
// 			return false;
// 		}else{
// 			//alert("사용가능한 비밀번호입니다")
// 			alert("회원가입 완료")
// 		}
	
	}
	
	function checkPw(){ // 비밀번호 입력할때 마다 체크
		//var m_pass = document.getElementsByName("m_pass")[0].value;
		var pw = $('#pw').val();
		if(check_spc.test(pw) && pw.length >= 6){	// 특수 문자가 포함이면
			$('.pw_ok').css("display", "inline-block");
			$('.pw_chk').css("display", "none");
		}else if(!check_spc.test(pw)){	// 특수문자가 포함이 아니면
			$('.pw_ok').css("display", "none");
			$('.pw_chk').css("display", "inline-block");
		}
	}
	
	function checkId(){
		var id = $('#id').val();
//		alert("id");
		$.ajax({
			url:"idcheck",
			type:'get',
			data:{id:id},
			dataType: 'json',
			success:function(cnt){ // 컨트롤러에서 넘어온 cnt값
				if(cnt !=1 && id.length > 5 && check_engNum.test(id)){ // 영어와 특수문자가 포함
					if(check_num.test(id)){ // 숫자가 있어야함
						$('.id_ok').css("display", "inline-block");
						$('.id_already').css("display", "none");
						$('.id_chk').css("display", "none");
					}
				}else if(cnt == 1 && id.length > 0) { // 중복된 아이디
					$('.id_already').css("display", "inline-block");
					$('.id_ok').css("display", "none");
					$('.id_chk').css("display", "none");
				}else{ 
					$('.id_ok').css("display", "none");
					$('.id_already').css("display", "none");
					$('.id_chk').css("display", "inline-block");
				}

			},
			error:function(request, error){
				alert("에러입니다");
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error"+error);
			}
		});
	}
	
//		if(cnt !=1 && id.length > 5 && check_num.test(id) && check_eng.test(id) ){ // 사용 가능한 아이디
//		$('.id_ok').css("display", "inline-block");
//		$('.id_already').css("display", "none");
//		$('.id_chk').css("display", "none");
//	}else if(cnt == 1 && id.length > 0) { // 중복된 아이디
//		$('.id_already').css("display", "inline-block");
//		$('.id_ok').css("display", "none");
//		$('.id_chk').css("display", "none");
//	}else if(!check_test.test(id)){
//		$('.id_chk').css("display", "inline-block");
//		$('.id_ok').css("display", "none");
//		$('.id_already').css("display", "none");
//	}else{ // id에 아무것도 입력하지 않을 경우 중복검사 문구 모두 안보이게 설정
//		$('.id_ok').css("display", "none");
//		$('.id_already').css("display", "none");
//		$('.id_chk').css("display", "inline-block");
//	}

		
//	if(check_num.test(id) && check_eng.test(id)){
//		$('.id_ok').css("display", "inline-block");
//		$('.id_already').css("display", "none");
//		$('.id_chk').css("display", "none");
//	}else{
//		$('.id_chk').css("display", "inline-block");
//		$('.id_ok').css("display", "none");
//		$('.id_already').css("display", "none");
//	}

</script>
</html>