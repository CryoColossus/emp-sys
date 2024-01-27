<%@page import="java.sql.*"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Enter Event</title>
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
<h1 class='display-1'>Enter Event Details</h1>
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
<form action="event_add_update.jsp" method="post">
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Event Name</label>
    <div class="col-sm-10">
      <input type="text" name="inputename" class="form-control" id="inputename" required>
    </div>
  </div>
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Start Time</label>
    <div class="col-sm-10">
      <input type="datetime-local" name="starttime" class="form-control" id="starttime" required>
    </div>
  </div>
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">End Time</label>
    <div class="col-sm-10">
      <input type="datetime-local" name="endtime" class="form-control" id="endtime" required>
    </div>
  </div>
  <div class="row">
  <div class="col-4">
  <p>Select Type</p>
  </div>
  <div class="col-4">
	<div class="form-check">
  		<input class="form-check-input" type="radio" name="type" id="flexRadioDefault1" value="online" required>
  		<label class="form-check-label" for="flexRadioDefault1">
    	Online
 		</label>
	</div>
	</div>
	<div class="col-4">
	<div class="form-check">
  		<input class="form-check-input" type="radio" name="type" id="flexRadioDefault2" value="offline" required>
  		<label class="form-check-label" for="flexRadioDefault2">
    	Offline
 		</label>
	</div></div></div><br>
	<div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Capacity</label>
    <div class="col-sm-10">
    <div class="row">
    <div class="col">
      <input type="number" name="cap" class="form-control" id="cap" required>
    </div>
    <div class="col"></div>
    </div>
    </div>
  </div>
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Description</label>
    <div class="col-sm-10">
      <input type="text" name="description" class="form-control" id="description">
    </div>
  </div>
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Location</label>
    <div class="col-sm-10">
      <input type="text" name="location" class="form-control" id="location" required>
    </div>
  </div>
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Online Info</label>
    <div class="col-sm-10">
      <input type="text" name="online" class="form-control" id="online">
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