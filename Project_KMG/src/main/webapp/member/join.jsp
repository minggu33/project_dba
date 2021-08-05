<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<script src="../js/jquery-3.6.0.js"></script>
<style type="text/css">
.project_kmg_join {
	display: block!important;
}

.project_kmg_join div {
	margin: 0 auto;
}

</style>


<script type="text/javascript">
	$(function(){
		
	$('#id1').keyup(function(){
		var userid = $(this).val();
		
		$.ajax({
			
			url:"joinIDCheck.jsp?userid="+userid,
			type: "get",
			
			success: function(data){
				console.log(userid);
				if(data==1){
						$("#id_check").html("사용할 수 없는 아이디입니다.");
						$("#id_check").css("color", "red");
						$("#submit").attr("disabled", true);
				}else{
					$("#id_check").html("사용 가능한 아이디입니다.");
					$("#id_check").css("color", "blue");
					$("#submit").attr("disabled", false);
				}
				}
			});
		
	});
	
	
		$('#nName').keyup(function(){
			var usernName = $(this).val();
			
			$.ajax({
				
				url:"joinNNameCheck.jsp?usernName="+usernName,
				type: "get",
				
				success:function(data){
					console.log(usernName);
					if(data==1){
						$("#nName_check").text("중복된 닉네임입니다.");
						$("#nName_check").css("color", "red");
						$("#submit").attr("disabled", true);
				}else{
					$("#nName_check").text("사용 가능한 닉네임입니다.");
					$("#nName_check").css("color", "blue");
					$("#submit").attr("disabled", false);
				}
				}
				
				
			});
			
		});
	
	

	
		
	});

	</script>

<script type="text/javascript">

	
	function check2(){
	
		// 아이디 입력 여부(공백)
		if(document.fr.id.value ==""){
			alert("아이디를 입력하세요.")
			document.fr.id.focus();
			return false;
		}

		
		// 아이디의 길이가 5이상일때 submit
		if((document.fr.id.value.length < 5) || (document.fr.id.value.length >10)){
			alert("아이디 5~10자리를 입력하세요.");
			document.fr.id.focus();
			return false;
		}
		// 비밀번호 입력했을때만 submit
		if(document.fr.pw.value ==""){
			alert("비밀번호를 입력하세요.");
			document.fr.pw.focus();
			return false;
		}
		
		
	}
 
 </script>


</head>
<body>

		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../header/header.jsp" />

		<!-- 헤더들어가는 곳 -->

			<h1 align="center">Join Us</h1>
		
					<form class="row g-3 project_kmg_join" action="joinPro.jsp" method="post" name="fr" id="fr" onsubmit="return check2()">
					  <div class="col-md-2">
					    <label for="id1" class="form-label">아이디</label>
					    <input type="text" class="form-control" id="id1" name="id">
					  <div class="check_font" id="id_check">&nbsp;</div>
					  </div>
					  <div class="col-md-2">
					    <label for="pw" class="form-label">비밀번호</label>
					    <input type="password" class="form-control" id="pw" name="pw">
					  </div>
					  <div class="col-md-2">
					    <label for="name" class="form-label">이름</label>
					    <input type="text" class="form-control" id="name" name="name">
					  </div>
					  <div class="col-md-2">
					    <label for="nName" class="form-label">닉네임</label>
					    <input type="text" class="form-control" id="nName" name="nName">
					    <div class="check_font" id="nName_check"></div>
					  </div>
					  <div class="col-md-2">
					    <label for="age" class="form-label">나이</label>
					    <input type="number" class="form-control" id="age" name="age">
					  </div>
					  <div class="col-md-2">
					    <label for="email" class="form-label">이메일</label>
					    <input type="email" class="form-control" id="email" name="email">
					  </div>
					  <br>
					  <div class="col-md-2">
				    <label for="postcode" class="form-label">우편번호</label>
				  <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" style="margin-left: 10%;"><br> 
				    <input type="text" class="form-control" id="postcode" placeholder="1234 Main St" name="postcode">
				  </div>
				  <div class="col-md-3">
				    <label for="address" class="form-label">주소</label>
				    <input type="text" class="form-control" id="address" name="address" placeholder="Apartment, studio, or floor">
				  </div>
				  <div class="col-md-3">
				    <label for="detailAddress" class="form-label">상세주소</label>
				    <input type="text" class="form-control" id="detailAddress" placeholder="Apartment, studio, or floor" name="detailAddress">
				    <input type="hidden" name="extraAddress" id="extraAddress" placeholder="참고항목">
				  </div>
					  <div class="col-md-3">
					    <label for="phone" class="form-label">전화번호</label>
					    <input type="text" class="form-control" id="phone" name="phone">
					  </div>
					  				<div id="layer"
						style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
							id="btnCloseLayer"
							style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
							onclick="closeDaumPostcode()" alt="닫기 버튼">
					</div>
				
					<script
						src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
					  <br><br><br>
						<div class="col-3">
					   <input type="submit" id="submit" value="Sign in" class="btn btn-primary">
				 
					 </div>		  
</form>
		
		<script src="../js/jquery-3.6.0.js" ></script>
</body>
</html>