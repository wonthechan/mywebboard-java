<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "board.dto.*" %>
<% 
	UserDto userDto = (UserDto) session.getAttribute("userDto");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<title>Board</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/alertify.min.js"></script>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/alertify.min.css"/>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/themes/default.min.css"/>
	
	<link rel="stylesheet" href="/css/common.css">
</head>
<body>
	<div class="container">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
		  <a class="navbar-brand" href="#">삐따기</a>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		  <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
		    <div class="navbar-nav">
		      <a class="nav-item nav-link" href="/board/board.jsp">게시판 </a>
		      <a class="nav-item nav-link" href="#">포트폴리오</a>
		    </div>
		  </div>
		</nav>

<br>

  <h4 class="text-center">게시판</h4>       
  
	<div class="input-group mb-3">
  		<input id="inputSearchWord" type="text" class="form-control" placeholder="Search">
  		<div class="input-group-append">
    		<button id="btnSearchWord" class="btn btn-success">Go</button>
  		</div>
	</div>

  <table class="table table-hover">
     <thead>
       <tr>
         <th>#</th>
         <th>제목</th>
         <th>작성자</th>
         <th>작성일시</th>
         <th>조회수</th>
       </tr>
     </thead>
     <tbody id="boardTbody">
       
     </tbody>
   </table>
   
   <div id="paginationWrapper"></div>

	<button class="btn btn-sm btn-primary" id="btnBoardInsertForm">글쓰기</button>
</div>


				<!-- Modal insert-->
				<div class="modal fade" id="boardInsertModal">
					<div class="modal-dialog modal-simple">
						<form class="modal-content">
							<!-- Modal Header -->
					      	<div class="modal-header">
					        	<h4 class="modal-title">글쓰기</h4>
					        	<button type="button" class="close" data-dismiss="modal">&times;</button>
					      	</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-xl-12 form-group">
										<input id="titleInsert" type="text" class="form-control" name="title" placeholder="제목">
									</div>
									<div class="col-xl-12 form-group">
										<textarea id="contentInsert" class="form-control" rows="5" placeholder="내용"></textarea>
									</div>
									<div class="col-xl-12 form-group">
										<div class="checkbox-custom checkbox-primary">
					                    	<input type="checkbox" id="chkFileUploadInsert" />
					                    	<label for="chkFileUploadInsert">파일 추가</label>
					                  	</div>
									</div>
									<div class="col-xl-12 form-group" style="display:none;" id="imgFileUploadInsertWrapper">
										<input type="file" id="inputFileUploadInsert">
										<div class="thumbnail-wrapper">
					                    	<img id="imgFileUploadInsert">
					                  	</div>
									</div>
									<div class="col-md-12 float-right">
										<button id="btnBoardInsert" class="btn btn-sm btn-primary btn-outline" data-dismiss="modal" type="button">등록</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- End Modal -->
				
				<!-- Modal detail-->
				<div class="modal fade" id="boardDetailModal">
					<div class="modal-dialog modal-simple">
						<div class="modal-content">
							<!-- Modal Header -->
					      	<div class="modal-header">
					        	<h4 class="modal-title">글 상세</h4>
					        	<button type="button" class="close" data-dismiss="modal">&times;</button>
					      	</div>
					      	
							<div class="modal-body">
							
                  <div class="example table-responsive">
                    <table class="table table-hover">
                      <tbody>
                        <tr><td>글번호</td><td id="boardIdDetail">#</td></tr>
                        <tr><td>제목</td><td id="titleDetail">#</td></tr>
                        <tr><td>내용</td><td id="contentDetail">#</td></tr>
                        <tr><td>작성자</td><td id="userNameDetail">#</td></tr>
                        <tr><td>작성일시</td><td id="regDtDetail">#</td></tr>
                        <tr><td>조회수</td><td id="readCountDetail">#</td></tr>
                        <tr><td>첨부파일</td><td id="fileListDetail">#</td></tr>
                      </tbody>
                    </table>
                  </div>
								<button id="btnBoardUpdateForm" class="btn btn-sm btn-primary btn-outline" data-dismiss="modal" type="button">글 수정하기</button>
								<button id="btnBoardDeleteConfirm" class="btn btn-sm btn-warning btn-outline" data-dismiss="modal" type="button">글 삭제하기</button>

							</div>
						</div>
					</div>
				</div>
				<!-- End Modal -->
				
				<!-- Modal update-->
				<div class="modal fade" id="boardUpdateModal">
					<div class="modal-dialog modal-simple">
						<form class="modal-content">
							<!-- Modal Header -->
					      	<div class="modal-header">
					        	<h4 class="modal-title">글수정</h4>
					        	<button type="button" class="close" data-dismiss="modal">&times;</button>
					      	</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-xl-12 form-group">
										<input id="titleUpdate" type="text" class="form-control" name="title" placeholder="제목">
									</div>
									<div class="col-xl-12 form-group">
										<textarea id="contentUpdate" class="form-control" rows="5" placeholder="내용"></textarea>
									</div>
									<div class="col-xl-12 form-group">
										첨부파일 : <span id="fileListUpdate"></span>
									</div>
									<div class="col-xl-12 form-group">
										<div class="checkbox-custom checkbox-primary">
					                    	<input type="checkbox" id="chkFileUploadUpdate" />
					                    	<label for="chkFileUploadUpdate">파일 변경</label>
					                  	</div>
									</div>
									<div class="col-xl-12 form-group" style="display:none;" id="imgFileUploadUpdateWrapper">
										<input type="file" id="inputFileUploadUpdate">
										<div class="thumbnail-wrapper">
					                    	<img id="imgFileUploadUpdate">
					                  	</div>
									</div>
									<div class="col-md-12 float-right">
										<button id="btnBoardUpdate" class="btn btn-sm btn-primary btn-outline" data-dismiss="modal" type="button">수정</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- End Modal -->

