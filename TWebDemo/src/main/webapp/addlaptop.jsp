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
<%
				//This will prevent the back button after logout
				response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
				
				// check if user session is null, re-direct to login page
				if(session.getAttribute("user") == null){
					String link = "addlaptop.jsp";
					request.setAttribute("link", link);
					RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
					dispatcher.forward(request, response);
					//response.sendRedirect("login.jsp");
				}
%>

<!-- Header -->
<div class="header">
  <h1>Inventory Management Database System</h1>
  <p>Latest in Java technologies</p>
</div>

<!-- Navigation Bar -->
<!-- <div class="navbar"> -->
<!-- 	<ul class="nav navbar-nav">  -->
<ul>
     <li><a href="home.html">Home</a></li>
		<li class="active"><a href="addlaptop.jsp">Add Laptop</a></li>
		<!-- <li> <a href="listall">List all Laptops</a> 	</li>  -->
		
		<li class="dropdown">
		    <a href="javascript:void(0)" class="dropbtn">List Laptops</a>
		    <div class="dropdown-content">
		      <a href="listall">List All Laptops on hand</a>
		      <a href="#">List by Model Type</a>
		      <a href="#">Blah</a>
			  <a href="#">Blah</a>
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
			<h5>A database system to manage inventory using Java, J2EE, MySQL, Apache Tomcat</h5>
			<h5>Add laptop to the inventory, hi ${user}</h5>
			
			<div class="formbox">
			
				<div class="tab">
				  <button class="tablinks" onclick="openMyTabs(event, 'single')" id="defaultOpen">Add single Laptop</button>
				  <button class="tablinks" onclick="openMyTabs(event, 'bulk')">Bulk Add</button>
				  <button class="tablinks" onclick="openMyTabs(event, 'upload')">Upload a file</button>
				</div>
			
				<div id="single" class="tabcontent">
				  	<h3>Add Single Laptop to DB</h3>
				  	<p>Enter serial#, Model, and Manufacture.</p>
					<form action="addlaptop" method="post">
					<label for="laptopserial">Laptop Serial#</label>
					<input type="text" id="laptopserial" name="laptopserial" placeholder="Serial number..">

					<label for="model">Model</label>
					<input type="text" id="model" name="model" placeholder="Model.">

					<label for="manufacture">Manufacture</label>
					<select id="manufacture" name="manufacture">
					  <option value="hp">HP</option>
					  <option value="lenovo">Lenovo</option>
					  <option value="dell">Dell</option>
					</select>
				  
					<input type="submit" value="Submit">
				  	</form>
				  </div> <!-- end the tabcontent -->
				  
				  <div id="bulk" class="tabcontent">
					  <h3>Bulk add more than one laptop</h3>
					  <p>Enter the line: serial, model, manufacture.</p> 
					  <p>line should be comma delimited:</p>
					  <p>eg: 5cgx, 850 g4, HP <br>
					  		 cnd8, T15, Lenovo	
					  
					  <form action="addbulk" method="post">
								<textarea name="bulklaptops"></textarea>	
							  
								<input type="submit" value="Submit">
					  </form>
					</div> <!-- end the tabcontent -->
				  
				  <div id="upload" class="tabcontent">
					  <h3>Upload a file</h3>
					  <p>Upload a comma delimited file, must be serial#, model, manufacture.</p>
					  	<form action="fileupload" method="post" enctype="multipart/form-data">
								<textarea name="bulklaptops"></textarea>	
							    <input type="file" name="file" multiple/>
							    
								<input type="submit" value="Submit">
						</form>
				</div> <!-- end the tabcontent -->
				  
				  	<!-- javascript to handle the tab events -->
					<script>
						function openMyTabs(evt, methodtype) {
						  var i, tabcontent, tablinks;
						  tabcontent = document.getElementsByClassName("tabcontent");
						  for (i = 0; i < tabcontent.length; i++) {
						    tabcontent[i].style.display = "none";
						  }
						  tablinks = document.getElementsByClassName("tablinks");
						  for (i = 0; i < tablinks.length; i++) {
						    tablinks[i].className = tablinks[i].className.replace(" active", "");
						  }
						  document.getElementById(methodtype).style.display = "block";
						  evt.currentTarget.className += " active";
						}
						
						// Get the element with id="defaultOpen" and click on it
						document.getElementById("defaultOpen").click();
					</script>
		
		
				  
			  </div> <!-- end the formbox -->
			
		</div>	<!-- end the card -->
	</div> <!-- end the end column middle -->
	<!--
	<div class="column side">
		<h2>Right side column</h2>
		<p>some bllah blah text, latin, ip address</p>
	</div> -->
	
</div>



</body>
</html>
