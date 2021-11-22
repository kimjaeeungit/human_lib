<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy. MM. dd. HH:mm" var="today" />
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../includes/head.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
</head>
<body>
<jsp:include page="../includes/header.jsp"></jsp:include>
    <main>
        <div class="indexBanner">
            <div class="indexBannerArea mx-auto">
                <div class="indexWrap">
                    <!-- slider -->
                    <div class="sliderBox">
                           <div class="slider">
	                            <div class="single-item">
	                                <a href="void(0);" onclick="alert('공지사항 게시판을 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">
	                                	<img class="w-100" src="${pageContext.request.contextPath}/resources/img/slider/banner-1.jpg" alt="공지사항1">
	                                </a>
	                            </div>
	                            <div class="single-item">
	                                <a href="void(0);" onclick="alert('공지사항 게시판을 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">
	                                	<img class="w-100" src="${pageContext.request.contextPath}/resources/img/slider/banner-2.jpg" alt="공지사항1">
	                                </a>
	                            </div>
                           </div>
                    </div>
                    <!-- Reading room -->
                    <div class="readingRoomStatus">
                        <div class="statusBox p-2">
                            <div class="clearfix text-center mx-4 mt-3 mb-2 d-block">
                                <div class="d-none d-lg-block p-2 bg-primary text-light rounded-circle float-left">개관</div>
                                <div class="d-block">
                                    <h6><b>열람실 좌석 현황</b>
                                        <br class="d-block d-sm-none d-lg-block">
                                        <span class="col-1 d-none d-sm-inline d-lg-none"></span>
                                        ${today}</h6>
                                </div>
                            </div>
                            <div class="text-center pt-3 border-top border-warning">
                                <span class="d-block d-sm-inline d-lg-block"><b>1 열람실 :</b>&nbsp;&nbsp;${loc1} / 25&nbsp;&nbsp;<i class="far fa-laugh-squint text-info" title="여유"></i></span>
                                <span class="col-1 d-none d-sm-inline d-lg-none"></span>
                                <span class="d-block d-sm-inline d-lg-block"><b>2 열람실 :</b>&nbsp;&nbsp;${loc2} / 42&nbsp;&nbsp;<i class="far fa-smile text-success" title="보통"></i></span>
                                <br class="d-none d-sm-block d-lg-none">
                                <span class="d-block d-sm-inline d-lg-block"><b>3 열람실 :</b>&nbsp;&nbsp;${loc3} / 25&nbsp;&nbsp;<i class="far fa-meh text-warning" title="혼잡"></i></span>
                                <span class="col-1 d-none d-sm-inline d-lg-none"></span>
                                <span class="d-block d-sm-inline d-lg-block"><b>4 열람실 :</b>&nbsp;&nbsp;${loc4} / 42&nbsp;&nbsp;<i class="far fa-tired text-danger" title="만석"></i></span>
                            </div>
                            <div class="d-block d-sm-none d-xl-block text-center my-2 my-xl-4">
                                <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/seat/choose">열람실 좌석 예약</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- board -->
        <div class="indexBoard clearfix">
            <div class="indexBoardArea mx-auto">
                <div class="row">
                    <!-- my library -->
                    <div class="indexBoardBox col-lg-4 px-5 py-4">
                        <div class="indexBoardTitle clearfix pb-2 border-bottom border-2 border-info">
                            <h5 class="float-left text-info">나의 대출 현황</h5>
		                     <sec:authorize access="isAnonymous()">
		                     	<h5 class="float-right"><a class="text-warning" href="void(0);" onclick="alert('로그인 후 이용해 주세요.');return false;"><i class="fas fa-plus"></i></a></h5>
					        </sec:authorize>
		                    <sec:authorize access="isAuthenticated()">
		                    	<h5 class="float-right"><a class="text-warning" href="${pageContext.request.contextPath}/loans/listLoansReservationForMember"><i class="fas fa-plus"></i></a></h5>
                           	</sec:authorize>
                            
                        </div>
                        <ul class="list-group pt-2">
                             <li class="list-group-item clearfix p-1 border-0 border-bottom border-light">
                                <i class="fas fa-plus-square"></i>&nbsp;&nbsp;대출 예약중 :&nbsp;&nbsp;
                               	<sec:authorize access="isAnonymous()">
                               		<span class="text-dark">로그인 하시면 조회됩니다.</span>
                               	</sec:authorize>
                               	<sec:authorize access="isAuthenticated()">
                               		<a class="text-decoration-none text-black" href="${pageContext.request.contextPath}/loans/listLoansReservationForMember">${countLoansReserVation} 권</a>
                               	</sec:authorize>
                            </li>
                             <li class="list-group-item clearfix p-1 border-0 border-bottom border-light">
                                <i class="fas fa-check-square"></i></i>&nbsp;&nbsp;예약 확정중 :&nbsp;&nbsp;
                               	<sec:authorize access="isAnonymous()">
                               		<span class="text-dark">로그인 하시면 조회됩니다.</span>
                               	</sec:authorize>
                               	<sec:authorize access="isAuthenticated()">
                               		<a class="text-decoration-none text-black" href="${pageContext.request.contextPath}/loans/listLoansReservationForMember">${countLoansAccept} 권</a>
                               	</sec:authorize>
                            </li>
                            <li class="list-group-item clearfix p-1 border-0 border-bottom border-light">
                                <i class="fas fa-book text-primary"></i>&nbsp;&nbsp;도서 대출중 :&nbsp;&nbsp;
                               	<sec:authorize access="isAnonymous()">
                               		<span class="text-dark">로그인 하시면 조회됩니다.</span>
                               	</sec:authorize>
                                <sec:authorize access="isAuthenticated()">
                                	<a class="text-decoration-none text-black" href="${pageContext.request.contextPath}/loans/listLoansForMember">${countLoans} 권</a>
                                </sec:authorize>
                            </li>                        
                            <li class="list-group-item clearfix p-1 border-0 border-bottom border-light">
                                <i class="fas fa-book-dead text-primary"></i>&nbsp;&nbsp;도서 연체중 :&nbsp;&nbsp;
                               	<sec:authorize access="isAnonymous()">
                               		<span class="text-dark">로그인 하시면 조회됩니다.</span>
                               	</sec:authorize>
                                <sec:authorize access="isAuthenticated()">
	                                <a class="text-decoration-none text-black" href="${pageContext.request.contextPath}/loans/listLoansForMember">${countLoansOverdue} 권</a>
                                </sec:authorize>
                            </li>   
                            <li class="list-group-item clearfix p-1 border-0 border-bottom border-light">
                                <i class="fas fa-undo-alt text-primary"></i>&nbsp;&nbsp;최근 반납도서 :&nbsp;&nbsp;
                               	<sec:authorize access="isAnonymous()">
                               		<span class="text-dark">로그인 하시면 조회됩니다.</span>
                               	</sec:authorize>
                                <sec:authorize access="isAuthenticated()">
                                	<a class="text-decoration-none text-black" href="${pageContext.request.contextPath}/loans/listReturnedLoans">${countReturnedLoansRecently} 권</a>
                                </sec:authorize>
                            </li>    
                        </ul>
                    </div>
                    <!-- notice list -->                    
                    <div class="indexBoardBox col-lg-4 px-5 py-4">
                        <div class="indexBoardTitle clearfix pb-2 border-bottom border-2 border-info">
                            <h5 class="float-left text-info">공지사항</h5>
                            <h5 class="float-right"><a class="text-warning" href="void(0);" onclick="alert('공지사항 게시판을 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;"><i class="fas fa-plus"></i></a></h5>
                        </div>
                        <ul class="list-group pt-2">
                            <li class="list-group-item clearfix p-1 border-0 border-bottom border-light">
                                <a class="text-decoration-none text-black" href="void(0);" onclick="alert('공지사항 게시판을 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">공지사항 게시판 이용 불가</a> 
                                <span class="text-dark small">[10]</span>
                                <span class="float-right">2021.11.04</span>
                            </li>
                            <li class="list-group-item clearfix p-1 border-0 border-bottom border-light">
                                <a class="text-decoration-none text-black" href="void(0);" onclick="alert('공지사항 게시판을 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">방역시간 도서관 이용 관련</a> 
                                <span class="text-dark small">[5]</span>
                                <span class="float-right">2021.11.03</span>
                            </li>
                            <li class="list-group-item clearfix p-1 border-0 border-bottom border-light">
                                <a class="text-decoration-none text-black break-word overflow-hidden text-truncate" href="void(0);" onclick="alert('공지사항 게시판을 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">도서관 운영시간 및 열람실 이용...</a> 
                                <span class="text-dark small">[9]</span>
                                <span class="float-right">2021.11.02</span>
                            </li>
                            <li class="list-group-item clearfix p-1 border-0 border-bottom border-light">
                                <a class="text-decoration-none text-black" href="void(0);" onclick="alert('공지사항 게시판을 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">문화체육관광부 장관 표창 수상</a> 
                                <span class="text-dark small">[4]</span>
                                <span class="float-right">2021.11.01</span>
                            </li>
                            <li class="list-group-item clearfix p-1 border-0 border-bottom border-light">
                                <a class="text-decoration-none text-black" href="void(0);" onclick="alert('공지사항 게시판을 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">11월 소방점검 관련 공지</a> 
                                <span class="text-dark small">[1]</span>
                                <span class="float-right">2021.10.31</span>
                            </li>
                        </ul>
                    </div>
                    <!-- market list -->                       
                    <div class="indexBoardBox col-lg-4 px-5 py-4">
                        <div class="indexBoardTitle clearfix pb-2 border-bottom border-2 border-info">
                            <h5 class="float-left text-info">휴먼마켓</h5>
                            <h5 class="float-right"><a class="text-warning" href="${pageContext.request.contextPath}/board/list"><i class="fas fa-plus"></i></a></h5>
                        </div>
                        <ul class="list-group pt-2">
                        	<c:forEach items="${listMarketBoard}" var="marcket">
	                            <li class="list-group-item clearfix p-1 border-0 border-bottom border-light">
	                                <a class="text-decoration-none text-black" href="${pageContext.request.contextPath}/board/get?bno=${marcket.bno}"><c:out value="${marcket.title}" /></a>
	                                <span class="text-dark small">&nbsp;&nbsp;[${marcket.replyCnt}]</span>
	                                <span class="float-right"><fmt:formatDate value="${marcket.regDate}" pattern="yy-MM-dd" /></td></span>
	                            </li>
                        	</c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- best book list -->
        <div class="indexBoard bg-light">
            <div class="indexBoardArea mx-auto">
                <div class="bookListBox px-5 py-4">
                    <div class="bookListTitle clearfix pb-2 border-bottom border-2 border-info">
                        <h5 class="float-left text-info">인기도서</h5>
                    </div>
                    <div class="row">
                        <c:forEach items="${listPopularityPossession}" var="listPP">
                        <div class="col-lg-2 col-4 p-3">
                            <a class="text-decoration-none text-black" href="${pageContext.request.contextPath}/book/detailbooks?isbn=${listPP.isbn}">
                                <img class="w-100 border border-light" src="${listPP.thumbnail}" alt="${listPP.title} 표지">
                                <h6 class="mt-2 overflow-hidden text-truncate"><b>${listPP.title}</b></h6>
                            </a>
                        </div>
                        </c:forEach>                                                                 
                    </div>
                </div>
            </div>
        </div>
        <!-- new book list -->
        <div class="indexBoard">
            <div class="indexBoardArea mx-auto">
                <div class="bookListBox px-5 py-4">
                    <div class="bookListTitle clearfix pb-2 border-bottom border-2 border-info">
                        <h5 class="float-left text-info">신착도서</h5>
                    </div>
                    <div class="row">
                        <c:forEach items="${listNewPossession}" var="listNP">
                        <div class="col-lg-2 col-4 p-3">
                            <a class="text-decoration-none text-black" href="${pageContext.request.contextPath}/book/detailbooks?isbn=${listNP.isbn}">
                                <img class="w-100 border border-light" src="${listNP.thumbnail}" alt="${listNP.title} 표지">
                                <h6 class="mt-2 overflow-hidden text-truncate"><b>${listNP.title}</b></h6>
                            </a>
                        </div>
                        </c:forEach>  
                    </div>
                </div>
            </div>
        </div>
    </main>
<jsp:include page="../includes/footer.jsp"></jsp:include>
</body>
<script>
	$(document).ready(function(){
		$('.slider').slick({
			autoplay: true,
			prevArrow: '<button type="button" class="slick-prev"><img src="${pageContext.request.contextPath}/resources/img/slider/prev.png"></button>',
			nextArrow: '<button type="button" class="slick-next"><img src="${pageContext.request.contextPath}/resources/img/slider/next.png"></button>'
		});
	});
</script>
</html>