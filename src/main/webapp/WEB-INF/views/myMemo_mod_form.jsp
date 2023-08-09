<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#contents{
		height: 100px;
	}
	
	#centerForm{
		text-align: center;
	}
	
	#file .col-sm-5{
		text-align: center;
		vertical-align: middle;
	}
	
	.col-sm-5 {
  		display: inline-block;
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
	        <span class="fs-4">게시글 수정하기</span>
	      </a>
	
		<ul class="nav nav-pills">
			<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
			<li class="nav-item"><a href="write_form" class="nav-link">게시글 작성</a></li>
			<li class="nav-item"><a href="myMemoList?nowUser=${nowUser}" class="nav-link">내 게시글 보기</a></li>
			<li class="nav-item"><a href="myInfo?nowUser=${nowUser}" class="nav-link">내정보 보기</a></li>
		</ul>
	</header>

<div id="centerForm">
	<c:forEach var="i" items="${myMemoList}" >
		<form action = "myMemoMod_save" method="post" encType="multipart/form-data" onsubmit="return chk()">
			<!-- 작성자 ID --><input type="hidden" name="m_id" value="${i.m_id}" readonly>
			<!-- 글번호 --><input type="hidden" name="m_num" value="${i.m_num}" readonly>
			<div class="mb-3">
				<label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="m_title" value="${i.m_title}">
				</div>
			</div>
			<div class="mb-3">
				<label for="inputCon" class="col-sm-2 col-form-label">내용</label>
				<div class="col-sm-5">
					<input id="contents" type="text" class="form-control" name="m_con" value="${i.m_con}">
				</div>
			</div>
			
			<c:if test="${not empty memoNumPic}">
				<div class="mb-3">
					<label for="inputTitle" class="col-sm-2 col-form-label">기존첨부사진</label>
					<div class="col-sm-5">
						<c:forEach var="j" items="${memoNumPic}">
							<img src="download?filename=${j}" width="80" height="80">
							<input type="button" value="삭제" onclick="delPic('${j}','${i.m_num}')">
						</c:forEach>
					</div>
				</div>
			</c:if>
			
			
<%-- 			<c:if test="${not empty memoNumPic}"> --%>
<!-- 			기존첨부사진 -->
<%-- 				<c:forEach var="j" items="${memoNumPic}"> --%>
<%-- 					<img src="download?filename=${j}" width="80" height="80"> --%>
<%-- 					<input type="button" value="삭제" onclick=delPic("${j}","${i.m_num}")> --%>
<%-- 				</c:forEach> --%>
<!-- 				<br><br> -->
<%-- 			</c:if> --%>
			
			<div class="mb-3" id="file">
				<label for="inputFile" class="col-sm-2 col-form-label">첨부사진추가</label>
				<div class="col-sm-5">
					<input class="form-control" type="file" name="MemoFile" value="${memoNumPic}"><br>
					<input class="form-control" type="file" name="MemoFile" value="${memoNumPic}"><br>
					<input class="form-control" type="file" name="MemoFile" value="${memoNumPic}">
				</div>
			</div>
			<br>
			<div class="col-sm-5">
				<input type="submit" value="작성완료">
			</div>
		</form>
	</c:forEach>
</div>
	<!-- 
	<h2> 수정할 내용을 입력해 주세요 </h2>
	<c:forEach var="i" items="${myMemoList}">
		<form action = "myMemoMod_save" method="post" encType="multipart/form-data">
			작성자 ID<br><input type="text" name="m_id" value="${i.m_id}" readonly><br>
			글번호<br><input type="text" name="m_num" value="${i.m_num}" readonly><br>
			제목<br><input type="text" name="m_title" value="${i.m_title}"><br>
			내용<br><input type="text" name="m_con" value="${i.m_con}" ><br><br>

			<c:if test="${not empty memoNumPic}">
			기존첨부사진<br>
				<c:forEach var="j" items="${memoNumPic}">
					<img src="download?filename=${j}" width="50" height="50">
					<input type="button" value="삭제" onclick=delPic("${j}","${i.m_num}")>
				</c:forEach>
				<br><br>
			</c:if>
			
			첨부사진1<br><input type="file" name= "MemoFile" value="${memoNumPic}"><br>
			첨부사진2<br><input type="file" name= "MemoFile" value="${memoNumPic}"><br>
			첨부사진3<br><input type="file" name= "MemoFile" value="${memoNumPic}"><br>
			<br><input type="submit" value="작성완료">		

		</form>
	</c:forEach>
	 -->
</body>
<script>
	function delPic(pname,m_num){
		location.href="myMemoDelPic?pname="+pname+"&m_num="+m_num;
	}
	
	function chk(){
		var title = document.getElementsByName("m_title")[0].value
		var contents = document.getElementsByName("m_con")[0].value
		
		if(title.trim() == ""){
			alert("제목을 입력해주세요");
			return false;
		}else if(contents.trim() == ""){
			alert("내용을 입력해주세요");
			return false;
		}
	}
	
</script>
</html>