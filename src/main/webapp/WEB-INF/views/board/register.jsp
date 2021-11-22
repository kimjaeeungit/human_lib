<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../includes/head.jsp"></jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/board/css/style.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/ckeditor/4.16.2/ckeditor.js"></script>
<style type="text/css">
.container {
	height: 100%;
}
</style>
</head>
<body>
	<jsp:include page="../includes/header.jsp"></jsp:include>
	<div id="main_reg">
		<div class="container" id="container_reg">
			<form method="post">
				<sec:csrfInput />
				<div class="row">

					<div class="row writeheader mb-3">
						<h3>게시글쓰기</h3>

						<div class="btn">
							
							<button type="button" class="btn btn-outline-secondary"
								id="btnimsave">임시저장 0</button>
							<button class="btn btn-primary" id="btnSubmit">등록</button>
						</div>
					</div>

					<div class="form-group row p-0 mb-0">
						<input type="hidden" class="form-control" id="writer" name="writer" value="dddd" readonly> 
						<input type="hidden" class="form-control" id="tstatus" name="tstatus" value=""> 
						<input class="form-control" id="title" name="title" placeholder="상품명을 입력하세요." value="제목입니다" style="border-radius: 0px;">
					</div>
					<div class="row form-box my-3 px-4 py-4" style="background: #fff;">
						<div class="row">
							<div class="row">
								<h4 class="form_label p-0">판매가격</h4>
							</div>
							<div class="row">
								<input type="text" class="form-control" id="price"
									name="price" placeholder="가격을 입력하세요." onkeyup="numberWithCommas(this.value)"> 
									<span class="won">원</span>
							</div>
						</div>
						<div class="row">
							<div class="row">
								<h4 class="form_label mt-4 p-0">상품상태</h4>
							</div>
							<div class="row">
								<div class="col-12">
									<div class="form-check-inline">
										<label class="form-check-label" for="pstatus"> <input
											type="radio" class="form-check-input" id="pstatus"
											name="pstatus" value="미개봉" checked>미개봉
										</label>
									</div>
									<div class="form-check-inline">
										<label class="form-check-label" for="pstatus"> <input
											type="radio" class="form-check-input" id="pstatus"
											name="pstatus" value="거의새것">거의새것
										</label>
									</div>
									<div class="form-check-inline">
										<label class="form-check-label" for="pstatus"> <input
											type="radio" class="form-check-input" id="pstatus"
											name="pstatus" value="사용감있음">사용감있음

										</label>
									</div>
								</div>
								<div class="row">
									<div class="row">
										<h4 class="form_label mt-4 p-0">배송방법</h4>
									</div>
									<div class="col-12">
										<div class="form-check-inline">
											<label class="form-check-label" for="delivery"> <input
												type="radio" class="form-check-input" id="delivery"
												name="delivery" value="직거래" checked>직거래
											</label>
										</div>
										<div class="form-check-inline">
											<label class="form-check-label" for="radio2"> <input
												type="radio" class="form-check-input" id="delivery"
												name="delivery" value="택배거래">택배거래
											</label>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="row">
								<h4 class="form_label mt-4 p-0">판매자정보</h4>
							</div>
							<div class="row">
								<div class="info px-0" style="width: 156px;">dyzmend97@naver.com
								</div>
								| &nbsp; &nbsp;
								<div class="info px-0" style="width: 110px;">010-3301-6238
								</div>
								<div class="info px-0" style="width: 130px;">
									<button type="button" class="btn btn-primary btn-sm">전화번호
										변경</button>
								</div>
							</div>
							<div class="row">
								<div class="form-check">
									<label class="form-check-label"> <input type="hidden"
										id="agreeyn" value="abcd"> <input type="checkbox"
										id="agree" name="agree" class="form-check-input"
										checked="checked" value="1">휴대전화번호 노출 동의
									</label>
								</div>
							</div>

						</div>
					</div>
					<div class="form-group row p-0">
						<textarea rows="10" class="form-control " id="content"
							name="content"></textarea>


					</div>
					<div class="uploadDiv">


						<input type="file" multiple id="files">
						<!-- <button id="btnUpload">서버 전송</button> -->
					</div>
					<div class="uploadResult">
						<ul class="list-group">

						</ul>
					</div>
				</div>
			</form>
		</div>
	</div>







	<script>
		function showImage(fileCallPath) {
			$("#pictureModal").find("img").attr("src",
					"/display?fileName=" + fileCallPath).end().modal("show");
			//	alert(fileCallPath);
		}
		function numberWithCommas(x) {
			  x = x.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
			  x = x.replace(/,/g,'');          // ,값 공백처리
			  $("#price").val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가 
		}
		

		$(function() {
			var cloneObj = $(".uploadDiv").clone(); //부모태그 가져옴(div)

			var regex = /(.*?)\.(exe|sh|zip|alz)$/;
			var maxSize = 1024 * 1024 * 5;

			
			
			function checkExtension(fileName, fileSize) {
				if (fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				if (regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드 할 수 없습니다.");
					return false;
				}
				return true;
			}

			function showUploadedFile(resultArr) {
				var str = "";
				for ( var i in resultArr) {
					str += "<li class='list-group-item'>"
					if (resultArr[i].image) {
						//알럿창에 이미지 이름 띄우기
						str += "<a href='javascript:showImage(\""
								+ resultArr[i].fullPath + "\")'>"
						str += "<img src='/display?fileName="
								+ resultArr[i].thumb + "'>";
						str += "</a>";
					} else {
						str += "<a href='/download?fileName="
								+ resultArr[i].fullPath + "'>";
						str += "<i class='fas fa-paperclip'></i> "
								+ resultArr[i].origin + "</a>"

					}
					str += "  <small><i data-file='"+ resultArr[i].fullPath +"' data-image='"+resultArr[i].image+"'"
                   str += "class='fas fa-trash-alt text-danger'></i></small></li>";
				}
				$(".uploadResult ul").append(str);
			}

			$(".uploadDiv").on("change", "#files", function() {
				var files = $("#files")[0].files;
				console.log(files);

				var formData = new FormData();
				for ( var i in files) {
					if (!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					formData.append("files", files[i]);
				}

				$.ajax("/upload", {
					processData : false,
					contentType : false,
					data : formData,
					dataType : 'json',
					type : "POST",
					success : function(result) {
						// alert(result);
						console.log(result);
						$(".uploadDiv").html(cloneObj.html());
						showUploadedFile(result);
					}
				})
			});
			// $("#pictureModal").modal("show");
			$(".uploadResult").on("click", "small i", function() {
				var $li = $(this).closest("li");
				$.ajax("/deleteFile", {
					type : "post",
					data : {
						fileName : $(this).data("file"),
						image : $(this).data("image")
					}, //data("image")->true ,false들어가있음
					success : function(result) {
						$li.remove();
					}
				})
			});
			//글작성 이밴트
			$("#btnSubmit")
					.click(
							function() {
								event.preventDefault();
								var str = "";
								var datas = [ "uuid", "path", "origin", "ext",
										"mime", "size", "image" ];
								//datas[0]
								$(".uploadResult li")
										.each(
												function(i) {//(function(i) li반복문의 i
													//여기디스.uploadResult li
													for ( var j in datas)
														//7번돌음
														//for(var j =0;datas.length;j++)
														str += "<input type='hidden' name='attachs["
																+ i
																+ "]."
																+ datas[j]
																+ "' value='"
																+ $(this)
																		.data(
																				datas[j])
																+ "'>";
												});
								//여기디스 btnSubmit
								$(this).closest("form").append(str).submit();
								//console.log($(this).closest("form").append(str).html());
							})

			CKEDITOR
					.replace(
							"content",
							{
								/* filebrowserBrowseUrl: '/apps/ckfinder/3.4.5/ckfinder.html',
								filebrowserImageBrowseUrl: '/apps/ckfinder/3.4.5/ckfinder.html?type=Images', */
								/*  filebrowserUploadUrl: '/apps/ckfinder/3.4.5/core/connector/php/connector.php?command=QuickUpload&type=Files', */
								/* filebrowserImageUploadUrl: '/ckupload?command=QuickUpload&type=Images',
								filebrowserUploadMethod : "form" */
								toolbar : [
										{
											name : 'document',
											items : [ 'Print' ]
										},
										{
											name : 'clipboard',
											items : [ 'Undo', 'Redo' ]
										},
										{
											name : 'styles',
											items : [ 'Format', 'Font',
													'FontSize' ]
										},
										{
											name : 'colors',
											items : [ 'TextColor', 'BGColor' ]
										},
										{
											name : 'align',
											items : [ 'JustifyLeft',
													'JustifyCenter',
													'JustifyRight',
													'JustifyBlock' ]
										},
										'/',
										{
											name : 'basicstyles',
											items : [ 'Bold', 'Italic',
													'Underline', 'Strike',
													'RemoveFormat',
													'CopyFormatting' ]
										},
										{
											name : 'links',
											items : [ 'Link', 'Unlink' ]
										},
										{
											name : 'paragraph',
											items : [ 'NumberedList',
													'BulletedList', '-',
													'Outdent', 'Indent', '-',
													'Blockquote' ]
										}, {
											name : 'insert',
											items : [ 'Image', 'Table' ]
										}, {
											name : 'tools',
											items : [ 'Maximize' ]
										}, {
											name : 'editing',
											items : [ 'Scayt' ]
										} ],
								extraAllowedContent : 'h3{clear};h2{line-height};h2 h3{margin-left,margin-top}',

								// Adding drag and drop image upload.
								extraPlugins : 'print,format,font,colorbutton,justify,uploadimage',
								uploadUrl : '/ckupload.json?command=file&type=Files&responseType=json',
								// Configure your file manager integration. This example uses CKFinder 3 for PHP.
								/* filebrowserBrowseUrl: '/apps/ckfinder/3.4.5/ckfinder.html',
								filebrowserImageBrowseUrl: '/apps/ckfinder/3.4.5/ckfinder.html?type=Images',
								filebrowserUploadUrl: '/ckupload?command=QuickUpload&type=Files', */
								filebrowserImageUploadUrl : '/ckupload.json?command=QuickUpload&type=Images',

								height : 560,
								width : 1318,

								removeDialogTabs : 'image:advanced;link:advanced',
								removeButtons : 'PasteFromWord'

							});
		})
	</script>
	<div class="modal fade" id="pictureModal">
		<div class="modal-dialog  modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Image Detail</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body text-center">
					<img class="mw-100" src="">
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../includes/footer.jsp" />
</body>
</html>