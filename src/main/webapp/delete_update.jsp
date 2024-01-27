<%@page import="oracle.jdbc.OracleDriver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<title>Update...</title>
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
		String s1 = request.getParameter("r");
		String event = request.getParameter("event");
		String user = session.getAttribute("user").toString();
		String pass = session.getAttribute("pass").toString();
		try
		{
			DriverManager.registerDriver(new OracleDriver());
			java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
			PreparedStatement ps = con.prepareStatement("delete from event_attendee where attendeeid=(?) and eventid=(?)");
			ps.setString(1,s1);
			ps.setString(2,event);
			int x = ps.executeUpdate();
			ps.close();
			con.close();
			if(x!=0)
				out.print("<strong>Successfully deleted employee number "+ s1 +" for the event number "+event+"!</strong>");
			else
				out.print("<strong>No Statement to Delete</strong>");
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
<a class='btn btn-success' href='delete_entry.jsp' role='button'>Delete Another Entry</a><br><br>
<a class='btn btn-primary' href='home.jsp' role='button'>Return Home</a>
</div>
</div>
</body>
</html>