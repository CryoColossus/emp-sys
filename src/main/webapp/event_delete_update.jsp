<%@page import="oracle.jdbc.OracleDriver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<title>View</title>
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
<h1 class='display-1'>Employee Registration</h1>
<div class="d-grid gap-2 d-md-flex justify-content-md-end">
<a class='btn btn-dark' href='logout.jsp' role='button'>Log Out</a></div><br>
<%
	try
	{
		String id = request.getParameter("delete");
		String user = session.getAttribute("user").toString();
		String pass = session.getAttribute("pass").toString();
		String query = "delete from event_attendee where eventid="+id;
		String query2 = "delete from event where eventid="+id;
		DriverManager.registerDriver(new OracleDriver());
		java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
		try
		{
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			rs = st.executeQuery(query2);
			session.setAttribute("deleted","hey");
			response.sendRedirect("event_delete.jsp");
		}
		catch(Exception e)
		{}
	}
	catch(Exception e)
	{
		response.sendRedirect("login.jsp");
	}
%>
<a class='btn btn-primary' href='home.jsp' role='button'>Return Home</a>
<br><br>
</div>
</div>
</body>
</html>