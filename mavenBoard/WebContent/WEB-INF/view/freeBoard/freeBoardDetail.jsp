<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<script>
	// 동기화 방식
	/* $(document).ready(function(){
	   $("#modify").click(function (){
		  $("#insertForm").submit(); 
	   });
	}); */

	// 비동기방식(ajax)
	$(document).ready(function(){
		$("#modify").click(function(){
			$.ajax({
				url : "freeBoardModify.ino",
				type : "POST",
				data : $("#insertForm").serialize(),
				success : function(data){
					console.log(data.key);
					if(data.key == 1){
						console.log($("#insertForm").serialize());
						alert("수정이 완료됐습니다");
						var conGo = confirm("메인화면으로 가시겠습니까?");
						if(conGo == true){
							location="./main.ino";
						}
					}else {
						alert("수정에 실패했습니다. 문제를 확인해주세요");
					}
				}
			});
		});
	});
</script>
</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form name="insertForm" id="insertForm" action="freeBoardModify.ino" method="post">
		<input type="hidden" name="num" id="num" value="${freeBoardDto.num }" />
		<%-- <input type="hidden" name="codeType" value="${freeBoardDto.codeType }"/> --%>
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="codeType">
							<option value="01"
									<c:if test="${freeBoardDto.codeType=='01'}">selected</c:if>>자유</option>
							<option value="02"
									<c:if test="${freeBoardDto.codeType=='02'}">selected</c:if>>익명</option>
							<option value="03"
									<c:if test="${freeBoardDto.codeType=='03'}">selected</c:if>>QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="수정" id="modify">
					<input type="button" value="삭제" onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'">
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>


<%-- 	<input type="hidden" name="num" value="${freeBoardDto.num }" />

		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></div>

		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${freeBoardDto.title }"/></div>

		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${freeBoardDto.regdate }"/></div>

		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></div>
		<div align="right">
		<input type="button" value="수정" onclick="modify()">
		<input type="button" value="삭제" onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'">

		<input type="button" value="취소" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div> --%>
<!-- $(document).ready(function(){
		$("#modify").click(function(){
			var insertForm = $("#insertForm").serialize(); 
			$ajax({
				url : './freeBoardModify.ino',
				type : 'post',
				date : insertForm,
				dataType : "json", 
				success : function(data){
					
				}
			});
		});
	}); -->
</body>
</html>