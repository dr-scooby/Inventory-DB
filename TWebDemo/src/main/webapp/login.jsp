<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    

<!DOCTYPE html>
<html lang="en">
<head>
  <title>MGW DB</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="style2.css">
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
     	<li><a href="home.html">Home</a></li>
		<li><a href="addlaptop.jsp">Add Laptop</a></li>
		<li><a href="listall">List all Laptops</a></li>
		<li><a href="search.html">Search Laptop</a></li>
		<li><a href="#contact">Memo Creator</a></li>
		<li class="active"><a href="login.jsp">Login</a></li>
		
		<li><a href="about.html" style="float:right">About</a></li>
    </ul>
<!-- </div> -->

<div class="row">

	<div class="column side">
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
			<h3><b>Login</b></h3>
			<br>
			<%
				// get the previous page user was trying to access
				String slink = (String)request.getAttribute("link");
				out.println("The Link: " + slink);	
			%>
			
			<br>
			<h3><b>${message}</b></h3>
			<br>
			<!-- the form for login credentials -->
			<div>
				<form action="login" method="post">
				
					<label for="uname">Enter username</label>
					<br>
					<input type="text" id="uname" name="uname" placeholder="Username">
					<br>
					<label for="pwd">Enter Password</label>
					<br>
					<input type="password" id="pwd" name="passw" placeholder="Password">
					<br>
					<input type="hidden" name="hiddenlink" value="<%=slink %>" > <!-- set the link as a hidden parameter field -->
					
					<input type="submit" value="Login">
				  </form>
			  </div>
			  <!-- End the form for login credentials -->
			  
		</div>	<!-- End class card -->
	</div> <!-- End class column middle -->
	
	
	
	
</div>



</body>
</html>
