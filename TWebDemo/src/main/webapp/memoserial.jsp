<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Serial search in Memos</title>
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
			<h2>Memo Search Results</h2>
			<h3>
			<p>
			Search for serial  <%= request.getAttribute("serial") %> found in Memo <%= request.getAttribute("memoID") %>
			<br>
			<%
				boolean found = (boolean)request.getAttribute("found");
				if( found == true){
					String serial = (String)request.getAttribute("serial");
					String memoid = (String)request.getAttribute("memoID");
					out.println("<b>Found Serial: </b>" + serial);
					out.println("in MemoID: " + memoid);
					
				}else{
					String serial = (String)request.getAttribute("serial");
					out.println("Nothing found, no memo listed for serial " + serial);
				}
			
			%>
			</p>			
			</h3>
			
			
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
