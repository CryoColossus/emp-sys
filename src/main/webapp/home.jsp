<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import='java.sql.*,oracle.jdbc.OracleDriver'%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Hello User</title>
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
<%
	try
	{
		String x = session.getAttribute("user").toString();
		String y = session.getAttribute("pass").toString();
		DriverManager.registerDriver(new OracleDriver());
		java.sql.Connection test = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",x,y);
		test.close();
	}
	catch(Exception e)
	{
		response.sendRedirect("login.jsp");
	}
%>
<div class='container'>
<div class='jumbotron'>
<h1 class='display-1'>Home Page
<%
	int id = (int)session.getAttribute("id");
	if(id!=0)
	{
		String a = session.getAttribute("user").toString();
		String b = session.getAttribute("pass").toString();
		DriverManager.registerDriver(new OracleDriver());
		java.sql.Connection name = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",a,b);
		String query = "select emp_fname,emp_lname from emp_info where emp_id="+id;
		Statement st = name.createStatement();
		ResultSet rs1 = st.executeQuery(query);
		rs1.next();
		String fname = rs1.getString(1);
		String lname = rs1.getString(2);
		out.print("-"+fname+" "+lname);
	}	
	else
	out.print("-ADMIN");	
%>
</h1>
<div class="d-grid gap-2 d-md-flex justify-content-md-end">
<a class='btn btn-dark' href='logout.jsp' role='button'>Log Out</a></div><br>
<p class='lead'>Select what you want to do</p><hr><br><br>
<div class='row'>
<div class='col-4 text-center'><h3>Add</h3></div>
<div class='col-4 text-center'><h3>Remove</h3></div>
<div class='col-4 text-center'><h3>View</h3></div><br><br><br>
<%
if((int)session.getAttribute("admin")==1)
{	
	out.print("<div class='col-4 text-center'>");
	out.print("<h5><small class='text-muted'><a href='make_entry.jsp' class='link-success'>Register Employee to an Event</a></small></h5><br>");
	out.print("<h5><small class='text-muted'><a href='employee_add.jsp' class='link-success'>Hire Employee</a></small></h5><br>");
	out.print("<h5><small class='text-muted'><a href='event_add.jsp' class='link-success'>Add Event</a></small></h5><br></div>");
	out.print("<div class='col-4 text-center'>");
	out.print("<h5><small class='text-muted'><a href='event_delete.jsp' class='link-warning'>Delete Event</a></small></h5><br>");
	out.print("<h5><small class='text-muted'><a href='delete_entry.jsp' class='link-warning'>Remove Employee from an Event</a></small></h5><br>");
	out.print("<h5><small class='text-muted'><a href='delete_all.jsp' class='link-warning'>Clear Employee-Event Manager</a></small></h5><br></div>");
}
else
{
	out.print("<div class='col-4 text-center'><a href='make_entry.jsp' class='link-success'>To your Event</a></div>");
	out.print("<div class='col-4 text-center'><a href='delete_entry.jsp' class='link-warning'>From your Event</a></div>");
}
out.print("<div class='col-4 text-center'>");
out.print("<h5><small class='text-muted'><a href='view_all.jsp' class='link-primary'>View Employee-Event Manager</a></small></h5><br>");
out.print("<h5><small class='text-muted'><a href='view_employee.jsp' class='link-primary'>View Employees</a></small></h5><br>");
out.print("<h5><small class='text-muted'><a href='view_event.jsp' class='link-primary'>View Events</a></small></h5><br></div>");
%>
</div></div>
</div>
</body>
</html>