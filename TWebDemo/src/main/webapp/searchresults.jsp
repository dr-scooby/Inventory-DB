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
<ul>
     <li><a href="home.html">Home</a></li>
		<li><a href="addlaptop.jsp">Add Laptop</a></li>
		<!-- <li> <a href="listall">List all Laptops</a> 	</li>  -->
		
		<li class="dropdown">
		    <a href="javascript:void(0)" class="dropbtn">List Laptops</a>
		    <div class="dropdown-content">
		      <a href="listall">List All Laptops on hand</a>
		      <a href="listmodeltype">List by Model Type</a>
		      
		    </div>
		  </li>
		<li class="dropdown"> 
			<a href="javascript:void(0)" class="dropbtn">Search Laptops</a>
			 <div class="dropdown-content">
				<a href="search.html">Search Laptop</a>
				<a href="search.html">Search by Serial</a>
				<a href="search.html">Search by Model</a>
			</div>
		</li>
		<li><a href="memo">Memo</a></li>
		<li><a href="login.jsp">Login</a></li>
		<li style="float:right"><a href="about.html" >About</a></li>
    </ul>
<!-- End Navigation Bar -->

<div class="row">

	<div class="column side">
		<h2>side column</h2>
		<p style="color:red;">${user}</p>
		<a href="logout">Logout</a>
		
		<h2>Quick Links</h2>
		<a href="https://ark.intel.com/content/www/us/en/ark.html">Intel Ark</a>
		<br>
		<a href="https://ark.intel.com/content/www/us/en/ark.html">IT Device Market PC Catalog</a>
		<br>
		<a href="https://it.intel.com/#/">TAC</a>
	</div>

	<div class="column middle">
		<div class="card">
			<h2>Inventory Management Database System</h2>
			<h4>Search results from server</h4>
			
			
			
			<h4>Found results:  ${searchsize} </h4>
			<br>
			<br>
			<!-- The table data -->
			<table>
				<tr>
					<th>Serial</th>
					<th>Model</th>
					<th>Manufacture</th>
					<th>Notes</th>
					<th>Assigned</th>
					<th>Edit Laptop</th>
					<th>Remove Laptop</th>
				</tr>
				
				<c:forEach var="laptop" items="${searchresults}">
				
					<tr>
						<td><c:out value="${laptop.serial}"></c:out> </td>
						<td><c:out value="${laptop.model}"></c:out> </td>
						<td><c:out value="${laptop.manufacture}"></c:out> </td>
						<td><c:out value="${laptop.notes}"></c:out> </td>
						<td><c:out value="${laptop.assigned}"></c:out> <c:if test="${laptop.assigned eq 'yes' }"> <c:out value="${laptop.user}"></c:out> </c:if> </td>
						<td>
                        <a href="edit?serialid=<c:out value='${laptop.serial}' />">Edit</a>
                        </td>
                        
                        <td>
                        <a href="delete?serialid=<c:out value='${laptop.serial}' />">Delete</a>  
                        </td>                   
                  
					</tr>
				</c:forEach>
						
			</table>
			
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