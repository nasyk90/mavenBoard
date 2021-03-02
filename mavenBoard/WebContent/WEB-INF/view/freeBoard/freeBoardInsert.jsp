<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#submit").click(function(){
			var value = {
				'codeType' : $("#codeType").val(),
				'title' : $("#title").val(),
				'name' : $("#name").val(),
				'content' : $("#content").val()
			};
			var emp = /\s/g;
			console.log(value.title);
			console.log(value.name);
			if($.trim(value.title)=="" && $.trim(value.name)==""){
				alert("이름, 혹은 글제목을 입력해주세요");
			} else {
				$.ajax({
					url : 'freeBoardInsertPro.ino',
					type : 'POST',
					data : value,
					success : function(data){
						console.log(data.num);
						alert("등록이 완료되었습니다");
						var conGo = confirm("작성글을 확인하시겠습니까?")
						if(conGo == true){
							location="./freeBoardDetail.ino?num="+data.num;
						}else{
							location="./main.ino";
						}
					}
				});
			}
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

	<form action="./freeBoardInsertPro.ino">
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="codeType" id="codeType">
							<option value="01">자유</option>
							<option value="02">익명</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" id="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="글쓰기" id="submit">
					<input type="button" value="다시쓰기" onclick="reset()">
					<input type="button" value="취소" onclick="location='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>



</body>
</html>