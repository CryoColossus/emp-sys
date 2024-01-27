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
<h1 class='display-1'>Employees</h1>
<div class="d-grid gap-2 d-md-flex justify-content-md-end">
<a class='btn btn-dark' href='logout.jsp' role='button'>Log Out</a></div><br>
<%
	try
	{
		String user = session.getAttribute("user").toString();
		String pass = session.getAttribute("pass").toString();
		String query = "select * from emp_info order by emp_id";
		DriverManager.registerDriver(new OracleDriver());
		java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
		try
		{
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			out.print("<table class='table table-striped table-bordered'>");
			out.print("<tr>");
			out.print("<th scope='col' class='text-center'>"+"Employee Id"+"</th>");
			out.print("<th scope='col' class='text-center'>"+"First Name"+"</th>");
			out.print("<th scope='col' class='text-center'>"+"Last Name"+"</th>");
			out.print("<th scope='col' class='text-center'>"+"Department"+"</th>");
			out.print("</tr>");
			while(rs.next())
			{
				out.print("<tr>");
				out.print("<td scope='col' class='text-center'>"+rs.getInt("emp_id")+"</td>");
				out.print("<td scope='col' class='text-center'>"+rs.getString("emp_fname")+"</td>");
				out.print("<td scope='col' class='text-center'>"+rs.getString("emp_lname")+"</td>");
				out.print("<td scope='col' class='text-center'>"+rs.getString("dept_name")+"</td>");
				out.print("</tr>");
			}
			if((int)session.getAttribute("admin")==1)
			{	
				out.print("<tr>");
				out.print("<td scope='col' class='text-center'><a href='employee_add.jsp'>Add New Employee?</a></td>");
				out.print("</tr>");
			}	
			out.print("</table");
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
%>
<br><br>
<a class='btn btn-primary' href='home.jsp' role='button'>Return Home</a><br><br>
</div></div>
</body>
</html>