<script src="/js/util.js"></script>				
<script>

var LIST_ROW_COUNT = 10;	//limit
var OFFSET = 0;
var PAGE_COUNT_PER_BLOCK = 10;	// pagination link 갯수
var TOTAL_LIST_ITEM_COUNT = 0;
var CURRENT_PAGE_INDEX = 1;

var SEARCH_WORD = "";

$(document).ready(function() {

	boardList();
	
	$("#btnBoardInsertForm").click(function(){
		$("#titleInsert").val("");
		$("#contentInsert").val("");
		$("#chkFileUploadInsert").prop("checked", false);
		$("#inputFileUploadInsert").val("");
		$("#imgFileUploadInsert").removeAttr("src");
		//$("#imgFileUploadInsert").attr("src", "");
		$("#imgFileUploadInsertWrapper").hide();
		
		$("#boardInsertModal").modal("show");
	});

	$("#btnBoardInsert").click(function(){
		
		if( validateInsert() ){
			boardInsert();
		}
	});
	
	$("#btnBoardUpdateForm").click(function(){
		
		var boardId = $("#boardDetailModal").attr("data-boardId");
		$("#boardUpdateModal").attr("data-boardId", boardId);
		
		$("#titleUpdate").val( $("#titleDetail").html() );
		$("#contentUpdate").val( $("#contentDetail").html() );
		
//			$("#fileListDetail").append(
//					'<span class="fileName">' + fileName + '</span>');
		var fileName = $("#fileListDetail").find(".fileName").html();
		$("#fileListUpdate").html( '<span class="fileName">' + fileName + '</span>');
		
		$("#chkFileUploadUpdate").prop("checked", false);
		$("#inputFileUploadUpdate").val("");
		$("#imgFileUploadUpdate").attr("src", "");
		//$("#imgFileUploadUpdate").removeAttr("src");
		$("#imgFileUploadUpdateWrapper").hide();
		
		$("#boardDetailModal").modal("hide");
		$("#boardUpdateModal").modal("show");
	});
	
	$("#btnBoardUpdate").click(function(){
		
		if( validateUpdate() ){
			boardUpdate();
		}
	});
	
	$("#btnBoardDeleteConfirm").click(function(){
		 alertify.confirm('Upwiden', '이 글을 삭제하시겠습니까?',
  			function() {
				boardDelete();
  			},
			function(){
  				console.log('cancel');
			}
			);
	});
	
	//file upload..
	//Insert
	$("#chkFileUploadInsert").change(function(){
		if( $(this).prop("checked")){
			$("#imgFileUploadInsertWrapper").show();
		}else{
			$("#inputFileUploadInsert").val("");
			$("#imgFileUploadInsert").attr("src", "");
			$("#imgFileUploadInsertWrapper").hide();
		}
	});
	
	$("#inputFileUploadInsert").change(function(e){

		if( this.files && this.files[0] ){
			var reader = new FileReader();
			reader.onload = function(e){
				$("#imgFileUploadInsert").attr("src", e.target.result);
			}
			reader.readAsDataURL(this.files[0]);
		}
	});
	
	//Update
	$("#chkFileUploadUpdate").change(function(){
		if( $(this).prop("checked")){
			$("#imgFileUploadUpdateWrapper").show();
		}else{
			$("#inputFileUploadUpdate").val("");
			$("#imgFileUploadUpdate").attr("src", "");
			$("#imgFileUploadUpdateWrapper").hide();
		}
	});
	
	$("#inputFileUploadUpdate").change(function(e){

		if( this.files && this.files[0] ){
			var reader = new FileReader();
			reader.onload = function(e){
				$("#imgFileUploadUpdate").attr("src", e.target.result);
			}
			reader.readAsDataURL(this.files[0]);
		}
	});

	
	//Search
	$("#btnSearchWord").click(function(e){
		var searchWord = $("#inputSearchWord").val();
		
		if( searchWord != "" ){
			SEARCH_WORD = searchWord;
		}else{
			SEARCH_WORD = "";
		}
		
		boardList();
	});

});

