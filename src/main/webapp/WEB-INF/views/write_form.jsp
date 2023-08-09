<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<style>
	#centerForm {
		text-align: center;
	}
	.col-sm-5 {
		display: inline-block;
		text-align: center;
	}
	#file .col-sm-5{
		text-align: center;
		vertical-align: middle;
	}
	#contents{
		height: 300px;
	}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
</head>
<body>

	<header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
	      <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
	        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
	        <span class="fs-4">게시글 작성</span>
	      </a>
	
		<ul class="nav nav-pills">
			<li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li>
			<li class="nav-item"><a href="#" onclick=member_chk() class="nav-link">게시글 작성</a></li>
			<li class="nav-item"><a href="myMemoList?nowUser=${nowUser}" class="nav-link">내 게시글 보기</a></li>
			<li class="nav-item"><a href="myInfo?nowUser=${nowUser}" class="nav-link">내정보 보기</a></li>
	      	<!-- <li class="nav-item"><a href="<%=request.getContextPath()%>/" class="nav-link active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="list_view" class="nav-link">전체 게시글 보기</a></li> -->
		</ul>
	</header>

	<div id="centerForm">
		<form action = "write_save" method="post" encType="multipart/form-data" onsubmit="return memo_chk()"
		style="align-items: center;">
			<div class="mb-3">
				<label for="inputId" class="col-sm-2 col-form-label">작성자아이디</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="m_id" value="${userId}" readonly>
				</div>
			</div>
			<div class="mb-3">
				<label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="m_title">
				</div>
			</div>
			<div class="mb-3">
				<label for="inputCon" class="col-sm-2 col-form-label">내용</label>
				<div class="col-sm-5">
					<input id="contents" type="text" class="form-control" name="m_con">
				</div>
			</div>
			<div class="mb-3" id="file">
				<label for="inputFile" class="col-sm-2 col-form-label">첨부사진</label>
				<div class="col-sm-5">
					<input class="form-control" type="file" name="MemoFile"><br>
					<input class="form-control" type="file" name="MemoFile"><br>
					<input class="form-control" type="file" name="MemoFile">
				</div>
			</div>
			<br>
			<div class="col-sm-5">
				<input type="submit" id="submit" value="작성완료">
			</div>
		</form>
	</div>

	<!-- 
	<form action = "write_save" method="post" encType="multipart/form-data" onsubmit="return memo_chk()">
		작성자 ID<br><input type="text" name="m_id" value="${userId}" readonly><br>
		제목<br><input type="text" name="m_title"><br>
		내용<br><input type="text" name="m_con"><br>
		첨부사진1<br><input type="file" name= "MemoFile"><br>
		첨부사진2<br><input type="file" name= "MemoFile"><br>
		첨부사진3<br><input type="file" name= "MemoFile"><br>
	<br><input type="submit" value="작성완료">		
	
	</form>
 -->
</body>
<script>
	function memo_chk(){
		var title = document.getElementsByName("m_title")[0].value;
		var contents = document.getElementsByName("m_con")[0].value;
		
		if(title.trim() == ""){
			alert("제목을 입력해주세요")
			return false;
		}
		
		if(contents.trim() == ""){
			alert("내용을 입력해주세요")
			return false;
		}
	}
</script>
</html>