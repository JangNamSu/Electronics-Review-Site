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
	
	.search{
		text-align: center;
	}
	
	.page{
		text-align: center;
	}
	
</style>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
</head>
<body>

<header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
      <a href="list_view" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
        <span class="fs-4">전체게시글보기</span>
      </a>
	
	<ul class="nav nav-pills">
		<c:if test="${nowUser == null }">
		    <li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="#" onclick=write_chk() class="nav-link">게시글 작성</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
		</c:if>
		
		<c:if test="${nowUser eq 'admin'}">
	    	<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
			<li class="nav-item"><a href="write_form" class="nav-link">게시글 작성</a></li>
			<li class="nav-item"><a href="myMemoList?nowUser=${nowUser}" class="nav-link">내 게시글 보기</a></li>
			<li class="nav-item"><a href="myInfo?nowUser=${nowUser}" class="nav-link">내정보 보기</a></li>
			<li class="nav-item"><a href="allMemberInfo" class="nav-link">회원정보보기</a></li>
		</c:if>
			
		<c:if test="${nowUser !=null and nowUser != 'admin'}">
			<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
			<li class="nav-item"><a href="write_form" class="nav-link">게시글 작성</a></li>
			<li class="nav-item"><a href="myMemoList?nowUser=${nowUser}" class="nav-link">내 게시글 보기</a></li>
			<li class="nav-item"><a href="myInfo?nowUser=${nowUser}" class="nav-link">내정보 보기</a></li>
		</c:if>
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
	
				<c:if test="${nowUser eq 'admin'}">
				<th scope="col">삭제</th>
				</c:if>
			</tr>
		</thead>
		<tbody>	
			<c:if test="${empty memoList}">
				<tr>
					<td colspan=8 style="text-align: center;">게시글이 없습니다.</td>
				</tr>
			</c:if>
			
			<c:forEach var="i" items="${memoList}" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${i.m_num }</td>
				<!-- <td><a href="list_datail?viewNum=${i.m_num}">${i.m_title}</a></td> -->
				<td><a href="#" onclick="datail_chk('${i.m_num}')">${i.m_title} [${i.m_com_cnt}]</a></td>
				<td>${i.m_id}</td>
				<td><input type="date" value= ${i.m_date} style="border:none" readonly></td>
				<td>${i.m_view_cnt}</td>
				<td>${i.m_like}</td>
				<c:if test="${nowUser eq 'admin'}">
				<td><a href="#" onclick="delete_chk('${i.m_num}')">Del</a></td>
				</c:if>
			</tr>
			</c:forEach>
		</tbody>
		<tbody class="page">
			<tr>
				<!-- page 정보 출력 page정보는 pageVO 객체가 저장하고 있음. 컨트롤러가 전달 함 -->
			<!-- 	<td><input type="button"></td> -->
				<td colspan=9>
					<c:if test="${pageVO.prev}">
						<a href="list_view?page=${pageVO.startPage -1}&search_word=${pageVO.search_word}">[이전페이지그룹]</a>
					</c:if><!-- page 정보 출력 변수명 startPage	endPage -->
					<c:forEach begin="${pageVO.startPage}" end="${pageVO.endPage }" var="idx">
						<a href="list_view?page=${idx}&search_word=${pageVO.search_word}">${idx}</a>			
					</c:forEach>
					<c:if test="${pageVO.next}">
						<a href="list_view?page=${pageVO.endPage +1}&search_word=${pageVO.search_word}">[다음페이지그룹]</a>
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</div>

	<form class="search" action="list_view" method="get">
		<input type="text" name="search_word" placeholder="제목을 검색해주세요..">
		<input type="submit" value="검색" >
	</form>
	
</body>
<script>

	function write_chk(){
		if("${nowUser}" == ""){
			alert("로그인 유저만 작성가능합니다")
			location.href=""; // 현재 URL 
		}else{
			location.href="write_form";
		}
	}
	
	function datail_chk(num){ // 매개변수로 게시글 번호로 받아서 
		if("${nowUser}" == ""){
			alert("로그인 유저만 조회가능합니다")
			// location.href  href 는 location 객체에 속해있는 프로퍼티로 현재 접속중인 페이지 정보를 갖고 있습니다.
   			//또한 값을 변경할 수 있는 프로퍼티이기 때문에 다른 페이지로 이동하는데도 사용되고 있습니다.
			location.href=""; // 현재 URL
		}else{
			location.href="list_datail?viewNum="+num;
		}
	}
	
	function delete_chk(num){ // 관리자가 게시글 삭제시
		
		if(confirm("정말로 삭제할까요?")){
			location.href="myMemoDel?m_id="+"${nowUser}"+"&DelNum="+num;
		}else{
			alert("삭제를 취소하였습니다.")
		}
		
	}
	
</script>
</html>