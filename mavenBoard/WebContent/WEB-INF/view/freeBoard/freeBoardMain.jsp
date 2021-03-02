<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script> -->
<script>
	/* 검색조건별 검색창 설정 script */
	$(document).ready(function(){
		$("#type").change(function(){
			var type = $("#type").val();
			if(type == 0){
				$("#data_contain").css('display','none');
				$("#search_contain").css('display','none');
			}else if(type == 1){
				$("#date_contain").css('display','none');
				$("#search_contain").css('display','inline');
				$("#search").css('display','none'); 
				$("#typeSearch").css('display','inline');
			}else if(type == 2){
				$("#date_contain").css('display','none');
				$("#search_contain").css('display','inline');
				$("#search").css('display','inline'); 
				$("#typeSearch").css('display','none');
				$('#search').on('input',function () { 
					this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
				});
			}else if(type == 3){
				$("#date_contain").css('display','none');
				$("#search_contain").css('display','inline');
				$("#search").css('display','inline'); 
				$("#typeSearch").css('display','none');
				$('#search').unbind();
			}else if(type == 4){
				$("#date_contain").css('display','none');
				$("#search_contain").css('display','inline');
				$("#search").css('display','inline'); 
				$("#typeSearch").css('display','none');
				$('#search').unbind();
			}else if(type == 5){
				$("#date_contain").css('display','inline');
				$("#search_contain").css('display','none'); 
				$('#date1').on('input', function () { 
					this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
				});
				$('#date2').on('input', function () { 
					this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
				});
			}
		});
	});
	
	/* 검색 script */
 	$(document).ready(function(){
 		$("#searchBtn").click(function(){
			var info = {
	 			'type' : $("#type").val(), 
	 			'typeSearch' : $("#typeSearch").val(),
	 			'search' : $("#search").val(),
	 			'date1' : $("#date1").val(),
	 			'date2' : $("#date2").val()
			};
			if(info.date1 <= info.date2){	// date1 ~ date2 의 기간중 date2가 date1보다 많거나 같을때
				$.ajax({
					url : 'ajaxSearch.ino',
					type : 'POST',
					dataType : 'JSON',
					data : info,
					success : function(list){
							removeTable();
							createNewTable(list);
							removePage();
							createNewPage(list);
					}
				});
			}else{
				alert("기간을 다시 설정해주세요.")
			}
 		});
 	});
	
	/* 전체선택, 해제 script */
	$(document).ready(function(){
		$("#chkAll").click(function(){
			if($("#chkAll").prop("checked")){
				$(".chk").prop("checked",true);
				
			}else{
				$(".chk").prop("checked", false);
			}
		});
	});
	/* 다중삭제 script */
	$(document).ready(function(){
		$("#selectDelete").click(function(){
			var cnt = $(".chk:checked").length;
 			var arr = new Array();
			$(".chk:checked").each(function(){		
 				arr.push($(this).val());
			});
			var info = {
		 			'type' : $("#type").val(), 
		 			'typeSearch' : $("#typeSearch").val(),
		 			'search' : $("#search").val(),
		 			'date1' : $("#date1").val(),
		 			'date2' : $("#date2").val()
				};
			if(cnt == 0){
				alert("선택된 글이 없습니다.");
			}else{
				var conf = confirm("정말 삭제하시겠습니까?")
				if(conf){
					$.ajax({
						url : 'delete1.ino',
						type : 'POST',
						data : 'VAL=' + arr + '&CNT=' + cnt,
						dataType : 'JSON',
						success : function(data){
							if(data == 0){
								alert("오류입니다");
							} else {
								$.ajax({
									url : 'ajaxSearch.ino',
									data : info,
									type : 'POST',
									dataType : 'JSON',
									success : function(list){
										removeTable();
										createNewTable(list);
										removePage();
										createNewPage(list);
									}
								});
							}
						}
					});
					alert("삭제가 완료되었습니다");
				}
			}
		});
	});
	function pageClick( num ) {
		var page= num;
		console.log(page);
		var info = {
	 			'type' : $("#type").val(), 
	 			'typeSearch' : $("#typeSearch").val(),
	 			'search' : $("#search").val(),
	 			'date1' : $("#date1").val(),
	 			'date2' : $("#date2").val(),
	 			'page' : page
			};
		$.ajax({
			url : './ajaxSearch.ino',
			type : 'POST',
			data : info, 
			success : function(list){
				removeTable();
				createNewTable(list);
				removePage();
				createNewPage(list);
			}
		});
	}
	
	
	/* $(document).ready(function(){
		$(".page_").click(function(){
			var page=$(this).attr("id");
			console.log(page);
			var info = {
		 			'type' : $("#type").val(), 
		 			'typeSearch' : $("#typeSearch").val(),
		 			'search' : $("#search").val(),
		 			'date1' : $("#date1").val(),
		 			'date2' : $("#date2").val(),
		 			'page' : page
				};
			$.ajax({
				url : './ajaxSearch.ino',
				type : 'POST',
				data : info, 
				success : function(list){
					removeTable();
					createNewTable(list);
					removePage();
					createNewPage(list);
				}
			});
		});
	}); */
	/* ajax 이후 컬럼을 보여주는 script */
	function removeTable(){
		$("#tb").remove();
	}
	/* list = Dto에 저장된 컬럼리스트  */
	function createNewTable(list){
		console.log(list.dtoList); 
		var newTbody = $("<tbody id='tb' name='tb'></tbody>");
		$("#showData").append(newTbody);
		for (var i = 0; i < list.dtoList.length; i++){
			var data = $("<tr>" + 
				"<td style='width: 50px; padding-left: 10px;' align='center'>" + "<input type='checkbox' class='chk' name='chk' value='" + list.dtoList[i].NUM +"'>" + "</td>" +
				"<td style='width: 55px; padding-left: 30px;' align='center'>" + list.dtoList[i].CODETYPE + "</td>" +
				"<td style='width: 50px; padding-left: 10px;' align='center'>" + list.dtoList[i].NUM + "</td>" +
				"<td style='width: 125px; align : center;''>" + "<a href='./freeBoardDetail.ino?num=" + list.dtoList[i].NUM + "'>" + list.dtoList[i].TITLE + "</a>" + "</td>" +
				"<td style='width: 60px; padding-left: 50px;' align='center'>" + list.dtoList[i].NAME + "</td>" +
				"<td style='width: 100px; padding-left: 95px;' align='center'>" + list.dtoList[i].REGDATE + "</td>" +
				"</tr>"
			);
				newTbody.append(data);
		}
	}
	/* page 리셋 script */
	function removePage(){
		$("#pageContain").empty();
	}
	
	function createNewPage(list){
		for(var i=list.pageStart; i <= list.pageEnd; i++){
			var paging =$(
				"<span class='page_' id='" + i + "' style='border:1px solid black; display:inline-block; width:30px; height:35px; cursor:pointer;' onclick='pageClick("+i+")''>" + i + "</span>"
			); 
				$("#pageContain").append(paging);
		}
	}
	