function validateInsert(){
	var isTitleInsertValid = false;
	var isContentInsertValid = false;

	var titleInsert = $("#titleInsert").val();
	var titleInsertLength = titleInsert.length;
	
	if( titleInsertLength > 0 ){
		isTitleInsertValid = true;
	}
	
	var contentInsertValue = $("#contentInsert").val();
	var contentInsertLength = contentInsertValue.length;
	
	if( contentInsertLength > 0 ){
		isContentInsertValid = true;
	}

	if(	isTitleInsertValid && isContentInsertValid ){
		return true;
	}else{
		return false;
	}
}

function boardInsert(){

	$.ajax(
	{
        type : 'post',
        url : '/board/insert',
        dataType : 'json',
        data : 
		{
        	userSeq: '<%=userDto.getUserSeq()%>',
        	title: $("#titleInsert").val(),
        	content: $("#contentInsert").val()
		},
        success : function(data, status, xhr) { 
		
        	if(data.result == "success"){
        		alertify.success('글이 등록되었습니다.');
        		boardList();
        	}
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	alertify.notify(
      			'Opps!! 글 등록 과정에 문제가 생겼습니다.', 
      			'error', //'error','warning','message'
      			3, //-1
      			function(){
      				console.log(jqXHR.responseText); 
      			}
      		);
        	
        }
    });
}

function validateUpdate(){
	var isTitleUpdateValid = false;
	var isContentUpdateValid = false;

	var titleUpdate = $("#titleUpdate").val();
	var titleUpdateLength = titleUpdate.length;
	
	if( titleUpdateLength > 0 ){
		isTitleUpdateValid = true;
	}
	
	var contentUpdateValue = $("#contentUpdate").val();
	var contentUpdateLength = contentUpdateValue.length;
	
	if( contentUpdateLength > 0 ){
		isContentUpdateValid = true;
	}

	if(	isTitleUpdateValid && isContentUpdateValid ){
		return true;
	}else{
		return false;
	}
}

