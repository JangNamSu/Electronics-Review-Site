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
		padding: 100px;
	}
	
	.table td{
		text-align: center;
		vertical-align: middle;
	}
</style>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
</head>
<body>

<header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
      <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
        <span class="fs-4">내정보 조회</span>
      </a>

	<ul class="nav nav-pills">
		<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
		<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
		<li class="nav-item"><a href="write_form" class="nav-link">게시글 작성</a></li>
		<li class="nav-item"><a href="myMemoList?nowUser=${nowUser}" class="nav-link">내 게시글 보기</a></li>
		<li class="nav-item"><a href="myInfo?nowUser=${nowUser}" class="nav-link">내정보 보기</a></li>
	</ul>
		
</header>

<c:forEach var="i" items="${myInfo}">
	<div class="bd-example">
		<table class="table table-bordered">
			<c:if test="${nowUser eq i.m_id}">
				<thead class="table-default">
					<tr>
						<td>아이디</td>
						<td>${i.m_id}</td>
					</tr>
					<tr>
						<td>이름</td>
						<td>${i.m_name}</td>
					</tr>
					<tr>
						<td>프로필사진</td>
						
						<td>
						<c:if test= "${i.m_pro eq null}">
							프로필 사진이 없습니다.<br>
						</c:if>
						<c:if test= "${not empty i.m_pro}">
							<img src="download?filename=${i.m_pro}" width="100"
							height="100">
						</c:if>
						</td>
						<!-- <td>${i.m_pro}</td> -->
					</tr>
					<tr>
						<td>등급</td>
						<td>${i.m_grade}</td>
					</tr>
					<tr>
						<td>가입날짜</td>
						<td>${i.m_date}</td>
					</tr>
					<tr style="border: none;">
						<td colspan=2 style=border:none;>
						<input type="button" value="내 정보 수정하기" onclick="myInfoMod('${i.m_id}')">
						<input type="button" value="회원 탈퇴" onclick="delChk('${i.m_id}')">
						</td>
					</tr>
				</thead>
			</c:if>
		</table>
	</div>
</c:forEach>

</body>
<script>
	function myInfoMod(nowUser){
		location.href="myInfoMod_form?nowUser="+nowUser;
	}
	
	function delChk(id){
		if(confirm("정말로 회원탈퇴 하시겠습니까?")){
			location.href="selMemberDel?m_id="+id;
		}else{
			alert("회원탈퇴를 취소하였습니다.");
		}
	}
</script>
</html>