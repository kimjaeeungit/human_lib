<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>관리자-도서등록페이지</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Jquery CDN 로드 : 항상 최신 버전 사용 -->    
    <script src="https://code.jquery.com/jquery-latest.min.js"></script> 
    

    <!-- 부트스트랩 CDN 로드 : 항상 최신 버전 사용 : maxcdn -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
    <jsp:include page="../includes/head.jsp" />
</head>
<body> 
<jsp:include page="../includes/header.jsp" />	
	<div class="main">
		<div class="container mb-4">
		  <h2>책등록</h2>
		  <table class="table table-bordered" style="margin-top: 150px;">
		  
		    <tbody>
		     <tr>
		      <th style="width: 100px;">검색</th>
		          <td colspan=3 style="width: 350px;"> 
		          <div class="row">
		          <div class="col-9">
		          	<input class="form-control" id="titleser" name="titleser" type="text" > 
		        	</div>
		        	 <div class="col-3">
		        	<a type="button" class="btn btn-primary mb-1" id="search">검색</a>
		        	 </div>
		        	</div>
		          </td>
		     </tr>
		      <tr>
		        <th style="width: 100px;">제목</th>
		          <td style="width: 350px;"> 
		          	<input class="form-control" id="title" name="title" type="text" > 
		        	</div>
		          </td>
		          
		        <th style="width: 100px;">저자</th>
		          <td style="width: 350px;"><input class="form-control" id="authors" name="authors" type="text"></td>
		      </tr>
		      <tr>
		        <th>출판사</th>
		          <td><input class="form-control" id="publisher" name="publisher" type="text"></td>
		        <th>가격</th>
		          <td><input class="form-control" id="price" name="price" type="text"></td>
		      </tr>
		      <tr>
		       	<th>ISBN</th>
		          <td><input class="form-control" id="isbn" name="isbn" type="text"></td>
		        <th>번역자</th>
		          <td><input class="form-control" id="translators" name="translators" type="text"></td>
		      </tr>
		      <tr>
		        <th>표지</th>
		          <td><input class="form-control" id="thumbnail" name="thumbnail" type="text" readonly="readonly"></td>
		        <th>출간일</th>
		          <td> <input class="form-control" id="datetime" name="datetime" type="text"></td>
		      </tr>
		      <tr>
		      <td colspan="4" style="height: 300px;"><textarea class="form-control" rows="" cols="" id="contents" name="contents" style="height: 300px;"></textarea></td>
		      </tr>
		    </tbody>
		  </table>
		<button class="btn bg-primary" id="submit" style="color: white">등록</button>
		
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/book.js"></script>
    <script>
  //get방식을 제외한 비동기처리에 필요함
	$(function () {
    var token = $("meta[name='_csrf']").attr('content');
    var header = $("meta[name='_csrf_header']").attr('content');
    if(token && header) {
        $(document).ajaxSend(function(event, xhr, options) {
            xhr.setRequestHeader(header, token);
	        });
	    }
	});
	
        $(function () {
            $("#search").click(function () {
				console.log($("#titleser").val())
                $.ajax({
                    method: "GET",
                    url: "https://dapi.kakao.com/v3/search/book?target=titleser", // 전송 주소
                    data: { query: $("#titleser").val() }, // 보낼 데이터
                    headers: { Authorization: "KakaoAK b7bb0ce2fd82a4944a14baca663f80b9" }
                })
                    .done(function (msg) { // 응답이 오면 처리를 하는 코드
                    	$("#title").attr('value',msg.documents[0].title);
                    	$("#authors").attr('value',msg.documents[0].authors);
                    	$("#publisher").attr('value',msg.documents[0].publisher);
                    	$("#price").attr('value',msg.documents[0].price);
                    	$("#isbn").attr('value',msg.documents[0].isbn);
                    	$("#translators").attr('value',msg.documents[0].translators);
                    	$("#thumbnail").attr('value',msg.documents[0].thumbnail);
                    	$("#datetime").attr('value',msg.documents[0].datetime);
                        $("textarea").append(msg.documents[0].contents);
                        console.log(msg)
                    });
            });
      
    	// 작성
		 $('#submit').on("click", function() {
			 var price = Number($("#price").val());
			 function to_date2(date_str)
			 {
			     var yyyyMMdd = String(date_str);
			     var sYear = yyyyMMdd.substring(0,4);
			     var sMonth = yyyyMMdd.substring(5,7);
			     var sDate = yyyyMMdd.substring(8,10);

			     //alert("sYear :"+sYear +"   sMonth :"+sMonth + "   sDate :"+sDate);
			     return new Date(Number(sYear), Number(sMonth)-1, Number(sDate));
			 }
			var date_str =  $("#datetime").val();
			 var datetime=to_date2(date_str);
			
			 var book = {
					isbn : $("#isbn").val(),
  					title : $("#title").val(),
  					datetime :datetime ,
  					authors : $("#authors").val(),
  					translators : $("#translators").val(),
  					publisher : $("#publisher").val(),
  					thumbnail : $("#thumbnail").val(),
  					contents : $("#contents").val(),
  					price : price
  				};
			
			 bookService.bookregister(book, function(result) {
					alert("작성이 완료되었습니다.");
					console.log(result)
					location.reload();
				});
				console.log(book)
		})
        });
        
    </script>
    	<jsp:include page="../includes/footer.jsp" />
</body>

</html>