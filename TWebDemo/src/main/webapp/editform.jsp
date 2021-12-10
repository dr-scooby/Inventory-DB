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
		
		<li><a href="about.html" style="float:right">About</a></li>
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
			<h3>Edit the laptop info - ${user}</h3>
			
			<!--  display the form box, and allow user to edit laptop -->
			<div class="formbox">
				<form action="update" method="post">
					<label for="laptopserial">Laptop Serial#</label>
					<input type="text" id="laptopserial" name="laptopserial" value="<c:out value='${laptop.serial}' />"  >

					<label for="model">Model</label>
					<input type="text" id="model" name="model" value="<c:out value='${laptop.model}' /> " >
					
					<label for="manufacture">Manufacture</label>
					<select id="manufacture" name="manufacture">
					  <option value="hp" <c:if test="${laptop.manufacture eq 'hp'}">selected="selected"</c:if> >HP </option>
					  <option value="lenovo"   <c:if test="${laptop.manufacture eq 'lenovo'}" >selected="selected"</c:if> >Lenovo</option>
					  <option value="dell"  <c:if test="${laptop.manufacture eq 'dell'}" >selected="selected"</c:if> >Dell</option>
					  <option value="apple"  <c:if test="${laptop.manufacture eq 'apple'}" >selected="selected"</c:if> >Apple</option>
					</select>
					
					<label for="notes">Notes</label>
					<textarea name="notes" id="notes"> <c:out value="${laptop.notes}" />  </textarea>
					
					<label for="assigned">is Laptop assigned?</label>
					<input type="text" name="assigned" id="assigned" value="${laptop.assigned} - user:: <c:if test="${laptop.assigned eq 'yes' }"> <c:out value="${laptop.user}"></c:out> </c:if>"  />   
					
					<!-- check if the laptop is assigned to user, if yes: -->
					<c:if test="${laptop.assigned eq 'yes' }">
						<label for="assignto">Assigned</label>
						<input type="checkbox" name="assignto" id="assignto" <c:if test="${laptop.assigned eq 'yes' }"> checked</c:if> />
						<br>
						<label for="unassignto">Un-Assign from user</label>
						<input type="checkbox" name="unassignto" id="unassignto"  />
						<br>
						
						<fieldset>
						<input type="radio" name="radioassign" value="assignto" checked>Assign to <br>
						<input type="radio" name="radioassign" value="unassignto" >Un-Assign  <br>
						</fieldset>
					</c:if>
					
					<!-- check if the laptop is assigned to user, if no: -->
					<c:if test="${laptop.assigned eq 'no' }" > 
						<label for="checkassigntonewuser" >Assign TO User</label>
						<input type="checkbox" name="checkassigntonewuser" id="checkassigntonewuser" >
						<input type="text" name="assigntouser"     />
					</c:if>
					
					<br>
					
					
				  
					<input type="submit" value="Submit" name="Save">
				  </form>
			  </div>
			
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
    