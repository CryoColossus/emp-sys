<%@page import="oracle.jdbc.OracleDriver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<title>Delete</title>
<style type="text/css">
    .jumbotron {
      padding: 4rem 2rem;
      margin-bottom: 2rem;
      background-color: var(--bs-light);
      border-radius: .3rem;  
    }
</style>
</head>
<body>
<div class="container">
<div class="jumbotron">
<%
	try
	{
		String user = session.getAttribute("user").toString();
		String pass = session.getAttribute("pass").toString();
		try
		{
			DriverManager.registerDriver(new OracleDriver());
			java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
			PreparedStatement ps = con.prepareStatement("delete from event_attendee");
			int x = ps.executeUpdate();
			ps.close();
			con.close();
			if(x!=0)
				out.print("Succesfully Deleted Entire Table!");
			else
				out.print("Table is Empty!");
		}	
		catch(Exception e)
		{
			out.print("Okay");
		}
	}
	catch(Exception e)
	{
		response.sendRedirect("login.jsp");
	}
%>
<br><br>
<a class='btn btn-primary' href='home.jsp' role='button'>Return Home</a>
<a class='btn btn-success' href='logout.jsp' role='button'>Log Out</a><br><br>
</div>
</div>
</body>
</html>