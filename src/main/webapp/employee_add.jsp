<%@page import="oracle.jdbc.OracleDriver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>   
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Add Employee</title>
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
<h1 class='display-1'>Enter Employee Details</h1>
<div class="d-grid gap-2 d-md-flex justify-content-md-end">
<a class='btn btn-dark' href='logout.jsp' role='button'>Log Out</a></div><br>
<%
	try
	{
		String user = session.getAttribute("user").toString();
		String pass = session.getAttribute("pass").toString();
		DriverManager.registerDriver(new OracleDriver());
		java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
		con.close();
	}
	catch(Exception e)
	{
		response.sendRedirect("login.jsp");
	}
%>
<form action="employee_add_update.jsp" method="post">
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">First Name</label>
    <div class="col-sm-10">
      <input type="text" name="inputfname" class="form-control" id="inputfname" required>
    </div>
  </div>
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Last Name</label>
    <div class="col-sm-10">
      <input type="text" name="inputlname" class="form-control" id="inputlname" required>
    </div>
  </div>
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Department</label>
    <div class="col-sm-10">
      <input type="text" name="inputdept" class="form-control" id="inputdept" required>
    </div>
  </div>
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">User name</label>
    <div class="col-sm-5">
      <input type="text" name="inputuser" class="form-control" id="inputuser" required>
    </div>
  </div>
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Password</label>
    <div class="col-sm-5">
      <input type="password" name="inputpass" class="form-control" id="inputpass" required>
    </div>
  </div>
  <br>
  <input type="submit" class="btn btn-outline-success">
  </form><br><br>
  <a class='btn btn-primary' href='home.jsp' role='button'>Return Home</a>
  </div>
  </div>
</body>
</html>