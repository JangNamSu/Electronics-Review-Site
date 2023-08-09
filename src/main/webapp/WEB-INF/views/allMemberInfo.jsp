<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	.table a{
		text-decoration: none;
	}
</style>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
</head>
<body>

	<header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
	      <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
	        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
	        <span class="fs-4">회원정보보기</span>
	      </a>
	
		<ul class="nav nav-pills">
	      	<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="write_form" class="nav-link">게시글 작성</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
		</ul>
			
	</header>
<div class="bd-example">
	<table class="table">
		<thead class="table-dark">	
			<tr>
				<th scope="col">순번</th>
				<th scope="col">아이디</th>
				<th scope="col">이름</th>
				<th scope="col">프로필사진</th>
				<th scope="col">가입날짜</th>
				<th scope="col">등급</th>
				<th scope="col">탈퇴</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" items="${allMemberInfo}" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${i.m_id}</td>
				<td>${i.m_name}</td>
				<td>
					<c:choose>
						<c:when test="${i.m_pro != null}">
						<img src="download?filename=${i.m_pro}" width="50" height="50">
						</c:when>
						<c:otherwise>null</c:otherwise>
					</c:choose>
				</td>
				<td>${i.m_date}</td>
				<td>${i.m_grade}</td>
				<td><a href="#" onclick="delChk('${i.m_id}')">탈퇴</a>
				</td>  
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</body>

<script>
	function delChk(id){
		if(confirm("정말로 탈퇴시키겠습니까?")){
			location.href="selMemberDel?m_id="+id;
		}else{
			alert("탈퇴를 취소하였습니다");
		}
	}
</script>
</html>