<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
	.bd-example{
		padding: 80px;
	}
	
	#modtr {
		border:none;
	}
	
	#modtd {
		border:none;
		color:black;
		text-align: center;
	}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
</head>
<body>
	
<header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
      <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
        <span class="fs-4">내 정보 수정하기</span>
      </a>

	<ul class="nav nav-pills">
		<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
		<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
		<li class="nav-item"><a href="write_form" class="nav-link">게시글 작성</a></li>
		<li class="nav-item"><a href="myMemoList?nowUser=${nowUser}" class="nav-link">내 게시글 보기</a></li>
		<li class="nav-item"><a href="myInfo?nowUser=${nowUser}" class="nav-link">내정보 보기</a></li>
	</ul>
</header>

	<div class="bd-example">
		<form action="myInfoMod_save" method="post" onsubmit="return chk()"
			encType="multipart/form-data">
			<table class="table table-bordered">
				<thead class="table-default">
					<c:forEach var="i" items="${myInfo}">
							<c:if test="${nowUser eq i.m_id}">
							<tr>
								<td>아이디 (수정불가)<input type="hidden" name="m_id" value="${i.m_id}"></td>
								<td>${i.m_id}</td>
							</tr>
							<tr>
								<td>이름 (수정불가)<input type="hidden" name="m_name" value="${i.m_name}"></td>
								<td>${i.m_name}</td>
							</tr>
							<tr>
								<td>비밀번호</td>
								<td><input type="password" name="m_pass" value="${i.m_pass}"></td>
							</tr>
							<tr>
								<td>프로필사진<input type="hidden" name="m_pro" value="${i.m_pro}"></td>
								<td><c:if test="${i.m_pro eq null}">
										 프로필 사진이 없습니다.(등록하려면 파일선택을 해주세요)<br>
									</c:if> 
									<c:if test="${not empty i.m_pro}">
										<img src="download?filename=${i.m_pro}" width="100" height="100">
										<input type="button" value="삭제" onclick="m_proDel('${i.m_pro}','${i.m_id}')">
									</c:if> 
									<input type="file" name="file"><br>
								</td>
							</tr>
							<tr>
								<td>등급 (수정불가)<input type="hidden" name="m_grade" value="${i.m_grade}"></td>
								<td>${i.m_grade}</td>
							</tr>
							<tr>
								<td>가입날짜 (수정불가)<input type="hidden" name="m_date" value="${i.m_date}"></td>
								<td>${i.m_date}</td>
							</tr>
							<tr id="modtr">
								<td id="modtd" colspan=2><input type="submit" value="수정하기">
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</thead>
			</table>
		</form>
	</div>

</body>

<script>
	const check_spc = /[\{\}\[\]\/?.;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\'"]/g;

	function m_proDel(m_pro,id) { // 프로필사진 삭제
		location.href="myInfoDel_m_pro?m_pro="+m_pro+"&m_id="+id;
		//location.href="myInfoDel_m_pro="+m_pro+"&m_id="id;
	}
	
	function chk(){ // 비밀번호 유효성검사
		var m_pass = document.getElementsByName("m_pass")[0].value;
		
		if(check_spc.test(m_pass) && m_pass.length >=6 && m_pass.length < 13){
			//alert("사용가능한 비밀번호입니다")
		}else{
			alert("비밀번호는 6~12 글자 특수문자 1개 이상은 필수입니다.")
			return false;
		}
		
		alert("수정완료");
	}
</script>

</html>