<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yy.MM.dd HH:mm" var="rDate" />
<c:set var="tomorrow" value="<%=new Date(new Date().getTime() + 60*60*24*1000 )%>" />
<fmt:formatDate value="${tomorrow}" pattern="yy.MM.dd 18:00" var="reDate" />
<sec:csrfMetaTags/>
<!-- Modal to Reserve Loans -->
<div class="modal" id="modalToReserveLoans">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h5 class="modal-title d-inline mx-auto"><b>대출 예약</b></h5>
				<button type="button" class="close position-absolute mr-0" style="right: 0px;" data-dismiss="modal"><i class="far fa-times-circle"></i></button>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body">
				<div class="text-center p-3">
					필요한 도서만 예약하고 예약 도서는 꼭 대출해 주시기 바랍니다.<br>
					<span class="text-danger">대출만기일까지 대출하지 않으면 예약은 자동 취소됩니다.</span><br><br>
					이미 대출 또는 대출 예약한 도서의 합이 5권인 경우 추가로 대출예약을 할 수 없습니다.<br>
					대출한 책을 반납하거나 이전 대출예약을 취소해야 추가적인 대출예약이 가능합니다.<br>
					<span class="text-dark">(대출예약취소 방법 : MY서재 > 대출예약도서 > 예약취소)</span><br><br>
					<span class="text-danger">반납은 대출일로부터 14일내에 하셔야 합니다.</span><br>
					반납은 연장할 수 없으니 반드시 준수하여 주시고,<br> 
					연체될 경우 도서관 이용에 제한이 있을 수 있습니다.<br><br>
					대출예약한 책이 대출준비가 완료되면 확정 문자가 발송됩니다.<br>
					대출예약 확정 문자를 받으신 경우 도서관 2층 대출카운터에서 받아 가시면 됩니다.<br>
					본인확인을 위해 학생증을 지참하여 주시기 바랍니다.<br>
					<span class="text-dark">(대출 확정 문자를 받지 못하신 경우, 도서관 방문 전 도서관으로 연락주시기 바랍니다.)</span>
				</div>
				<div class="form-check text-center pb-4">
					<label class="form-check-label" for="checkNotice">
						<input type="checkbox" class="form-check-input" id="checkNotice" ><span class="text-danger">[필수]</span> <b>대출 예약 주의사항 확인</b>
					</label>
				</div>
				<div class="mx-1 mx-sm-5 border-bottom border-2 border-info text-info">
					<h5>도서정보</h5>
				</div>
				<div class="mx-1 mx-sm-5 my-3">
					<div class="row mx-auto">
						<div class="col-12 col-sm-3 col-md-2 p-0">
							<img src="${books.thumbnail}" alt="${books.title} 표지" class="w-100">
						</div>
						<div class="col-12 col-sm-9 col-md-10 p-0 px-sm-3 mt-3 mt-sm-0 mt-lg-2">
							<h6 class="col p-0 overflow-hidden text-truncate"><b>${books.title}</b></h6>
							<p class="row mx-0 my-1 mt-2">
								<span class="col-3 col-lg-2 p-0 text-dark">저자</span>
								<span class="col-9 col-lg-10 p-0 text-black overflow-hidden text-truncate">${books.authors}&nbsp;&nbsp;
									<c:if test="${not empty books.translators}">
										(${books.translators} 옮김)
									</c:if>
								</span>
							</p>
							<p class="row mx-0 my-1">
								<span class="col-3 col-lg-2 p-0 text-dark">출판사</span>
								<span class="col-9 col-lg-10 p-0 text-black overflow-hidden text-truncate">${books.publisher}</span>
							</p>
							<p class="row mx-0 my-1">
								<span class="col-3 col-lg-2 p-0 text-dark">발행일</span>
								<span class="col-9 col-lg-10 p-0 text-black overflow-hidden text-truncate">${books.datetime}</span>
							</p>
							<p class="row mx-0 my-1">
								<span class="col-3 col-lg-2 p-0 text-dark">ISBN</span>
								<span class="col-9 col-lg-10 p-0 text-black overflow-hidden text-truncate">${books.isbn}</span>
							</p>
							<p class="row mx-0 my-1">
								<span class="col-3 col-lg-2 p-0 text-dark">도서상태</span>
								<span class="col-9 col-lg-10 p-0 text-black overflow-hidden text-truncate" id="possessionDataStatus"></span>
							</p>
						</div>
					</div>
				</div>
	
				<div class="mx-1 mx-sm-5 mt-4 border-bottom border-2 border-info text-info">
					<h5>대출 정보</h5>
				</div>
				<div class="mx-1 mx-sm-5 my-3">
					<div class="row mx-auto">
						<div class="col-4 text-center bg-light p-2 border border-secondary">도서번호</div>
						<div class="col-4 text-center bg-light p-2 border-top border-bottom border-secondary">대출예약일</div>
						<div class="col-4 text-center bg-light p-2 border border-secondary border-left-0 text-danger">대출만기일</div>
					</div>
					<div class="row mx-auto">
						<div class="col-4 text-center p-2 border border-secondary border-top-0" id="possessionDataBkno"></div>
						<div class="col-4 text-center p-2 border-bottom border-secondary"><c:out value="${rDate}"/></div>
						<div class="col-4 text-center p-2 border border-secondary border-top-0 text-danger"><c:out value="${reDate}"/></div>
					</div>
				</div>
			</div>
			
			<!-- Modal footer -->
			<div class="modal-footer">
				<div class="mx-auto">
					<button type="button" class="btn btn-outline-dark" data-dismiss="modal">취소</button>
					<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="pinfo" />
					<button type="button" class="btn btn-outline-info" onclick="reserveLoans()">대출예약</button>
					</sec:authorize>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal" id="LoadingLayerModal">
	<div class="LoadingLayerBox modal-dialog text-center mt-5">
		<div class="LoadingLayer spinner-border text-info mx-auto" ></div>
		<p class="text-light mt-2">예약 중입니다. 잠시만 기다려 주세요.</p>
	</div>
