<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Administrator Login</title>
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
<div class='container'>
<div class='jumbotron'>
<h1 class='display-1'>Enter Credentials</h1><br>
<form action="check.jsp" method="post">
  <div class="mb-3 row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Username</label>
    <div class="col-sm-10">
      <input type="text" name="username" class="form-control" id="inputUsername" required>
    </div>
  </div>
  <div class="mb-3 row">
    <label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
    <div class="col-sm-10">
      <input type="password" name="password" class="form-control" id="inputPassword" required>
    </div>
  </div>
    <%
  	try
  	{
  		boolean x =(boolean) session.getAttribute("bad");
    	if(x==true)
    	{	
    		out.print("<div class='alert alert-danger' role='alert'>"+"Username or Password is Incorrect!"+"</div>");
    		session.removeAttribute("bad");
    	}	
    	int y =(int)session.getAttribute("logout");
    	out.print(y);
    	if(y==1)
    	{	
    		out.print("<div class='alert alert-success' role='alert'>"+"Successfully Logged Out!"+"</div>");
    		session.removeAttribute("logout");
    		session.invalidate();
    	}	
  	}
  	catch(Exception e)
  	{}
    try
    {
    	int y =(int)session.getAttribute("logout");
		if(y==1)
		{	
			out.print("<div class='alert alert-success' role='alert'>"+"Successfully Logged Out!"+"</div>");
			session.removeAttribute("logout");
			session.invalidate();
		}
    }
    catch(Exception e)
    {}
  	%>
  <br><br>
  <input type="submit" class="btn btn-outline-success"><br><br>
  </form>
  <br>
  </div>
  </div>
</body>
</html>