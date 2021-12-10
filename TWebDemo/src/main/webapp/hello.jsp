<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>test db</title>
</head>
<body>
<h1>Hello Test DB</h1>

	<%
		String sql = "Select * from laptopinventory; ";
		String url = "jdbc:mysql://jfgapp1261:3306/inteldb";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "nurali", "Java1973");
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(sql);
		
		while(rs.next()){
			out.println("Serial: " + rs.getString(1));
			out.println("Model: " + rs.getString(2));
			out.println("Manufacture: " + rs.getString(3));
			out.println("<br>");
		}
		
		
		
	%>
	


</body>
</html>