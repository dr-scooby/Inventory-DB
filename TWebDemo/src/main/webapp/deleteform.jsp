<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>MGW DB - Edit</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="mystyle.css">
</head>

<body>
<%
				//This will prevent the back button after logout
				response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			
				if(session.getAttribute("user") == null){
					response.sendRedirect("login.jsp");
				}
%>

<!-- Header -->
<div class="header">
  <h1>Inventory Management Database System</h1>
  <p>Latest in Java technologies</p>
</div>

<!-- Navigation Bar -->
<!-- <div class="navbar"> -->

	<ul class="nav navbar-nav">
     	<li><a href="home.html">Home</a></li>
		<li><a href="addlaptop.jsp">Add Laptop</a></li>
		<li><a href="listall">List all Laptops</a></li>
		<li><a href="search.html">Search Laptop</a></li>
		<li><a href="memo">Memo</a></li>
		<li><a href="login.jsp">Login</a></li>
		
		<li><a href="#about" style="float:right">About</a></li>
    </ul>
<!-- </div> -->

<div class="row">

	<div class="column side">
		<h2>side column</h2>
		<p style="color:red;">${user}</p>
		<a href="logout">Logout ${user}</a>
		
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
			<h2 style="color:red;"><b>Delete the laptop from the DB </b> be carefull</h2>
			
			<!--  display the form box, and allow user to edit laptop -->
			<div class="formbox">
				<form action="deleteMe" method="post">
					<label for="laptopserial">Laptop Serial#</label>
					<input type="text" id="laptopserial" name="laptopserial" value="<c:out value='${laptop.serial}' />"  >

					<label for="model">Model</label>
					<input type="text" id="model" name="model" value="<c:out value='${laptop.model}' /> " >
					
					<label for="notes">Notes</label>
					<textarea name="notes" id="notes"> <c:out value="${laptop.notes}" />  </textarea>
					
					<label for="manufacture">Manufacture</label>
					<select id="manufacture" name="manufacture">
					  <option value="hp" <c:if test="${laptop.manufacture eq 'hp'}">selected="selected"</c:if> >HP </option>
					  <option value="lenovo"   <c:if test="${laptop.manufacture eq 'lenovo'}" >selected="selected"</c:if> >Lenovo</option>
					  <option value="dell"  <c:if test="${laptop.manufacture eq 'dell'}" >selected="selected"</c:if> >Dell</option>
					  <option value="apple"  <c:if test="${laptop.manufacture eq 'apple'}" >selected="selected"</c:if> >Apple</option>
					</select>
				  
					<input type="submit" value="Remove" name="remove">
				  </form>
			  </div>
			
		</div>	
	</div>
	
	<div class="column side">
		
		
	</div> 
	
</div>



</body>
</html>
    