<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>H!MARK</title>
<link href="/resources/css/payment.css" rel="stylesheet">
<!-- <link href="/resources/css/modal.css" rel="stylesheet"> -->
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar 사이드바-->
		<page:applyDecorator name="approverSide" />
		<!-- End of Topbar 헤더 끝 -->
		<!-- 요청.html -->
		<div class="container-fluid">

			<!-- Page Heading -->
			<h1 class="h3 mb-2 text-gray-800">상세보기</h1>
			<p class="mb-4">결재 내용을 자세히 확인 할 수 있습니다. 승인 권한이 있는 경우, 결재 수락 및 거부를
				할 수 있습니다</p>

			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link py-3 shadow active"
					data-toggle="tab" href="#tab1">
						<h6 class="m-0 font-weight-bold text-primary">결재 내용</h6>
				</a></li>
			</ul>

			<div class="card shadow mb-4">
				<div class="tab-content">
					<!-- 요청 내역 Start -->
					<div class="tab-pane fade show active" id="tab1">
						<div class="card-body">
							<div class="tab-pane fade show" id="tab1">
								<div class="table-responsive">
									<div class="card-body">
										<p>
										<h6>제목</h6>
										<input type="text" class="form-control col-xl-4" readonly
											name="title" value='<c:out value="${detail.title}"/>'>
										</p>
										<p>
										<h6>양식명</h6>
										<input type="text" class="form-control col-xl-4" readonly
											name="category" value='<c:out value="${detail.category}"/>'>
										</p>
										<p>
										<h6>기안자</h6>
										<strong>${user.head} / ${user.depart} / ${user.team} / ${user.user_name}</strong>
										</p>
										<p>
										<h6>승인자</h6>
										<input type="text" class="form-control col-xl-4" readonly
											name="manager"
											value='<c:out value="${manager[0]}"/>(${detail.managerId})'>
										</p>
										<p>
										<h6>중요도</h6>
										<c:if test='${detail.imp=="긴급"}'>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="imp"
													id="inlineRadio1" value="긴급" checked readonly> <label
													class="form-check-label" for="inlineRadio1">긴급</label>
											</div>
											
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="imp"
													id="inlineRadio3" value="보통" disabled> <label
													class="form-check-label" for="inlineRadio3">보통</label>
											</div>
											
										</c:if>
										
										<c:if test='${detail.imp=="보통"}'>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="imp"
													id="inlineRadio1" value="긴급" disabled> <label
													class="form-check-label" for="inlineRadio1">긴급</label>
											</div>
											
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="imp"
													id="inlineRadio3" value="보통" checked readonly> <label
													class="form-check-label" for="inlineRadio3">보통</label>
											</div>
											
										</c:if>
										
										</p>
										<p>
										<h6>첨부파일</h6>
										<div class="custom-file col-xl-4">

											<div class='uploadResult' style="height: 70px">
												<ul>
												</ul>
											</div>
										</div>

										<div class='bigPictureWrapper'>
											<div class='bigPicture'></div>
										</div>
										</p>
										<p>
										<h6>내용</h6>
										<textarea class="form-control" placeholder="내용을 입력해 주세요."
											rows="10" name="content" readonly>${detail.content}</textarea>
										</p>
										<c:if test='${detail.state eq "반려" || detail.state eq "승인" }'>
											<p>
											<h6>결재 사유</h6>
											<textarea class="form-control" rows="10" name="reason"
												readonly>${detail.reason}</textarea>

											</p>
											<div class="page-wrapper">
												<a class="btn btn-outline-success" type="submit"
													href="/approver/payment?userId=${member.user_id}"
													id="request_btn">목록</a>
											</div>
										</c:if>



										<c:if test='${detail.state eq "대기" }'>

											<!-- 승인자의 경우, 이미 완료된 결재내역 제외 -->
											<div class="page-wrapper">
												<a class="btn btn-outline-success" type="submit"
													href="/approver/payment?userId=${member.user_id}"
													id="request_btn">목록</a> <a class="content-detail">
													<button class="btn btn-outline-danger" type="button"
														id="payment">결재하기</button>
												</a>
											</div>
											<form id='actionForm' action="/approver/payment"
												method='post'>
												<input type='hidden' name='userId' value='${member.user_id}'>
												<input type='hidden' name='requestNo'
													value='${detail.requestNo}'>
											</form>
											<!-- <button class="btn btn-outline-danger" type="submit" id="no">요청 거부</button> -->
											<input type="hidden" id="deny_reason" value="">



			<!-- Modal Start-->
			<form id='PaymentForm' action="/approver/payment"
				method='post'>
				<div class="modal-wrapper">
					<input type='hidden' name='userId' value='${member.user_id}'>
					<input type='hidden' name='requestNo'value='${detail.requestNo}'>
					<div class="rmodal">
						<div class="modal-header">
							<h4 class="modal-title" id="myModalLabel">결재 사유</h4>
							<button type="button" class="close content-detail"
								data-dismiss="modal" aria-hidden="true">&times;</button>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label class="font-weight-bold">사유</label>
								<p>
								<textarea cols="64" rows="10" name="reason"
									placeholder="결재 사유를 입력하세요"></textarea>
									</p>
							</div>
						</div>

						<div class="modal-footer">
							<div class="btn-group btn-group-justified" role="group"
								aria-label="group button">
								<div class="btn-group" role="group">
									<button type="button"
										class="btn btn-default content-detail"
										data-dismiss="modal" role="button">취소</button>
								</div>
								<div class="btn-group" role="group">
									<button type="button" id="refuse"
										class="btn btn-default btn-hover-green" role="button">거부</button>
								</div>
								<div class="btn-group" role="group">
									<button type="button"
										class="btn btn-default content-detail"
										id="accept" data-dismiss="modal" role="button">수락</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</c:if>

		<!-- Modal End -->

										<!-- Swal.fire JS 요청거부 사유 Start -->
										<!-- <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
                                                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                                <script>
                                                    function alert(){
                                                        (async () => {
                                                            const { value: getName } = await Swal.fire({
                                                                title: '요청거부 사유를 입력하세요',
                                                                text: '내용을 입력해주세요',
                                                                input: 'textarea',
                                                                inputPlaceholder: '내용을 입력..',
                                                                showCancelButton: true,
                                                                confirmButtonText: '요청을 거부합니다',
                                                                cancelButtonText: '취소'
                                                            })
                                                            if (getName) {
                                                                Swal.fire(`거부 되었습니다`)
                                                                document.getElementById('deny_reason').value = getName;
                                                            }
                                                        })()
                                                    }
                                                </script> -->
										<!-- Swal.fire JS 요청거부 사유 End -->

										<!-- 승인자의 경우, 이미 완료된 결재내역 제외 -->

									</div>

								</div>

							</div>
						</div>
					</div>
					<!-- 상세보기 End -->


				</div>
			</div>
		</div>
		<!-- 요청.html -->

	</div>
	<!-- End of Main Content -->
	<script>
		$(document)
				.ready(
						function() {

							var rno = '<c:out value = "${detail.requestNo}"/>';
							$
									.getJSON(
											"/general/getAttachList",
											{
												rno : rno
											},
											function(arr) {
												console.log(arr);
												var str = "";
												$(arr)
														.each(
																function(i, obj) {
																	if (!obj.fileType) { // 이미지가 아닌 경우

																		var fileCallPath = encodeURIComponent(obj.uploadPath
																				+ "/"
																				+ obj.uuid
																				+ "_"
																				+ obj.fileName);
																		str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
																		str += "<img src='/resources/img/attach.png'>";
																		str += "<span> "
																				+ obj.fileName
																				+ "</span></br>";
																		str += "</div></li>";
																	} else {

																		// 썸네일 나오게 처리
																		var fileCallPath = encodeURIComponent(obj.uploadPath
																				+ "/s_"
																				+ obj.uuid
																				+ "_"
																				+ obj.fileName);
																		var originPath = obj.uploadPath
																				+ "/"
																				+ obj.uuid
																				+ "_"
																				+ obj.fileName;
																		console
																				.log("originPath1 : "
																						+ originPath);
																		originPath = originPath
																				.replace(
																						new RegExp(
																								/\\/g),
																						"/"); // \를 /로 통일
																		console
																				.log("originPath2 : "
																						+ originPath);
																		str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
																		str += "<a href=\"javascript:showImage(\'"
																				+ originPath
																				+ "\')\"  target='_blank'  ><img src='/display?fileName="
																				+ fileCallPath
																				+ "'></a>";
																		str += "</div></li>";
																	}
																});
												$(".uploadResult ul").html(str);
											}); // getJSON
							$(".uploadResult")
									.on(
											"click",
											"li",
											function(e) {

												console.log("view image");

												var liObj = $(this);

												var path = encodeURIComponent(liObj
														.data("path")
														+ "/"
														+ liObj.data("uuid")
														+ "_"
														+ liObj
																.data("filename"));

												if (liObj.data("type")) {
													//showImage(path.replace(new RegExp(/\\/g),"/"));
													
													window.open("/display?fileName="+path);
												} else {
													//download 
													//self.location = "/download?fileName="+ path;
													
													window.open("/display?fileName="+path)
													}

											});
											
					
				
							//이미지 크게 보여주기
							function showImage(fileCallPath) {
								//alert(fileCallPath);

								$(".bigPictureWrapper").css("display", "flex")
										.show();

								$(".bigPicture").html(
										"<img src='/display?fileName="
												+ fileCallPath + "' >")
										.animate({
											width : '100%',
											height : '100%'
										}, 1000);

							}
							
							
							$(".bigPictureWrapper").on("click", function(e) {
								$(".bigPicture").animate({
									width : '0%',
									height : '0%'
								}, 1000);
								setTimeout(function() {
									$('.bigPictureWrapper').hide();
								}, 1000);
							});

						});
		
		$("#payment").on("click",function(e) {
			$('.modal-wrapper').toggleClass('open');
			return false;
				})

		var PaymentForm = $("#PaymentForm");
		
		$("#accept").on("click",function(e) {
							console.log("요청 수락 click");
							var id = '<c:out value="${member.user_id}"/>';
							e.preventDefault();
							PaymentForm.find('#state').remove();
							PaymentForm
									.append("<input id='state' type='hidden' name='state' value='승인'>")

							PaymentForm.attr("action", "/approver/payment");
							PaymentForm.submit();
						});

		

		$('#refuse').on('click',function() {
							console.log("요청 거절 click");
							PaymentForm.find('#state').remove();
							PaymentForm
									.append("<input id='state' type='hidden' name='state' value='반려'>")

							PaymentForm.attr("action", "/approver/payment");
							PaymentForm.submit();

						});
		
		$('.content-detail').on('click', function() {
		
			$('.modal-wrapper').removeClass('open');
				
		});


	</script>


	<page:applyDecorator name="footer" />
		<script src="/resources/js/request.js"></script>
</body>
</html>