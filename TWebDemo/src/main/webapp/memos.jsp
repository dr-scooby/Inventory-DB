<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
					String link = "memos.jsp";
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

	<ul class="nav navbar-nav">
      <li ><a href="home.html">Home</a></li>
      <li ><a href="addlaptop.jsp">Add Laptop</a></li>
      <li><a href="listall">List all Laptops</a></li>
      <li><a href="search.html">Search Laptop</a></li>
      <li class="active"><a href="memo">Memo</a></li>
      <li><a href="login.jsp">Login</a></li>
	  <li><a href="about.html" style="float:right">About</a></li>
    </ul>
<!-- </div> -->


<div class="row">

	<div class="column side">
		<h2>side column</h2>
		<p style="color:red;">${user}</p>
		<a href="logout">Logout ${user}</a>
	</div>

	<div class="column middle">
		<div class="card">
			<h2>Inventory Management Database System</h2>
			<h5>A database system to manage inventory using Java, J2EE, MySQL, Apache Tomcat</h5>
			<h4>hi  ${user}</h4>
			<h4>Memo - create, list, update</h4>
			<br>
			
			<div class="memobox">
			
				<div class="tab">
				  <button class="tablinks" onclick="openMyTabs(event, 'creatememo')" id="defaultOpen">Create Memo</button>
				  <button class="tablinks" onclick="openMyTabs(event, 'searchmemo')">Search Memo</button>
				  <button class="tablinks" onclick="openMyTabs(event, 'listallmemos')">List All Memos</button>
				</div>
			
				<div id="creatememo" class="tabcontent">
				  	<h3>Create Memo</h3>
				  	<p>Enter MemoID#, and serial# of laptops.</p>
					<form action="createMemo" method="post">
						<label for="MemoID">MemoID</label>
						<input type="text" id="MemoID" name="MemoID" placeholder="Memo ID..">
	
						<label for="serials">Enter serials, one per line</label>
						<textarea name="serials"></textarea>
					  
						<input type="submit" value="Submit">
				  	</form>
				  </div> <!-- end the tabcontent -->
				  
				  <div id="searchmemo" class="tabcontent">
					<h3>Search Memo ID or by Serial</h3>
									  
					<form action="searchMemo" method="post">
						<label for="MemoID">MemoID</label>
						<input type="text" id="MemoID" name="MemoID" placeholder="Memo ID..">	
						
						<label for="serials">Enter serials, one per line</label>
						<textarea name="serials"></textarea>	
					  
						<input type="submit" value="Submit">
					 </form>
					</div> <!-- end the tabcontent -->
				  
				  <div id="listallmemos" class="tabcontent">
					<h3>Listing all Memos</h3>
					
					<!-- The table data -->
  
		  			<table>
		            
		            <tr>
		                <th>MemoID</th>
		                <th>State</th>
		                <th>FedEx#</th>
		                <th>Date</th>
		            </tr>
		            <c:forEach var="memos" items="${memolisting}">
		                <tr>
		                    <td><c:out value="${memos.memoid}" /></td>		                    
		                
		               
		                    <td><c:out value="${memos.state}" /></td>		                    
		               
		                
		                    <td><c:out value="${memos.fedex}" /></td>		                    
		               
		               
		                    <td><c:out value="${memos.date}" /></td>		                    
		                </tr>
		            </c:forEach>
		        </table>				  
					
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
