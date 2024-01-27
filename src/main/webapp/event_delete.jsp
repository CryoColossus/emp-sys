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
<form action="event_delete_update.jsp" method='post'>
<%
	try
	{
		String user = session.getAttribute("user").toString();
		String pass = session.getAttribute("pass").toString();
		String query = "select * from event order by eventid";
		DriverManager.registerDriver(new OracleDriver());
		java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
		int count=1;
		try
		{
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			out.print("<table class='table table-striped table-bordered'>");
			out.print("<tr>");
			out.print("<th scope='col' class='text-center'>"+"Event Id"+"</th>");
			out.print("<th scope='col' class='text-center'>"+"Event Name"+"</th>");
			out.print("<th scope='col' class='text-center'>"+"Delete?"+"</th>");
			out.print("</tr>");
			while(rs.next())
			{
				out.print("<tr>");
				out.print("<th scope='col' class='text-center'>"+rs.getInt("eventid")+"</th>");
				out.print("<th scope='col' class='text-center'>"+rs.getString("ename")+"</th>");
				out.print("<th scope='col' class='text-center'>");
				out.print("<div class='form-check'>");
				out.print("<input class='form-check-input' type='radio' name='delete' id='flexRadioDefault"+(count++)+"' value='"+rs.getInt("eventid")+"'>");
				out.print("</th>");
				out.print("</tr>");
			}
			out.print("</table>");
		}
		catch(Exception e)
		{
			out.print(e);
		}
		try
		{
			String del = (String)(session.getAttribute("deleted"));
			if(del.equals("hey"))
			{
				out.print("<div class='alert alert-success' role='alert'>"+"Successfully Deleted Event!"+"</div>");
				session.removeAttribute("deleted");
			}
		}
		catch(Exception e)
		{}
	}
	catch(Exception e)
	{
		response.sendRedirect("login.jsp");
	}
%><br>
<input type='submit' class='btn btn-outline-success'>
</form><br>
<a class='btn btn-primary' href='home.jsp' role='button'>Return Home</a>
<br><br>
</div>
</div>
</body>
</html>