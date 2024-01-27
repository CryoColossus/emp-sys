<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import='java.sql.*,oracle.jdbc.OracleDriver' %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>    
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Remove</title>
<style type="text/css">.jumbotron{
		padding: 4rem 2rem;
		margin-bottom: 2rem;
		background-color: var(--bs-light);
		border-radius: .3rem;  }
		</style>		
</head>
<body>
	<div class="container">
	<div class="jumbotron">
	<h1 class='display-1'>Delete an Entry</h1>
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
	<a class='btn btn-primary btn-lg' href='home.jsp' role='button'>Return Home</a>
	<a class='btn btn-dark btn-lg' href='logout.jsp' role='button'>Log Out</a></div><br>
	<p class='lead'>
	<%
		String user="";
		String pass="";
		int val,count,redirect=0;
		try
		{	
			user = session.getAttribute("user").toString();
			pass = session.getAttribute("pass").toString();
			DriverManager.registerDriver(new OracleDriver());
			java.sql.Connection temp = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
		}
		catch(Exception e)
		{
			response.sendRedirect("login.jsp");
			redirect=1;
		}
	%>
	</p>
	<form action="delete_update.jsp" method='post'>
	<div class="row">
	<div class="col-6">
	<h1 class="display-6">Select Employee Id</h1>
	<%
		if(redirect!=1)
		{	
		String query = "select emp_id,emp_fname,emp_lname from emp_info";
		DriverManager.registerDriver(new OracleDriver());
		java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		count = 1;
		while(rs.next())
		{	
			val = rs.getInt("emp_id");
			out.print("<div class='form-check'>");
			out.print("<input class='form-check-input' type='radio' name='r' id='flexRadioDefault"+count+"' value='"+val+"'>");
			out.print("<label class='form-check-label' for='flexRadioDefault"+count+"'>");
			out.print(val);	
			out.print(" ("+rs.getString("emp_fname")+" "+rs.getString("emp_lname")+")");		
			out.print("</label></div><br>");
			count++;
		}	
		st.close();
		con.close();
		}
	%>
	</div>
	<div class="col-6">
	<h1 class="display-6">Select Event Id</h1>
	<%
		if(redirect!=1)
		{	
		String query2;	
		if((int)session.getAttribute("id")==0)	
		query2 = "select eventid,ename from event";
		else
		{
			int temp = (int)session.getAttribute("id");
			query2 = "select eventid,ename from event where eventid like (select eventid from event_attendee where attendeeid=("+temp+") and attendee_type='s') order by eventid";
		}
		java.sql.Connection con2 = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
		Statement st2 = con2.createStatement();
		ResultSet rs1 = st2.executeQuery(query2);
		count = 1;
		while(rs1.next())
		{
			val = rs1.getInt("eventid");
			out.print("<div class='form-check'>");
			out.print("<input class='form-check-input' type='radio' name='event' id='flexRadioDefault"+count+"' value='"+val+"'>");
			out.print("<label class='form-check-label' for='flexRadioDefault"+count+"'>");
			out.print(val);		
			out.print(" ("+rs1.getString("ename")+")");						
			out.print("</label></div><br>");
			count++;
		}
		st2.close();
		con2.close();
		}
	%>
	</div>
	<input type="submit" class="btn btn-outline-success">
	</div>
	</form>
	</div>
	</div>
</body>
</html>