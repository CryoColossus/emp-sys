<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import='java.sql.*,oracle.jdbc.OracleDriver' %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>    
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Entry</title>
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
	<h1 class='display-1'>Make an Entry</h1>
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
	<form action="entry_update.jsp" method='post'>
	<div class="row">
	<div class="col-3">
	<h1 class="display-6">Select Employee</h1>
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
			out.print("<input class='form-check-input' type='radio' name='r' id='flexRadioDefault"+count+"' value='"+val+"'required>");
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
	<%
		if(redirect!=1)
		{	
		String query2;
		if((int)session.getAttribute("id")==0)
			query2 = "select eventid,ename from event order by eventid";
		else
		{
			int temp = (int)session.getAttribute("id");
			query2 = "select eventid,ename from event where eventid like (select eventid from event_attendee where attendeeid=("+temp+") and attendee_type='s') order by eventid";
			
		}
		java.sql.Connection con2 = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
		Statement st2 = con2.createStatement();
		ResultSet rs1 = st2.executeQuery(query2);
		count = 1;
		out.print("<div class='row'>");
		out.print("<div class='col-6'>");
		out.print("<h1 class='display-6'>Select Event Id</h1>");
		out.print("</div>");
		out.print("<div class='col-6'>");
		out.print("<h1 class='display-6'>Seats Remaining</h1>");
		out.print("</div></div>");
		while(rs1.next())
		{
			out.print("<div class='row'>");
			out.print("<div class='col-6'>");
			val = rs1.getInt("eventid");
			String cap = "select capacity from event where eventid="+val;
			Statement s = con2.createStatement();
			ResultSet capacity1 = s.executeQuery(cap);
			capacity1.next();
			String booked = "select count(*) as booked from event_attendee where eventid="+val;
			Statement s2 = con2.createStatement();
			ResultSet capacity2 = s2.executeQuery(booked);
			capacity2.next();
			int remain = capacity1.getInt("capacity")-capacity2.getInt("booked");
			out.print("<div class='form-check'>");
			out.print("<input class='form-check-input' type='radio' name='event' id='flexRadioDefault"+count+"' value='"+val+"'"+((remain<=0)?"disabled":"")+" required>");
			out.print("<label class='form-check-label' for='flexRadioDefault"+count+"'>");
			out.print(val);		
			out.print(" ("+rs1.getString("ename")+")");				
			out.print("</label></div></div>");
			out.print("<div class='col-6'>");
			out.print(remain);
			out.print("</div></div><br>");
			count++;
		}
		st2.close();
		con2.close();
		}
	%>
	</div>
	<div class="col-3">
	<h1 class="display-6">Select Type</h1>
	<div class="form-check">
  		<input class="form-check-input" type="radio" name="type" id="flexRadioDefault1" value="s" required>
  		<label class="form-check-label" for="flexRadioDefault1">
    	Speaker
 		</label>
	</div><br>
	<div class="form-check">
  		<input class="form-check-input" type="radio" name="type" id="flexRadioDefault2" value="l" required>
  		<label class="form-check-label" for="flexRadioDefault2">
    	Listener
 		</label>
	</div><br>
	</div>
	<input type="submit" class="btn btn-outline-success">
	</div>
	</form>
	<%
		try
		{
			String temp = session.getAttribute("bad-pass").toString();
			boolean b = Boolean.parseBoolean(temp);
			session.removeAttribute("bad-pass");
			if(b==true)
			{
				out.print("<br><br><div class='alert alert-danger' role='alert'>"+"You Missed some of the Options!"+"</div>");
			}
		}
		catch(Exception e){}
	%>
	</div>
	</div>
</body>
</html>