function boardUpdate(){
	
	var formData = new FormData();
	formData.append("boardId", $("#boardUpdateModal").attr("data-boardId"));
	formData.append("userSeq", '<%=userDto.getUserSeq()%>');
	formData.append("title", $("#titleUpdate").val());
	formData.append("content", $("#contentUpdate").val());
	formData.append("file", $("#inputFileUploadUpdate")[0].files[0]);
	
	$.ajax(
	{
        type : 'post',
        url : '/board/updateFile',
        dataType : 'json',
        data : formData,
        contentType: false,	// forcing jQuery not to add a Content-Type header for you, otherwise, the boundary string will be missing from it
        processData: false, // otherwise, jQuery will try to convert your FormData into a string, which will fail.
        beforeSend : function(xhr){
            //xhr.setRequestHeader("ApiKey", "asdfasxdfasdfasdf");
            xhr.setRequestHeader("AJAX", true);
        },
        success : function(data, status, xhr) { 
		
        	if( data ){
        		alertify.success('글이 수정되었습니다.');
        		boardList();
        	}
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        {
        	if( jqXHR.responseText == "timeout" ){
        		window.location.href = "/login"
        	}else{
	        	alertify.notify(
        			'Opps!! 글 수정 과정에 문제가 생겼습니다.', 
        			'error', //'error','warning','message'
        			3, //-1
        			function(){
        				console.log(jqXHR.responseText); 
        			}
        		);
	        }
        }
    });
}

function boardDelete(){
	$.ajax(
	{
        type : 'post',
        url : '/board/delete',
        dataType : 'json',
        data : 
		{
        	boardId: $("#boardDetailModal").attr("data-boardId")
		},
        beforeSend : function(xhr){
            //xhr.setRequestHeader("ApiKey", "asdfasxdfasdfasdf");
            xhr.setRequestHeader("AJAX", true);
        },
        success : function(data, status, xhr) { 
		
        	if( data ){
        		alertify.success('글이 삭제되었습니다.');
        		boardList();
        	}
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        {
        	if( jqXHR.responseText == "timeout" ){
        		window.location.href = "/login"
        	}else{
	        	alertify.notify(
        			'Opps!! 글 삭제 과정에 문제가 생겼습니다.', 
        			'error', //'error','warning','message'
        			3, //-1
        			function(){
        				console.log(jqXHR.responseText); 
        			}
        		);
	        }
        }
    });
}


function boardList(){
	$.ajax(
	{
        type : 'get',
        url : '/board/list',
        dataType : 'json',
        data : 
		{
        	limit: LIST_ROW_COUNT,
			offset: OFFSET,
			searchWord: SEARCH_WORD
		},
        success : function(data, status, xhr) { 

        	makeListHtml(data);
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	console.log(textStatus);
        	
        	alertify.notify(
       			'Opps!! 글 조회 과정에 문제가 생겼습니다.', 
       			'error', //'error','warning','message'
       			3, //-1
       			function(){
       				console.log(jqXHR.responseText); 
       			}
       		);
        }
    });
}

function makeListHtml(list){

	$("#boardTbody").html("");
	
	//var boardArray = JSON.parse(data); ?? @ResponseBody 자동으로 json 변환
	for( var i=0; i<list.length; i++){
		
		var boardId = list[i].boardId;
		var userName = list[i].userName;
		var title = list[i].title;
		var content = list[i].content;
		var regDt = list[i].regDt;
		var readCount = list[i].readCount;
		
		var listHtml =
			'<tr style="cursor:pointer" data-boardId=' + boardId +'><td>' + boardId + '</td><td>' + title + '</td><td>' + userName + '</td><td>' + regDt + '</td><td>' + readCount + '</td></tr>';

		$("#boardTbody").append(listHtml);
	}
	
	
	makeListHtmlEventHandler();
	
	boardListTotalCnt();
}

function addPagination(){

	makePaginationHtml(LIST_ROW_COUNT, PAGE_COUNT_PER_BLOCK, CURRENT_PAGE_INDEX, TOTAL_LIST_ITEM_COUNT, "paginationWrapper", boardList );
}

function movePage(pageIndex){
	OFFSET = (pageIndex - 1) * LIST_ROW_COUNT;
	CURRENT_PAGE_INDEX = pageIndex;
	boardList();
}

function boardListTotalCnt(){
	
	$.ajax(
	{
        type : 'get',
        url : '/board/list/totalCnt',
        dataType : 'json',
        data : 
		{
			searchWord: SEARCH_WORD
		},
        success : function(data, status, xhr) {
        	TOTAL_LIST_ITEM_COUNT = data.totalCnt;
        	addPagination();
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	alertify.notify(
       			'Opps!! 글 전체 갯수 조회 과정에 문제가 생겼습니다.', 
       			'error', //'error','warning','message'
       			3, //-1
       			function(){
       				console.log(jqXHR.responseText); 
       			}
       		);
        }
    });
}

//function boardListTotalCnt(){
	
//		$.ajax(
//		{
//	        type : 'get',
//	        url : '/board/test',
//	        dataType : 'json',
//	        beforeSend : function(xhr){
//	            //xhr.setRequestHeader("ApiKey", "asdfasxdfasdfasdf");
//	            xhr.setRequestHeader("AJAX", true);
//	        },
//	        success : function(data, status, xhr) {
//	        	console.log(data);
//	        	console.log(data.msg);
//	        }, 
//	        error: function(jqXHR, textStatus, errorThrown) 
//	        { 
//	        	if( jqXHR.responseText == "timeout" ){
//	        		window.location.href = "/login"
//	        	}else{
//	        		alertify.notify(
//         			'Opps!! 글 test 에 문제가 생겼습니다.', 
//         			'error', //'error','warning','message'
//         			3, //-1
//         			function(){
//         				console.log(jqXHR.responseText); 
//         			}
//         		);
//	        	}
//	        }
//	    });
//	}

function makeListHtmlEventHandler(){
	$("#boardTbody tr").click(function(){
		var boardId = $(this).attr("data-boardId");
		var userSeq = '<%=userDto.getUserSeq()%>';
		boardDetail(boardId, userSeq);
		//alert(boardId);
	});
}

function boardDetail(boardId, userSeq){

	$.ajax(
	{
        type : 'get',
        url : '/board/detail',
        dataType : 'json',
        data : 
		{
        	boardId: boardId,
        	userSeq: userSeq
		},
        beforeSend : function(xhr){
            //xhr.setRequestHeader("ApiKey", "asdfasxdfasdfasdf");
            xhr.setRequestHeader("AJAX", true);
        },
        success : function(data, status, xhr) { 

        	makeDetailHtml(data);
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	if( jqXHR.responseText == "timeout" ){
        		window.location.href = "/login"
        	}else{
        		alertify.notify(
        			'Opps!! 글 상세 조회 과정에 문제가 생겼습니다.', 
        			'error', //'error','warning','message'
        			3, //-1
        			function(){
        				console.log(jqXHR.responseText); 
        			}
        		);
        	}
        }
    });
}

function makeDetailHtml(detail){
	
		var boardId = detail.boardId;
		var userSeq = detail.userSeq;
		var userName = detail.userName;
		var title = detail.title;
		var content = detail.content;
		var regDt = detail.regDt;
		var readCount = detail.readCount;
		var fileList = detail.fileList;

		$("#boardDetailModal").attr("data-boardId", boardId);
		$("#boardIdDetail").html("#" + boardId);
		$("#titleDetail").html(title);
		$("#contentDetail").html(content);
		$("#userNameDetail").html(userName);
		$("#regDtDetail").html(regDt);
		$("#readCountDetail").html(readCount);
		
		//FileList
		$("#fileListDetail").html("");
		
		if( fileList.length > 0 ){
			for(var i=0; i<fileList.length; i++){
				var fileId = fileList[i].fileId;
				var fileName = fileList[i].fileName;
				var fileUrl = fileList[i].fileUrl;
				
				$("#fileListDetail").append(
						'<span class="fileName">' + fileName + '</span>');
				$("#fileListDetail").append(
						'&nbsp;&nbsp;<a type="button" class="btn btn-outline btn-default btn-xs" ' +
						'data-fileId="' + fileId + '" ' +
						'href="' + fileUrl + '" ' +
						'download="' + fileName + '">내려받기</a>');
			}
		}
		
		if( userSeq != '<%=userDto.getUserSeq()%>' ){
			$("#btnBoardUpdateForm").hide();
			$("#btnBoardDeleteConfirm").hide();
		}else{
			$("#btnBoardUpdateForm").show();
			$("#btnBoardDeleteConfirm").show();
		}
		
		$("#boardDetailModal").modal("show");
		
	makeDetailHtmlEventHandler();
}

function makeDetailHtmlEventHandler(){
	
}

</script>

</body>
</html>