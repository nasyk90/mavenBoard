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
	// ����ȭ ���
	/* $(document).ready(function(){
	   $("#modify").click(function (){
		  $("#insertForm").submit(); 
	   });
	}); */

	// �񵿱���(ajax)
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
						alert("������ �Ϸ�ƽ��ϴ�");
						var conGo = confirm("����ȭ������ ���ðڽ��ϱ�?");
						if(conGo == true){
							location="./main.ino";
						}
					}else {
						alert("������ �����߽��ϴ�. ������ Ȯ�����ּ���");
					}
				}
			});
		});
	});
</script>
</head>
<body>

	<div>
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">

	<form name="insertForm" id="insertForm" action="freeBoardModify.ino" method="post">
		<input type="hidden" name="num" id="num" value="${freeBoardDto.num }" />
		<%-- <input type="hidden" name="codeType" value="${freeBoardDto.codeType }"/> --%>
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;">
						<select name="codeType">
							<option value="01"
									<c:if test="${freeBoardDto.codeType=='01'}">selected</c:if>>����</option>
							<option value="02"
									<c:if test="${freeBoardDto.codeType=='02'}">selected</c:if>>�͸�</option>
							<option value="03"
									<c:if test="${freeBoardDto.codeType=='03'}">selected</c:if>>QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="����" id="modify">
					<input type="button" value="����" onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'">
					<input type="button" value="���" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>


<%-- 	<input type="hidden" name="num" value="${freeBoardDto.num }" />

		<div style="width: 150px; float: left;">�̸� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></div>

		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${freeBoardDto.title }"/></div>

		<div style="width: 150px; float: left;">�ۼ�����</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${freeBoardDto.regdate }"/></div>

		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></div>
		<div align="right">
		<input type="button" value="����" onclick="modify()">
		<input type="button" value="����" onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'">

		<input type="button" value="���" onclick="location.href='./main.ino'">
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