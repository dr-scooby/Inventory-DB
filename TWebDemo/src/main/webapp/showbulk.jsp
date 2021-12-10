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
		<li><a href="#contact">Memo Creator</a></li>
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
			<h4>added the following</h4>
			
			
			
			
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
				
				<c:forEach var="laptop" items="${bulkadded}">
				
					<tr>
						<td><c:out value="${laptop.serial}"></c:out> </td>
						<td><c:out value="${laptop.model}"></c:out> </td>
						<td><c:out value="${laptop.manufacture}"></c:out> </td>
						<td><c:out value="${laptop.notes}"></c:out> </td>
						<td><c:out value="${laptop.assigned}"></c:out> </td>
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