<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
  	<title>web Demo</title>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="mystyle.css">


</head>

<body>

<!-- Header -->
<div class="header">
  <h1>Inventory Management Database System</h1>
  <p>Latest in Java technologies</p>
</div>

<!-- Navigation Bar -->
<!-- <div class="navbar"> -->

	<ul>
		<li><a href="home.html">Home</a></li>
		<li><a href="addlaptop.jsp">Add Laptop</a></li>
		<li><a href="listall">List all Laptops</a></li>
		<li><a href="search.html">Search Laptop</a></li>
		<li><a href="memo">Memo</a></li>
		<li><a href="login.jsp">Login</a></li>
		
		<li><a href="about.html" style="float:right">About</a></li>

	</ul>
<!-- </div> -->

<div class="row">

	<div class="column side">
		<h2>side column</h2>
		<p style="color:red;">${user}</p>
		<a href="logout">Logout</a>
	</div>

	<div class="column middle">
		<div class="card">
			<h2>Inventory Management Database System</h2>
						
			<h3>Search results for MemoID: ${memoid}  </h3> 
			<%
				boolean isfound = (boolean)request.getAttribute("isfound");
				String memoid = (String)request.getAttribute("memoid");
				if(isfound == true){
					
					out.println("MemoID found in DB" + memoid);
					out.println("<br>");
					
			%>
					<div class="memobox">
					<form action="updateMemo">
						<label for="memoID">MemoID</label>
						<input type="text" id="memoID" name="memoID" readonly value="<c:out value='${memoid}' />" >
					
						<label for="state">Change State:</label>
						<select id="state" name="state">
							<option value="onhand"   <c:if test="${memobean.state eq 'on hand'}">selected="selected"</c:if>  >On hand, box packed </option>
							<option value="intransit" <c:if test="${memobean.state eq 'in transit'}">selected="selected"</c:if> >In Transit, shipped out </option>	
							<option value="delivered" <c:if test="${memobean.state eq 'delivered'}">selected="selected"</c:if> >Delivered </option>				
						</select>
						<label for="fedex">Enter FedEx tracking#</label>
						<input type="text" id="fedex" name="fedex" placeholder="7774139..." value = "<c:out value='${memobean.fedex}' />">
						
						<!-- 
						<label for="fedexid">FedEx#</label>
						<input type="text" id="fedexid" name="fedexid" value = "<c:out value='${memobean.fedex}' />" >
						 -->
						
						<input type="submit" value="Update Memo">
					</form>
					</div>
					<br>
					<h4>Laptops in memo:  ${searchsize} </h4>
					<br>
					
					<!-- The table data -->
					<table>
						<tr>
							<th>Serial</th>
							<th>Model</th>
							<th>Manufacture</th>
							<th>Notes</th>
							<th>Assigned</th>
							
							
						</tr>
						
						<c:forEach var="laptop" items="${memoresults}">
						
							<tr>
								<td><c:out value="${laptop.serial}"></c:out> </td>
								<td><c:out value="${laptop.model}"></c:out> </td>
								<td><c:out value="${laptop.manufacture}"></c:out> </td>
								<td><c:out value="${laptop.notes}"></c:out> </td>
								<td><c:out value="${laptop.assigned}"></c:out> <c:if test="${laptop.assigned eq 'yes' }"> <c:out value="${laptop.user}"></c:out> 
											
								</c:if> </td>
		                                
		                  
							</tr>
						</c:forEach>
								
					</table>		
			<%		
				}else{
					out.println("<b><h2>NOT found in DB: MemoID  " + memoid + "</b></h2>");
					
				}
			
			%>
			<br>
			
			
		</div>	
	</div>
	<!--
	<div class="column side">
		<h2>Right side column</h2>
		<p>some bllah blah text, latin, ip address</p>
	</div> -->
	
</div>

</body>

</html>