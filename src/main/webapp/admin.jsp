<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, dto.ProductDTO, dto.MemberDTO, dto.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
  <link rel="stylesheet" type="text/css" href="css/common.css">
</head>
<body>
  <%
	ArrayList<ProductDTO> datas = (ArrayList<ProductDTO>) request.getAttribute("datas");//상품데이터
  	ArrayList<MemberDTO> userList = (ArrayList<MemberDTO>) request.getAttribute("userList");//선택용 판매자리스트
  %>
  <%@ include file="headerfooter/header.jsp" %>
 
 <main>
 <h2>관리자 페이지입니다.</h2>
 <form action="ctrl.jsp" method="POST">
<h3>상품 추가하기</h3>
 	<%
 		if(userList == null || userList.isEmpty()){//유저가 하나도 없다면
 			out.println("등록가능한 판매자가 없습니다.");
 		}
 		else{//유저가 있다면
 			%>
 			<input type="hidden" name="action" value="INSERTPRODUCT">
		 	상품명 <input type="text" name="name" placeholder="상품명을 입력하세요." required> <br>
		 	상품설명 <input type="text" name="details" placeholder="상품설명을 입력하세요." required> <br>
		 	상품개수 <input type="number" name="cnt" min="0" placeholder="상품개수를 설정하세요." value="0"> <br>
		 	상품가격 <input type="number" name="price" min="0" placeholder="상품가격을 입력하세요." required> <br>
		 	판매자 <select name='seller' required>
 			<%
	 		for(MemberDTO user : userList) {//유저리스트
	 			out.println("<option value="+user.getMid()+">");//넘어가는 값은 id
	 			out.println(user.getName());//이름으로 선택
	 			out.println("</option>");
	 		}
 			%>
	 		</select> <br>
			<button>상품추가하기</button>
 			<%
 		}
 	%>
 </form>
<h3>상품 삭제하기</h3>
<form action="ctrl.jsp?action='ADMIN'" method="GET">
	<select name="type">
		<option>상품명</option>
		<option>판매자</option>
	</select>
	<input type="text" name="searchKeyword" placeholder="검색어를 입력하세요.">
	<input type="submit" value="검색">
</form>
 <form action="adminDelController.jsp" method="POST">
	<ol>
		<%
			if(datas == null || datas.isEmpty()){ //상품데이터가 없다면
				out.println("<div class='result-none'>상품이 없습니다.</div>");
			}
			else {//상품데이터가 있다면
				for(ProductDTO data : datas){//상품데이터 반복
					out.println("<li>");
					out.println("<input type='checkbox' name='product' value='"+data.getNum()+"'>");
					if(data.getCnt() <= 0){//재고가 없다면
						out.println("<strong>[품절]</strong>"); //품절 말머리 추가
					}
					out.println("[상품명] "+data.getName()
						+", [수량] "+data.getCnt()+"개, [가격] "+data.getPrice()+"원");
					out.println("</li>");
 				}
				out.println("<br><button>상품 삭제하기</button>");
			}
		%>
	</ol>
 </form>
 </main>
 <%@ include file="headerfooter/footer.jsp" %>
</body>
</html>