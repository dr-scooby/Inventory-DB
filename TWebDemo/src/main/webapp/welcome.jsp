<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>MGW DB</title>
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

	<ul class="nav navbar-nav">
     <li><a href="#">Home</a></li>
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
			<h2>Welcome, login passed</h2>
			
			<%
				// This will prevent the back button after logout
				response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			
				if(session.getAttribute("user") == null){
					response.sendRedirect("login.jsp");
				}
			%>
			Message from server ${message}
			<br>
			Welcome ${user}
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
