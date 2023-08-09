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
	.table th{
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
        <span class="fs-4">게시글 상세보기</span>
      </a>

	<ul class="nav nav-pills">
			<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
			<li class="nav-item"><a href="write_form" class="nav-link">게시글 작성</a></li>
			<li class="nav-item"><a href="myMemoList?nowUser=${nowUser}" class="nav-link">내 게시글 보기</a></li>
			<li class="nav-item"><a href="myInfo?nowUser=${nowUser}" class="nav-link">내정보 보기</a></li>
      	<!--  <li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
		<li class="nav-item"><a href="write_form" class="nav-link">게시글 작성</a></li>
		<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>-->
	</ul>
		
</header>

<div class="bd-example">
	<table class="table table-bordered">
		<thead class="table-default">
		<c:forEach var="i" items="${memoDatail}">
		<tr>
			<th scope="col">작성자</th>
			<td>${i.m_id}
			<c:if test="${writeIdM_pro != null}">
			<img src="download?filename=${writeIdM_pro}" width="50" height="50">
			</c:if>
			</td>
		</tr>
		<tr>
			<th scope="col">작성날짜</th>
			<td>${i.m_date}</td>
		</tr>
		<tr>
			<th scope="col">글번호</th>
			<td>${i.m_num}</td>
		</tr>
		<tr>
			<th scope="col">조회수</th>
			<td>${i.m_view_cnt}</td>
		</tr>
		<tr>
			<th scope="col">글제목</th>
			<td>${i.m_title}</td>
		</tr>
		<tr>
			<th scope="col">글내용</th>
			<td>${i.m_con}
			<c:forEach var="j" items="${memoNumPic}">
			<img src="download?filename=${j}" width="500" height="500"><br><br>
			</c:forEach>
			<br><br><center><input type="button" value="추천" onclick="memoLike('${i.m_num}','${nowUserId}')"> ${i.m_like}</center><br>
			</td>
		</tr>
		<tr>
			<th scope="col">댓글</th>
			<td>
			<c:if test="${empty commentAll}">
			현재 게시물에 대한 댓글이 없습니다
			</c:if>
			<c:forEach var="k" items="${commentAll}">
				<c:choose>
					<c:when test="${nowUserId eq k.m_id}" >
<!--  						${k.m_id} : ${k.m_c_con} [${k.m_c_date}] <a href="#" onclick= modComment("${k.m_c_num}","${k.m_num}","${k.m_c_con}")>수정</a> / -->
						${k.m_id} : ${k.m_c_con} [${k.m_c_date}] <a href="#" onclick= "modComment('${k.m_c_num}','${k.m_num}','${k.m_c_con}')">수정</a> /
						<!--<a href="modComment?modnum=${k.m_c_num}&m_num=${i.m_num}">수정</a> / -->
						<a href="commentDel?delNum=${k.m_c_num}&m_num=${i.m_num}">삭제</a><br>
					</c:when>
					
					<c:when test="${nowUser eq 'admin'}">
						${k.m_id} : ${k.m_c_con} [${k.m_c_date}]
						<a href="commentDel?delNum=${k.m_c_num}&m_num=${i.m_num}">삭제</a><br>
					</c:when>
					
					<c:otherwise>
						${k.m_id} : ${k.m_c_con} [${k.m_c_date}]<br>	
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</td>
		</tr>
		<tr>
			<th scope="col">댓글 작성 ID [${nowUserId}]</th><!-- 접속중인 ID표시 -->
			<td>
			<form action="commentAdd" method="get" onsubmit="return chk()">
			<input type="hidden" name="m_num" value="${i.m_num}">
			<input type="hidden" name="m_id" value="${nowUserId}">
			<input type="text" name="m_c_con" size="80">
			<input type="submit" value="등록">
			</form>
			</td>
		</tr>
		</c:forEach>
	</table>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	function chk(){
		var comment = document.getElementsByName("m_c_con")[0].value;
		if(comment.trim() == ""){ // 공백 댓글 입력방지
			alert("댓글을 입력해주세요");
			return false;
		}
	}
	
	function modComment(cNum,mNum,comment){
		var a =prompt("댓글을 수정하세요",comment); 
		
		if(a == null){ // 취소를 누르면 Null값을 반환해서 취소시 원래 댓글 유지하기 위해 작성
			a = comment;
		}
		location.href="commentMod?modNum="+cNum+"&m_num="+mNum+"&inputModComment="+a;
	}
	
	function memoLike(mNum,userId){
		location.href="memoLike?m_num="+mNum+"&userId="+userId;
	}
</script>
</html>