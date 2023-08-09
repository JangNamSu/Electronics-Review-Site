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
	        <span class="fs-4">내 게시글 보기</span>
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
		<table class="table">
			<thead class="table-dark">
				<tr>
					<th scope="col">순번</th>
					<th scope="col">글번호</th>
					<th scope="col">글제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
					<th scope="col">조회수</th>
					<th scope="col">추천</th>
					<th scope="col">수정/삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty myMemoList}">
					<tr>
						<td colspan=8 style="text-align: center;">작성한 게시글이 없습니다.</td>
					</tr>	
				</c:if>
				<c:forEach var="i" items="${myMemoList}" varStatus="status">
					<c:if test="${nowUser eq i.m_id}">
						<tr>
							<td>${status.count }</td>
							<td>${i.m_num }</td>
							<td><a href="#" onclick="datail_chk('${i.m_num}')">${i.m_title} [${i.m_com_cnt}]</a></td>
							<td>${i.m_id}</td>
							<td><input type="date" value=${i.m_date} style="border:none" user-select : none; readonly></td>
							<td>${i.m_view_cnt}</td>
							<td>${i.m_like}</td>
							<td><a href="myMemoMod_form?modNum=${i.m_num}">M</a> /
							<!-- <a href="myMemoDel?DelNum=${i.m_num}&m_id=${i.m_id}">D</a> -->
							<a href="#" onclick="delChk('${i.m_num}','${i.m_id}')">D</a> 
						</tr>
					</c:if>
				</c:forEach>
		</table>
	</div>
</body>
<script>
	function datail_chk(num){ // 매개변수로 게시글 번호로 받아서 
		location.href="list_datail?viewNum="+num;
	}
	
	function delChk(mNum,mId){
		if(confirm("게시글을 삭제하시겠습니까?")){
			location.href="myMemoDel?DelNum="+mNum+"&m_id="+mId;
		}
	}
</script>
</html>