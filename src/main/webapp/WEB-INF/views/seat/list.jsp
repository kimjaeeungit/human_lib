<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:csrfMetaTags/>
<!DOCTYPE html>
<html lang="ko" class="html">
<head>
	<meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>휴먼대학교 도서관</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
	<jsp:include page="../includes/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../includes/header.jsp"></jsp:include>
		<main>
			<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="pinfo"/>
		        <div class="row" id="skies"></div>
		        <div class="container">
		        <div class="row col-10 mx-auto py-3" id="mainSec">
		            <div class="col-lg-3 col-12" id="progress">
		                <div class="vprogress d-none d-lg-block">
		                    <div class="circle"></div>
		                    <div class="circle" id="vSecondStep"></div>
		                    <div class="circle bg-primary"></div>      
		                </div>
		                <div class="hprogress d-lg-none my-3">
		                    <div class="circle my-2"></div>
		                    <div class="circle my-2" id="hSecondStep"></div>
		                    <div class="circle bg-primary my-2"></div>      
		                </div>
		            </div>
		            <div class="col-lg-9 col-12 my-8">
		                <div class="dropdown">
		                    <button type="button" class="btn btn-primary dropdown-toggle mt-4 dropTitle"  data-toggle="dropdown">
		                      원하시는 시간대를 선택해주세요.
		                    </button>
		                    <div class="dropdown-menu">
		                        <a class="dropdown-item" data-value="1"> Time 1 :: 09:00-10:00 </a>
		                        <a class="dropdown-item" data-value="2"> Time 2 :: 10:00-11:00 </a>
		                        <a class="dropdown-item" data-value="3"> Time 3 :: 11:00-12:00 </a>
		                        <a class="dropdown-item" data-value="4"> Time 4 :: 12:00-13:00 </a>
		                        <a class="dropdown-item" data-value="5"> Time 5 :: 13:00-14:00 </a>
		                        <a class="dropdown-item" data-value="6"> Time 6 :: 14:00-15:00 </a>
		                        <a class="dropdown-item" data-value="7"> Time 7 :: 15:00-16:00 </a>
		                        <a class="dropdown-item" data-value="8"> Time 8 :: 16:00-17:00 </a>
		                        <a class="dropdown-item" data-value="9"> Time 9 :: 17:00-18:00 </a>
		                        <a class="dropdown-item" data-value="10"> Time 10 :: 18:00-19:00 </a>
		                        <a class="dropdown-item" data-value="11"> Time 11 :: 19:00-20:00 </a>
		                        <a class="dropdown-item" data-value="12"> Time 12 :: 20:00-21:00 </a>
		                    </div>
		                </div>
		                <form method="post" onsubmit="checkValues()">
		                    <div class="revSec bg-primary my-4 p-1 col-11 mx-auto">
		                        <div data-toggle="buttons">
		                            <div class="row my-3 ml-3">
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                            </div>
		                            <div class="row my-3 ml-3">
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                            </div>
		                            <div class="row my-3 ml-3">
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                            </div>
		                            <div class="row my-3 ml-3">
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                            </div>
		                            <div class="row my-3 ml-3">
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                            </div>
		                            <div class="row my-3 ml-3">
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                            </div>
		                            <div class="row my-3 ml-3">
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                                <div class="col-1 col-offset-1"></div>
		                            </div>
		                        </div>
		                    </div>
		                    <div class="timeTable bg-primary col-11 mb-3 mx-auto py-2">
		                        <div data-toggle="buttons">
		                            <div class="row col-12 checks mx-auto">
		                                <div class="col-1 px-0 py-2">
		                                    <label class="btn btn-success w-100 py-2 disabled">
		                                        <input type="checkbox" name="revs" value="1">
		                                    </label>
		                                </div>
		                                <div class="col-1 px-0 py-2">
		                                    <label class="btn btn-success w-100 py-2 disabled">
		                                        <input type="checkbox" name="revs" value="2">
		                                    </label>
		                                </div>
		                                <div class="col-1 px-0 py-2">
		                                    <label class="btn btn-success w-100 py-2 disabled">
		                                        <input type="checkbox" name="revs" value="3">
		                                    </label>
		                                </div>
		                                <div class="col-1 px-0 py-2">
		                                    <label class="btn btn-success w-100 py-2 disabled">
		                                        <input type="checkbox" name="revs" value="4">
		                                    </label>
		                                </div>
		                                <div class="col-1 px-0 py-2">
		                                    <label class="btn btn-success w-100 py-2 disabled">
		                                        <input type="checkbox" name="revs" value="5">
		                                    </label>
		                                </div>
		                                <div class="col-1 px-0 py-2 ">
		                                    <label class="btn btn-success w-100 py-2 disabled ">
		                                        <input type="checkbox" name="revs" value="6">
		                                    </label>
		                                </div>
		                                <div class="col-1 px-0 py-2">
		                                    <label class="btn btn-success w-100 py-2 disabled">
		                                        <input type="checkbox" name="revs" value="7">
		                                    </label>
		                                </div>
		                                <div class="col-1 px-0 py-2">
		                                    <label class="btn btn-success w-100 py-2 disabled">
		                                        <input type="checkbox" name="revs" value="8">
		                                    </label>
		                                </div>
		                                <div class="col-1 px-0 py-2">
		                                    <label class="btn btn-success w-100 py-2 disabled">
		                                        <input type="checkbox" name="revs" value="9">
		                                    </label>
		                                </div>
		                                <div class="col-1 px-0 py-2">
		                                    <label class="btn btn-success w-100 py-2 disabled">
		                                        <input type="checkbox" name="revs" value="10">
		                                    </label>
		                                </div>
		                                <div class="col-1  px-0 py-2">
		                                    <label class="btn btn-success w-100 py-2 disabled">
		                                        <input type="checkbox" name="revs" value="11">
		                                    </label>
		                                </div>
		                                <div class="col-1 px-0 py-2">
		                                    <label class="btn btn-success w-100 py-2 disabled">
		                                        <input type="checkbox" name="revs" value="12">
		                                    </label>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="row col-12 ml-4 times">
		                            <div class="col-1">10</div>
		                            <div class="col-1">11</div>
		                            <div class="col-1">12</div>
		                            <div class="col-1">13</div>
		                            <div class="col-1">14</div>
		                            <div class="col-1">15</div>
		                            <div class="col-1">16</div>
		                            <div class="col-1">17</div>
		                            <div class="col-1">18</div>
		                            <div class="col-1">19</div>
		                            <div class="col-1">20</div>
		                            <div class="col-1">21</div>
		                        </div>
		                    </div>
		                    <input type="hidden" name="loc" value="${loc}" >
		                    <input type="hidden" name="id" value="${pinfo.memberVo.id}">
		                    <button class="btn btn-primary mb-3">확인</button>
		                </form>
		            </div>
		        </div>
		    </div>
	    </sec:authorize>
	    <sec:authorize access="isAnonymous()">
			<script>alert('예약은 로그인 후 이용가능합니다.');
			location.href='${pageContext.request.contextPath}/';
			</script>
		</sec:authorize>
    </main>
    <jsp:include page="../includes/footer.jsp"></jsp:include>
    <script>
		var loc='${loc}';
		var revTime=${revTime};
    	$(function() {
    		var token = $("meta[name='_csrf']").attr('content');
    	    var header = $("meta[name='_csrf_header']").attr('content');
    	    if(token && header) {
    	        $(document).ajaxSend(function(event, xhr, options) {
    	            xhr.setRequestHeader(header, token);
    	        });
    	    }
 			/* 열람실번호가 없으면 열람실 고르도록 */
    		if(loc==''){
    			alert("열람실을 선택해주세요.");
    			location.href='/seat/choose';
    		}	
    		if(revTime<1 || revTime>12){
    			alert("열람실 운영시간이 아닙니다.");
    			location.href="/";
    		}
 			
    		getLoc();
		
    	});
    	
       	$(".dropdown-menu a").click(function(){
       		$(".revSec").find(".row").find(".col-1").find(".chosenS").addClass("disabled");
       		$(".revSec").find(".row").find(".col-1").find(".chosenS").removeClass("active");
       		$(".checks").find(".col-1").find(".btn").removeClass("active");
	  		 var timeText = $(this).text();
	  		 $(".dropdown").find(".dropTitle").html(timeText);
	  		 var time=$(this).attr("data-value");
	  		 if(time<revTime) alert("예약가능한 좌석이 없습니다.");
	  		$.getJSON("/seat/getSeats?loc="+loc+"&revTime="+time).done(function(data) {
	    		data.forEach(a => {
	    			var x=a.coordX;
		        	var y=a.coordY;
		        	var status=a.status;
		        	if(time<revTime) status=1;
		        	if(status==0){
		        		$(".revSec").find(".row").eq(y-1).find(".col-1").eq(x-1).find(".chosenS").removeClass("disabled");
		        	};
	    		});
	  		});
 		 });
	    
    	function getLoc() {
    		
	    	$.getJSON("/seat/getSeats?loc="+loc+"&revTime="+revTime).done(function(data) {
	    		data.forEach(a => {
		        	var x=a.coordX;
		        	var y=a.coordY;
		        	var status= a.status==0?'':'disabled';
		        	
		        	$(".revSec").find(".row").eq(y-1).find(".col-1").eq(x-1).html(
		        			'<label class="chosenS btn btn-warning w-100 py-2 '+status+'">'
		        			+'<input type="radio" name="seatNo" value="'+a.seatNo+'" onclick="getTimes(event)">'+a.seatNo
		        			+'</label>');
	    		})
	        })
	     }; 

	     
	     
	     function getTimes(event){
	    	 var seatValue = event.target.value;
	    	 $(".checks").find(".col-1").find(".btn").addClass("disabled");
	    	 $(".checks").find(".col-1").find(".btn").removeClass("active");
	    	 $.getJSON("/seat/getSeats?loc="+loc+"&seatNo="+seatValue).done(function(data) {
		    		data.forEach(a => {
		    			var time=a.revTime;
			        	var status= a.status;
			        	if(time<revTime){
			        		status=1;
			        	}
			        	console.log(status);
			        	if(status==0){
			        		$(".checks").find(".col-1").eq(time-1).find(".btn").removeClass("disabled");
			        	}
			        	
		    		})
		      })
	     }
	     
	     function checkValues() {
				var checkedSeat=$("input[name='seatNo']:checked").val();
				var checkedTime=$("input[name='revs']:checked").val();
		
				if(!checkedSeat) {
					event.preventDefault();
			        alert("자리를 선택해주세요");
			        return;
			    }
				if(!checkedTime) {
					event.preventDefault();
			        alert("이용하실 시간을 선택해주세요");
			        return;
			    }
		
		
			};
    </script>
</body>
</html>