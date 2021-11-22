<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:csrfMetaTags/>
<!DOCTYPE html>
<html lang="ko" class="completeHtml">
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
			<sec:authorize access="isAnonymous()">
				<script>
					alert("자리예약은 로그인 후 가능합니다.");
					location.href='${pageContext.request.contextPath}/';
				</script>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="pinfo"/>
			   <div class="row" id="skies"></div>
		       <div class="container">
			        <div class="row col-10 mx-auto py-3" id="mainSec">
			            <div class="col-lg-3 col-12" id="progress">
			                <div class="vprogress d-none d-lg-block">
			                    <div class="circle"></div>
			                    <div class="circle" id="vSecondStep"></div>
			                    <div class="circle" id="vLastStep"></div>      
			                </div>
			                <div class="hprogress d-lg-none my-3">
			                    <div class="circle my-2"></div>
			                    <div class="circle my-2" id="hSecondStep"></div>
			                    <div class="circle my-2" id="hLastStep"></div>      
			                </div>
			            </div>
			            <div class="col-lg-9 col-12 my-auto">
			                <div class="completeSec my-4 p-3 col-11 mx-auto">
			                    <img class="col-8 col-md-4 mx-auto my-5" src="${pageContext.request.contextPath}/resources/img/blueCalendar.png" alt="calendar" id="calIcon">
			                    <h3 class="my-4 comTitle">${vo.id}님, 예약이 완료되었습니다.</h3>
			                    <h5 class="my-4 comSeat">예약하신 자리는 ${vo.loc}번 열람실의 ${vo.seatNo}번 자리입니다. </h5>
			                    <p class="my-2 comNotice"><i class="fas fa-check"></i>&nbsp;&nbsp; 열람실 이용안내<br class="my-1">
			                    1. 꼭 입실시간을 지켜서 입실해주세요<br>2. 퇴실 시간 5분전에 퇴실해주세요.<br>3. 이용한 좌석의 뒷정리는 깔끔히 부탁드립니다.</p>
			                    <div class="row col-11 mx-auto my-5">
			                        <a class="btn btn-primary col-5 mx-auto my-1 py-1" href="/seat/mypage">마이페이지</a>
			                        <a class="btn btn-primary col-5 mx-auto my-1 py-1" href="/">메인으로</a>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
		    </sec:authorize>
    	</main>
    <jsp:include page="../includes/footer.jsp"></jsp:include>
    <script>

    </script>
</body>
</html>