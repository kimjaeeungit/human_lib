<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko" class="html">
<head>
<jsp:include page="../includes/head.jsp"></jsp:include>
<sec:csrfMetaTags/>
</head>
<body>
<jsp:include page="../includes/header.jsp"></jsp:include>
	<main>
		<sec:authorize access="isAuthenticated()">
	        <div class="myLoansPage mx-auto py-3">
	        	<div class="row mx-auto" >
	        		<div class="col-12 col-md-3 py-5">
	        			<div class="vSidebar">
		        		 	<h5 class="side-title"><span>MY PAGE</span></h5>
							<div class="side-content">
								<div class="menu-block-wrapper menu-block-ctools-main-menu-1 menu-name-main-menu parent-mlid-17090 menu-level-1">
									<ul class="side">
										<li><b>MY</b></li>
										<li>-&nbsp;&nbsp;<a class="ml-2" href="${pageContext.request.contextPath}/member/profile">회원정보</a></li>
										<li><b>MY서재</b></li>
										<li class="bg-dark">-&nbsp;&nbsp;<a class="ml-2 text-light" href="${pageContext.request.contextPath}/loans/listLoansReservationForMember">대출 예약 현황</a></li>
										<li>-&nbsp;&nbsp;<a class="ml-2" href="${pageContext.request.contextPath}/loans/listLoansForMember">도서대출현황</a></li>
										<li>-&nbsp;&nbsp;<a class="ml-2" href="${pageContext.request.contextPath}/loans/listReturnedLoans">나의대출목록</a></li>
										<li><b>MY좌석</b></li>
										<li>-&nbsp;&nbsp;<a class="ml-2" href="${pageContext.request.contextPath}/seat/mypage">자리예약현황</a></li>
										<li><b>MY마켓</b></li>
										<li>-&nbsp;&nbsp;<a class="ml-2" href="void(0);" onclick="alert('서비스를 준비중입니다.');return false;">내게시글관리</a></li>
										<li>-&nbsp;&nbsp;<a class="ml-2" href="void(0);" onclick="alert('서비스를 준비중입니다.');return false;">내리뷰관리</a></li>
									</ul>
								</div>
							</div>
						</div>
	        		</div>
	            	<div class="col-md-9 col-12" >
	            		<div class="managerBoardBox px-2 py-5">
		                    <div class="bookListTitle clearfix pb-2 border-bottom border-2 border-info">
		                        <h5 class="float-left text-info">대출 예약 현황</h5>
		                    </div>
							<div class="table-responsive my-3 revTable">
								<table class="table table-hover">
									<thead class="bg-dark text-light">
										<tr>
											<th colspan="3" class="text-center small">대출정보</th>
											<th colspan="2" class="text-center small">도서정보</th>
											<th colspan="2" class="text-center small bg-primary">예약관리</th>
										</tr>
										<tr>
											<th class="text-center small">대출<br>번호</th>
											<th class="text-center small">대출<br>예약일</th>
											<th class="text-center small">대출<br>만기일</th>
											<th class="text-center small">도서<br>번호</th>
											<th class="text-center small align-middle">도서 제목</th>
											<th class="text-center small bg-primary">도서<br>상태</th>
											<th class="text-center small bg-primary">예약취소</th> 
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${list}" var="loans">
										<tr>
											<td class="text-center small align-middle">${loans.lno}</td>
											<td class="text-center small align-middle">${loans.RDate}</td>
											<td class="text-center small align-middle">${loans.reDate}</td>
											<td class="text-center small align-middle">${loans.bkno}</td>
											<td class="small align-middle overflow-hidden text-truncate">${loans.title}</td>
											<td class="text-center small align-middle">
												<c:if test="${loans.status == 0}"><i class="fas fa-circle text-warning"></i>&nbsp;&nbsp;예약신청</c:if>
												<c:if test="${loans.status == 4}"><i class="fas fa-circle text-success"></i>&nbsp;&nbsp;예약확정</c:if>
											</td>
											<td class="text-center small align-middle">
												<button type="button" class="btn btn-outline-warning btn-sm small d-inline" onclick="cancelLoansReservationByMember(${loans.lno}, ${loans.bkno},'${loans.id}')">예약취소</button>
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
		                </div>
	               	</div>
	            </div>
	        </div>
	        <div class="modal" id="LoadingLayerModal">
				<div class="LoadingLayerBox modal-dialog text-center mt-5">
					<div class="LoadingLayer spinner-border text-info mx-auto" ></div>
					<p class="text-light mt-2">취소 중입니다. 잠시만 기다려 주세요.</p>
				</div>
			</div>
		</sec:authorize>
		<sec:authorize access="isAnonymous()">
			<script>alert('해당 페이지는 회원만 접근이 가능합니다.'); location.href='${pageContext.request.contextPath}/';</script>
		</sec:authorize>
    </main>
<jsp:include page="../includes/footer.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js/loans.js"></script>
<script>
$(function () {
    var token = $("meta[name='_csrf']").attr('content');
    var header = $("meta[name='_csrf_header']").attr('content');
    if(token && header) {
        $(document).ajaxSend(function(event, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    }
});
 // 대출 예약 취소 by Member
function cancelLoansReservationByMember(lno, bkno, id) {
	//대출예약 취소시 로그인여부 확인
	<sec:authorize access="isAnonymous()">
		if(confirm("대출예약 취소하시려면 로그인 하셔야합니다. 로그인 페이지로 이동하시겠습니까?"))
			location.href="${pageContext.request.contextPath}/member/login";
		else return;
	</sec:authorize>
	if (confirm("해당 "+ lno +"번 대출예약 신청 건을 취소하시겠습니까?")) {
		$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});
		var loans = {lno: lno, bkno: bkno, id: id};
 		loansService.cancelLoansReservationByMember(loans, function(result) {
			$("#LoadingLayerModal").modal('hide');
			alert(result);
			location.reload();
		})
	}
}
</script>
</body>
</html>