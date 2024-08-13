<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, dto.ProductDTO, dto.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<body>
  <%
  	String user = (String)session.getAttribute("user"); //로그인된 id
  	String role = (String)session.getAttribute("role"); //로그인된 계정의 권한
  	String userName = (String)session.getAttribute("userName"); //로그인된 유저이름
  	ArrayList<ProductDTO> datas = (ArrayList<ProductDTO>) request.getAttribute("datas");//상품목록
  %>
  <%--헤더 --%>
  <%@ include file="headerfooter/header.jsp" %>

  <main>
    <h1>메인화면입니다.</h1>
    <%
    if (user != null){ //로그인 상태라면
    	out.println("<h3 class='login'>"+userName+"님 안녕하세요.</h3>");
    }
    %>
    <%--상품 검색 --%>
    <form action="ctrl.jsp?action='MAIN'" method="GET">
    	<select name="type">
    		<option>상품명</option>
    		<option>판매자</option>
    	</select>
    	<input type="text" name="searchKeyword" placeholder="검색어를 입력하세요.">
    	<input type="submit" value="검색">
    </form>
    <%--상품 출력 및 담기, 상세 정보보기 --%>
	<h3>상품 목록</h3>
	<form action="ctrl.jsp" method="POST">
		<input type="hidden" name="action" value="ADDCART">
		<ol>
			<%
				if(datas == null || datas.isEmpty()){ //상품이 하나도 없는 경우 (값이 넘어오지 않은 경우 || 상품 데이터가 없는 경우)
					out.println("<div class='result-none'>상품이 없습니다.</div>");
				}
				else {					
					for(ProductDTO data : datas){ //상품 데이터 출력
						out.println("<li>");
						if(data.getCnt() <= 0){//만약 재고가 없다면
							out.println("<input type='checkbox' disabled>");
							out.println("<strong>[품절]</strong> [상품명] "+data.getName());
						}
						else{//재고가 있다면
							out.println("<input type='checkbox' name='product' value='"+data.getNum()+"'>");
							out.println("<a href='ctrl.jsp?action=PRODUCT&num="+data.getNum()+"'>[상품명] "+data.getName()
							+", [수량] "+data.getCnt()+"개, [가격] "+data.getPrice()+"원</a>");
						}
						out.println("</li>");
 					}
					out.println("<br><button>물건 담기</button>");
				}
			%>
		</ol>
	</form>
  </main>
  <%--푸터 --%>
  <%@ include file="headerfooter/footer.jsp" %>
</body>
</html>