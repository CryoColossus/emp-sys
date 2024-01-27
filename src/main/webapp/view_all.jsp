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
<h1 class='display-1'>Employee-Event Register</h1>
<div class="d-grid gap-2 d-md-flex justify-content-md-end">
<a class='btn btn-dark' href='logout.jsp' role='button'>Log Out</a></div><br>
<%
	try
	{
		String user = session.getAttribute("user").toString();
		String pass = session.getAttribute("pass").toString();
		String query = "select * from event_attendee";
		DriverManager.registerDriver(new OracleDriver());
		java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
		try
		{
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			out.print("<table class='table table-striped table-bordered'>");
			out.print("<tr>");
			out.print("<th scope='col' class='text-center'>"+"Serial #"+"</th>");
			out.print("<th scope='col' class='text-center'>"+"Event ID"+"</th>");
			out.print("<th scope='col' class='text-center'>"+"Event Name"+"</th>");
			out.print("<th scope='col' class='text-center'>"+"Attendee ID"+"</th>");
			out.print("<th scope='col' class='text-center'>"+"Attendee Type"+"</th>");
			out.print("<th scope='col' class='text-center'>"+"Registration Time"+"</th>");
			out.print("</tr>");
			int count=0;
			Timestamp t = new Timestamp(System.currentTimeMillis());
			Statement st1 = con.createStatement();
			while(rs.next())
			{
				String query2 = "select eventid,start_time,end_time from event where eventid="+rs.getInt("eventid");
				ResultSet rs1 = st1.executeQuery(query2);
				rs1.next();	
				out.print("<tr>");
				out.print("<th scope='col' class='text-center'>"+(++count)+"</th>");
				out.print("<td class='text-center'>"+(rs.getInt("eventid"))+((rs1.getTimestamp("start_time").compareTo(t)<=0&&rs1.getTimestamp("end_time").compareTo(t)>=0)?" <p class='text-success'>(Active)</p>":" <p class='text-danger'>(Inactive)</p>")+"</td>");
				String check = "select ename from event where eventid="+rs.getInt("eventid");
				Statement stcmp = con.createStatement();
				ResultSet temp = stcmp.executeQuery(check);
				temp.next();
				out.print("<td class='text-center'>"+temp.getString("ename")+"</td>");
				out.print("<td class='text-center'>"+rs.getInt("attendeeid")+"</td>");
				out.print("<td class='text-center'>"+((rs.getString("attendee_type")).equals("l")?"Listener":"Speaker")+"</td>");
				out.print("<td class='text-center'>"+rs.getTimestamp("reg_time")+"</td>");
				out.print("</tr>");
				rs1.close();
			}
			out.print("</table>");
			rs.close();
			st.close();
			st1.close();
			con.close();
		}
		catch(Exception e)
		{
			out.print(e);
		}
	}
	catch(Exception e)
	{
		response.sendRedirect("login.jsp");
	}
	try
	{
		int x = (int)session.getAttribute("clear");
		session.removeAttribute("clear");
		if(x==100)
		out.print("<div class='alert alert-success' role='alert'>"+"Successfully Cleared Inactive Events!"+"</div>");	
		else if(x==10)
		out.print("<div class='alert alert-warning' role='alert'>"+"No Outdated Events!"+"</div>");		
	}
	catch(Exception e)
	{}
	if((int)session.getAttribute("admin")==1)
	{	
		out.print("<a class='btn btn-info' href='clear_inactive_events.jsp' role='button'>Clear and Delete Completed Events</a>");
	}	
%>
<br><br>
<a class='btn btn-primary' href='home.jsp' role='button'>Return Home</a><br><br>
</div>
</div>
</body>
</html>