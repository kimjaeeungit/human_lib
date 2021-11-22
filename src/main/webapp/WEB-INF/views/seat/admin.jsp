<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
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
		<sec:authorize access="hasAnyRole('ROLE_ANONYMOUS', 'ROLE_MEMBER')">
			<script>
				alert('해당 페이지는 관리자만 접근이 가능합니다.');
				location.href='${pageContext.request.contextPath}/';
			</script>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
	        <div class="managerBoard">
	            <div class="managerBoardArea mx-auto">
	            		<div class="managerBoardBox px-2 py-5">
		                    <div class="bookListTitle clearfix pb-2 border-bottom border-2 border-info">
		                        <h5 class="float-left text-info">자리 예약관리</h5>
		                    </div>
							<div class="table-responsive my-3 revTable">
								<table class="table table-hover">
									<thead class="bg-dark text-light">
										<tr>
											<th colspan="3" class="border-right border-light text-center small">자리정보</th>
											<th colspan="4" class="border-right border-light text-center small">예약정보</th>
										</tr>
										<tr>
											<th class="border-right border-light text-center small">예약<br>번호</th>
											<th class="border-right border-light text-center small">좌석<br>번호</th>
											<th class="border-right border-light text-center small align-middle">열람실</th>
											<th class="border-right border-light text-center small align-middle">아이디</th>
											<th class="border-right border-light text-center small align-middle">예약일</th>
											<th class="border-right border-light text-center small">예약<br>시간</th>
											<th class="border-right border-light text-center small bg-primary">예약<br>상태</th> 
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${list}" var="sRev">
										<tr>
											<td class="text-center small">${sRev.revNo}</td>
											<td class="text-center small">${sRev.seatNo}</td>
											<td class="text-center small">${sRev.loc}</td>
											<td class="text-center small">${sRev.id}</td>
											<td class="text-center small">
												<fmt:formatDate pattern="yyyy-MM-dd" value="${sRev.revDate}"/>
											</td>
											<td class="text-center small">${sRev.revTime+8}:00 - ${sRev.revTime+9}:00 </td>
											<td class="text-center small revStatus">
												<fmt:formatDate var="revDate" pattern="yyyy-MM-dd" value="${sRev.revDate}"/>
												<fmt:formatDate var="sysdate" pattern="yyyy-MM-dd" value="${today}"/>
												<c:choose>
													<c:when test="${revDate >= sysdate && sRev.revTime > current}">
														이용예정
													</c:when>
													<c:when test="${revDate >= sysdate && sRev.revTime == current}">
														<span class="ing">이용중</span>
													</c:when>
													<c:otherwise>
														<span>이용완료</span>
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
							<!-- Pagination -->
 							<div class="col text-center">
								<div class="managerListPagination btn-group">
									<c:if test="${page.prev}">
									<button type="button" class="btn btn-outline-primary" onclick="location.href='admin?pageNum=${page.startPage-1}&amount=${page.cri.amount}'">
										<i class="fas fa-angle-left"></i> 이전
									</button>
									</c:if>
									<c:forEach begin="${page.startPage}" end="${page.endPage}" var="p">
									<button type="button" class="btn btn-outline-primary ${p == page.cri.pageNum ? 'active' : ''}" onclick="location.href='admin?pageNum=${p}&amount=${page.cri.amount}'">
										${p}
									</button>
									</c:forEach>
									<c:if test="${page.next}">
									<button type="button" class="btn btn-outline-primary" onclick="location.href='admin?pageNum=${page.endPage+1}&amount=${page.cri.amount}'">
										다음 <i class="fas fa-angle-right"></i>		
									</button>
									</c:if>
								</div>
							</div>
		                </div>
                	</div>
                </div>
	        </sec:authorize>
	    </main>
    <jsp:include page="../includes/footer.jsp"></jsp:include>
</body>
</html>