</div>
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
// 소장도서 상세정보 조회
function openModalToReserveLoans(bkno) {
	<sec:authorize access="isAnonymous()">
	if(confirm("대출예약 하시려면 로그인 하셔야합니다. 로그인 페이지로 이동하시겠습니까?")) {
		location.href="${pageContext.request.contextPath}/member/login";
	}
	else {
		return;
	}
	</sec:authorize>
	loansService.possessionDetail(bkno, function(possessionData) { 
		 var $status = $("#possessionDataStatus");
		 var string = '';
		 if(possessionData.status == 0) {
			 string = '<i class="fas fa-circle text-success"></i>&nbsp;&nbsp;대출가능';		 
		 }
		 else if(possessionData.status == 1) {
			 string = '<i class="fas fa-circle text-warning"></i>&nbsp;&nbsp;대출예약중';	 
		 }
		 else if(possessionData.status == 2) {
			 string = '<i class="fas fa-circle text-danger"></i>&nbsp;&nbsp;대출중';
		 }
		 else {
			 string = '<i class="fas fa-circle text-danger"></i>&nbsp;&nbsp;대출불가';
		 }
		 $status.html(string);
		 
		 var $bkno = $("#possessionDataBkno");
		 $bkno.html(possessionData.bkno);
		 $("#modalToReserveLoans").modal("show");
	 });
}
// 대출 예약
function reserveLoans(bkno, id) {
	var bkno = $("#possessionDataBkno").text();
	var id = '${pinfo.memberVo.id}';
	if($("#checkNotice").is(":checked")) {
		if (confirm("해당 "+ bkno +"번 도서를 예약하시겠습니까?")) {
			$("#modalToReserveLoans").modal('hide');
			$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});
			var loans = {bkno: bkno, id: id};
	 		loansService.reserveLoans(loans, function(result) {
				$("#LoadingLayerModal").modal('hide');
				alert(result);
				location.reload();
			})
		}
	}
	else {
		alert("대출 예약 주의사항을 확인하여 주시기 바랍니다.");
		$("#checkNotice").focus();
	}
}
//미구현 알림
function notService() {
	alert('서비스 준비중입니다. 이용에 불편을 드려 죄송합니다.');
}
</script>