<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
    <header class="fixed-top bg-white">
    <sec:authentication property="principal" var="pinfo"/>
        <div class="header">
            <div class="headerArea mx-auto p-3">
                <div class="headerTop col mx-auto p-0 row">
                    <!-- Logo -->
                    <div class="headerLogo col-3 col-md-2 m-0 p-0">
                        <a href="${pageContext.request.contextPath}/"><img class="w-100" src="${pageContext.request.contextPath}/resources/img/hmu_logo_nav.png" alt="휴먼대학교 도서관 로고"></a>
                    </div>
                    <!-- Search -->
                    <div class="d-none d-md-inline col-md-8 m-0 p-0">
                        <form class="col p-0 text-center">
                            <div class="headerSearch text-left">
                                <label class="searchRadio01 text-center bg-primary small" for="searchBook">
                                    <input type="radio" id="searchBook" name="search-type" checked="checked">&nbsp;&nbsp;통합검색
                                </label>
                                <label class="searchRadio02 text-center bg-info text-primary small" for="searchBoard">
                                    <input type="radio" id="searchBoard" name="search-type">&nbsp;&nbsp;마켓검색
                                </label>
                                <input class="searchInput" type="text">
                                <button class="searchBtn"></button>
                            </div>
                        </form>
                    </div>
                    <!-- Login -->
                    <div class="headerLogin d-none d-sm-inline col-md-2 col-9 m-0 p-0 text-right">
						<sec:authorize access="isAnonymous()">
							<img src="${pageContext.request.contextPath}/resources/img/basic_profile.jpg">&nbsp;&nbsp;				
							<a class="text-decoration-none text-dark" href="${pageContext.request.contextPath}/member/login">로그인</a>
							<span class="d-none d-xl-inline text-dark">&nbsp;/&nbsp;</span>
							<a class="d-none d-xl-inline text-decoration-none text-dark" href="${pageContext.request.contextPath}/member/terms">회원가입</a>
							<!-- 1200px 이하 -->
		                	<div class="dropdown d-inline d-xl-none">
								<button type="button" class="btn btn-white text-dark dropdown-toggle p-0" data-toggle="dropdown"></button>
								<div class="dropdown-menu">
									<a class="dropdown-item py-0" href="${pageContext.request.contextPath}/member/terms">회원가입</a>
									<a class="dropdown-item py-0" href="void(0);" onclick="alert('아이디찾기를 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">아이디찾기</a>
									<a class="dropdown-item py-0" href="void(0);" onclick="alert('비밀번호찾기를 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">비밀번호찾기</a>
								</div>
							</div>
						</sec:authorize>                 
						<sec:authorize access="isAuthenticated()">
							<sec:authentication property="principal" var="pinfo" />
							<a class="text-decoration-none text-dark" href="${pageContext.request.contextPath}/member/profile">
							<c:choose>
								<c:when test="${empty pinfo.memberVo.uuid}">
									<img src="${pageContext.request.contextPath}/resources/img/basic_profile.jpg">&nbsp;&nbsp;
								</c:when>
								<c:when test="${pinfo.memberVo.uuid eq '#'}">
									<img src="${pageContext.request.contextPath}/resources/img/basic_profile.jpg">&nbsp;&nbsp;
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/resources/img/profile/${pinfo.memberVo.uuid}">&nbsp;&nbsp;
								</c:otherwise>
							</c:choose>
							<span class="headerLoginName d-none d-xl-inline">${pinfo.memberVo.name}님 환영합니다.</span></a>
							<div class="dropdown d-inline">
								<button type="button" class="btn btn-white text-dark dropdown-toggle p-0" data-toggle="dropdown"></button>
								<div class="dropdown-menu">
         							<form action="${pageContext.request.contextPath}/logout" method="post"><button class="border-0 bg-white px-3 py-0 text-dark">로그아웃</button><sec:csrfInput/></form>
									<a class="dropdown-item py-0" href="${pageContext.request.contextPath}/member/profile">정보수정</a>
								</div>
							</div>
						</sec:authorize>	                      
                    </div>
                    
                  	<!-- mobile -->
	                <div class="dropdown col-9 p-0 text-right d-inline d-sm-none">
						<button type="button" class="btn btn-white text-primary dropdown-toggle" data-toggle="dropdown">
							<i class="fas fa-bars"></i>
						</button>
						<div class="dropdown-menu">
							<sec:authorize access="isAnonymous()">
								<a class="dropdown-item" href="${pageContext.request.contextPath}/member/login">로그인</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/member/terms">회원가입</a>
								<a class="dropdown-item" href="void(0);" onclick="alert('아이디찾기를 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">아이디찾기</a>
								<a class="dropdown-item pb-2 border-bottom border-light" href="void(0);" onclick="alert('비밀번호찾기를 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">비밀번호찾기</a>
								<a class="dropdown-item pt-2" href="void(0);" onclick="alert('공지사항 게시판을 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">공지사항</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/book/selectbooks">도서관</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/seat/choose">열람실</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/board/list">휴먼마켓</a>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<form class="dropdown-item" action="${pageContext.request.contextPath}/logout" method="post"><button class="border-0 bg-white p-0 text-dark">로그아웃</button><sec:csrfInput/></form>
								<a class="dropdown-item pb-2 border-bottom border-light" href="${pageContext.request.contextPath}/member/profile">회원정보</a>
								<a class="dropdown-item pt-2" href="void(0);" onclick="alert('공지사항 게시판을 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">공지사항</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/book/selectbooks">도서관</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/seat/choose">열람실</a>
								<a class="dropdown-item pb-2 border-bottom border-light" href="${pageContext.request.contextPath}/board/list">휴먼마켓</a>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_MEMBER')">
								<a class="dropdown-item pt-2" href="${pageContext.request.contextPath}/loans/listLoansReservationForMember">MY서재</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/seat/mypage">MY좌석</a>
								<a class="dropdown-item" href="void(0);" onclick="alert('서비스를 준비중입니다.');return false;">MY마켓</a>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<a class="dropdown-item pt-2" href="${pageContext.request.contextPath}/loans/listLoansReservationRequest">픽업(예약현황)</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/loans/listLoansReservationAccept">대출(확정현황)</a>
								<a class="dropdown-item pb-2 border-bottom border-light" href="${pageContext.request.contextPath}/loans/listLoansForManager">반납(대출현황)</a>
								<a class="dropdown-item pt-2" href="${pageContext.request.contextPath}/book/createbook">도서정보등록</a>
								<a class="dropdown-item" href="void(0);" onclick="alert('서비스를 준비중입니다.');return false;">소장도서등록</a>
								<a class="dropdown-item pb-2 border-bottom border-light" href="void(0);" onclick="alert('서비스를 준비중입니다.');return false;">소장도서목록</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/seat/admin">좌석현황</a>
								<a class="dropdown-item pb-2 border-bottom border-light" href="${pageContext.request.contextPath}/seat/seatManage">좌석관리</a>
								<a class="dropdown-item pt-2" href="void(0);" onclick="alert('서비스를 준비중입니다.');return false;">사서관리</a>
							</sec:authorize>
						</div>
					</div>
                </div> 
            </div>
        </div>
        <nav class="clearfix d-none d-sm-block bg-light">
            <div class="navArea mx-auto pt-1">
                <ul class="navBar nav nav-justified m-0">
                    <li class="nav-item"><a href="void(0);" onclick="alert('공지사항 게시판을 준비중입니다. 이용에 불편을 드려 죄송합니다.');return false;">공지사항</a></li>
                    <sec:authorize access="hasAnyRole('ROLE_ANONYMOUS', 'ROLE_MEMBER')">
                    	<li class="nav-item"><a href="${pageContext.request.contextPath}/book/selectbooks">도서관</a></li>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                       	<li class="nav-item">
                    		<a data-toggle="dropdown">도서관리</a>
							<div class="dropdown-menu">
								<a class="dropdown-item manager-menu text-dark small" href="${pageContext.request.contextPath}/loans/listLoansReservationRequest">픽업(예약현황)</a>
								<a class="dropdown-item manager-menu text-dark small" href="${pageContext.request.contextPath}/loans/listLoansReservationAccept">대출(확정현황)</a>
								<a class="dropdown-item manager-menu text-dark small mb-2" href="${pageContext.request.contextPath}/loans/listLoansForManager">반납(대출현황)</a>
								<a class="dropdown-item manager-menu text-dark small border-top border-light" href="${pageContext.request.contextPath}/book/createbook">도서정보등록</a>
								<a class="dropdown-item manager-menu text-dark small" href="void(0);" onclick="alert('서비스를 준비중입니다.');return false;">소장도서등록</a>
								<a class="dropdown-item manager-menu text-dark small" href="void(0);" onclick="alert('서비스를 준비중입니다.');return false;">소장도서목록</a>
							</div>
                    	</li>
                    </sec:authorize>
                    <sec:authorize access="hasAnyRole('ROLE_ANONYMOUS', 'ROLE_MEMBER')">
                    	<li class="nav-item"><a href="${pageContext.request.contextPath}/seat/choose">열람실</a></li>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                       	<li class="nav-item">
                    		<a data-toggle="dropdown">열람실관리</a>
							<div class="dropdown-menu">
								<a class="dropdown-item manager-menu text-dark small" href="${pageContext.request.contextPath}/seat/admin">좌석현황</a>
								<a class="dropdown-item manager-menu text-dark small" href="${pageContext.request.contextPath}/seat/seatManage">좌석관리</a>
							</div>
                    	</li>
                    </sec:authorize>
                    <li class="nav-item"><a href="${pageContext.request.contextPath}/board/list">휴먼마켓</a></li>
					<sec:authorize access="isAnonymous()">
                    	<li class="nav-item"><a href="void(0);" onclick="alert('로그인 후 이용해 주세요.');return false;">MY</a></li>
			        </sec:authorize>
			        <sec:authorize access="hasRole('ROLE_MEMBER')">
                    	<li class="nav-item">
                    		<a data-toggle="dropdown">MY</a>
							<div class="dropdown-menu">
								<a class="dropdown-item manager-menu text-dark small" href="${pageContext.request.contextPath}/loans/listLoansReservationForMember">MY서재</a>
								<a class="dropdown-item manager-menu text-dark small" href="${pageContext.request.contextPath}/seat/mypage">MY자리</a>
								<a class="dropdown-item manager-menu text-dark small" href="void(0);" onclick="alert('서비스를 준비중입니다.');return false;">MY마켓</a>
							</div>
                    	</li>
			        </sec:authorize>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<li class="nav-item"><a href="void(0);" onclick="alert('서비스를 준비중입니다.');return false;">사서관리</a></li>
					</sec:authorize>
                </ul>
            </div>
        </nav>
    </header>
<script>
	$(function() {
		$(".searchBtn").click(function() {
			event.preventDefault();
			if($("#searchBook").is(":checked"))
				location.href="${pageContext.request.contextPath}/book/selectbooks?type=T&keyword=" + $(".searchInput").val();
			else if($("#searchBoard").is(":checked"))
				location.href="${pageContext.request.contextPath}/board/list?type=T&keyword=" + $(".searchInput").val();
		})
	})
</script>  