</script>
</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<div style="width:650px;">																<!-- 검색타입 -->
		<select name="type" id="type">														<!-- select -->
			<option value ="0">전 체</option>													<!-- option 선택창 -->
			<c:forEach items="${codeList.codeListB }" var="codeList">
				<option value="${codeList.D_CODE }">${codeList.D_CODENAME }</option>
			</c:forEach>
<!-- 			<option value="1">타  입</option> -->
<!-- 			<option value="2">글번호</option> -->
<!-- 			<option value="3">글제목</option> -->
<!-- 			<option value="4">글쓴이</option> -->
<!-- 			<option value="5">작성일</option> -->
		</select>
		<div id="search_contain" style="display:inline;">												<!-- 검색창 -->
			<input type="text" name="search" id="search" style="display:none;">							<!-- input 입력창 -->
			<select name="typeSearch" id="typeSearch" style="display:none; width:165px; height:21px;">	<!-- select 선택창 -->
				<c:forEach items="${codeList.codeListA }" var="codeList">
					<option value="${codeList.D_CODE }">${codeList.D_CODENAME }</option>
				</c:forEach>
			</select>
		</div>
		<div id="date_contain" style="display:none;">			<!-- 기간 검색창 -->
			<input type="text" name="date1" id="date1"> ~		<!-- 기간(부터) -->
			<input type="text" name="date2" id="date2">			<!-- 기간(까지) -->
		</div>
		<input type="button" name="searchBtn" id="searchBtn" value="검색">
		
	</div> 
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<td style="width: 50px; padding-left: 10px;" align="center"><input type="checkbox" id="chkAll"></td>
					<td style="width: 55px; padding-left: 30px;" align="center">타입</td>
					<td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
					<td style="width: 125px;" align="center">글제목</td>
					<td style="width: 60px; padding-left: 50px;" align="center">글쓴이</td>
					<td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">
	<form name="frm2" id="frm2">
	<div>
		<table border="1" id="showData">
			<tbody id="tb" name="tb">
					<c:forEach var="dto" items="${freeBoardList.dtoList }" varStatus="var">
						<tr>
							<td style="width: 50px; padding-left: 10px;" align="center"><input type="checkbox" class="chk" name="chk" value="${dto.NUM }"></td>
							<td style="width: 55px; padding-left: 30px;" align="center" id="codeType">${dto.CODETYPE }</td>
							<td style="width: 50px; padding-left: 10px;" align="center" id="num">${dto.NUM }</td>
							<td style="width: 125px; align : center;"><a href="./freeBoardDetail.ino?num=${dto.NUM }" id="title">${dto.TITLE }</a></td>
							<td style="width: 60px; padding-left: 50px;" align="center" id="name">${dto.NAME }</td>
							<td style="width: 100px; padding-left: 95px;" align="center" id="regdate">${dto.REGDATE }</td>
						<tr>
					</c:forEach>
			</tbody>
		</table>
		<div style="width:650px;" align="right">
			<input type="button" value="삭제" id="selectDelete">
		</div>
		<div style="width:650px;" align="center" id="pagination">
			<div id="pageContain">
				<c:forEach var="i" begin="${freeBoardList.pageStart }" end="${freeBoardList.pageEnd }">
					<span class="page_" id="${i}" style="border:1px solid black; display:inline-block; width:30px; height:35px; cursor:pointer;" onclick="pageClick(${i})">${i}</span>
				</c:forEach>
			</div>
		</div>
	</div>
	</form>
</body>
</html>