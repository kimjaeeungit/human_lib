<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../includes/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../includes/header.jsp"></jsp:include>
	<div id="main" role="main">
		<div id="main-container" class="main-container">
			<div class="row">
				<div class="px-4 py-3 underdiv">
					<div class="clearfix pb-2 under">
						<h5 class="float-left under-text">중고서적거래</h5>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div id="dropdown"
				class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 mb-3 pr-0">
				<div class="dropdown">
					<ul id="gnb">
						<li>
							<h4>휴먼마켓</h4>
							<ul class="sub">
								<li><a href="#">중고서적거래</a></li>
								<li><a href="#">거래후기</a></li>
								<li><a href="#">공지사항</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="row">
			<!-- lg,xl에서만 보임 -->
			<div id="sidemenu" class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
					<h5 class="side-title">
						<span>휴먼마켓</span>
					</h5>
					<div class="side-content">
						<div
							class="menu-block-wrapper menu-block-ctools-main-menu-1 menu-name-main-menu parent-mlid-17090 menu-level-1">
							<ul class="side">
								<li><a href="#">중고서적거래</a></li>
								<li><a href="#">거래후기</a></li>
								<li><a href="#">공지사항</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div id="tablediv" class="col-xl-9 col-lg-9 col-md-9 col-sm-9 col-9">
				<div class="row mb-3 pl-4">
					<div class="col-2 p-1">
						<select>
							<option selected>셀렉트박스</option>
							<option>옵션1</option>
							<option>옵션2</option>
							<option>옵션3</option>
						</select>
					</div>
					<div class="col-4 p-1">
						<input type="text" id="edit-keyword" name="keyword" value=""
							size="30" maxlength="128" class="form-text">
					</div>
					<div class="col-5 p-1">
						<input type="submit" id="edit-submit" name="" value="검색"
							class="form-submit">
					</div>
				</div>
				<div class="row pl-4">
					<table class="views-table cols-6">
						<thead>
							<tr>
								<th>번호</th>
								<th style="width: 400px;">제목</th>
								<th style="width: 170px; text-align: left;">작성자</th>
								<th style="text-align: left;">작성일</th>
								<th style="width: 80px;">조회</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="board">
				
								<tr>
									<td style="text-align: center;"><c:out value="${board.bno}"/></td>	
									<td><a href="get${page.cri.params}&bno=${board.bno}"><span style="color: orange; margin-right: 10px;"><c:if test="${board.tstatus == null}"><c:out value="판매"/></c:if><c:if test="${board.tstatus != null}"><c:out value="${board.tstatus}"/></c:if></span>
												<c:out value="${board.title}" /><b>[${board.replyCnt}]</b></a></td>
									<td><c:out value="${board.writer}" /></td>
									<td><fmt:formatDate value="${board.regDate}"
											pattern="yy-MM-dd" /></td>
									<td style="text-align: center;">112</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="container">
						<div class="row">
							<div class="col text-right p-2">
							
							<a href="${pageContext.request.contextPath}/board/register">	<input type="button" value="글쓰기" id="btn"> </a>
							</div>
						</div>
					</div>
					<div class="container">
						<div class="row">
							<div class="col-12 p-0">
								<ul class="pager mt-0">
									<!-- <li class="pager-first first"><a title="처음 페이지로 가기" href="#">« 처음 페이지</a></li> -->
									<li class="pager-previous ${page.prev ? '' : 'disabled'}">
										<a title="이전 페이지"
										href="list?pageNum=${page.startPage-1}&amount=${page.cri.amount}">‹
											이전</a>
									</li>
									<c:forEach begin="${page.startPage}" end="${page.endPage}"
										var="p">
										<li
											class="pager-current first ${p == page.cri.pageNum ? 'active' : ''}">
											<a href="list?pageNum=${p}&amount=${page.cri.amount}"
											data-dt-idx="1" tabindex="0">${p}</a>
										</li>
									</c:forEach>
									<li class="pager-next ${page.next ? '' : 'disabled' }"><a
										title="다음 페이지"
										href="list?pageNum=${page.endPage+1}&amount=${page.cri.amount}">다음
											›</a></li>
									<!-- <li class="pager-last last"><a title="마지막 페이지로 가기" href="#">마지막 페이지 »</a></li> -->
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../includes/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$(window)
			.resize(
					function() {
						if (window.innerWidth <= 991) {
							// 다바이스 크기가 992미만일때 
							/* 스크립트내용*/
							document.getElementById("tablediv").className = "col-xl-12  col-lg-12 col-md-12 col-sm-12 col-12";
						} else {
							/* 스크립트내용*/
							document.getElementById("tablediv").className = "col-xl-9 col-lg-9 col-md-9 col-sm-9 col-9";
						}
					}).resize();

	//드롭다운메뉴
	$(function() {
		$('#gnb .sub').hide();//초기 상태에서 서브메뉴 숨김
		$('#gnb').click(function() {//#gnb를 클릭하면
			$('#gnb .sub').slideToggle(100);//#gnb .sub를 토글시킴
		});
	});
</script>
</html>