<%@page import="oracle.jdbc.OracleDriver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javax.servlet.RequestDispatcher,java.sql.*"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %> 
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Checking...</title>
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
<h1 class='display-1'>
<%
		String user = request.getParameter("username");
		String pass = request.getParameter("password");	
		int commit=0;
		try
		{
			if(user.equals(null)||pass.equals(null))
			response.sendRedirect("login.jsp");	
		}
		catch(Exception e)
		{
			response.sendRedirect("login.jsp");
			commit=1;
		}	
		try
		{
			DriverManager.registerDriver(new OracleDriver());
			java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
			con.close();
			session.setAttribute("user", user);
			session.setAttribute("pass", pass);
			session.setAttribute("loggedin",1);
			session.setAttribute("admin", 1);
			session.setAttribute("id", 0);
			response.sendRedirect("home.jsp");
		}
		catch(Exception e)
		{
			if(commit==0)
			{	
				String us = "System";
				String pa = "minecraft1";
				DriverManager.registerDriver(new OracleDriver());
				java.sql.Connection prime = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",us,pa);
				PreparedStatement ps = prime.prepareStatement("select count(*) from credentials where username=(?) and pass=(?)");
				ps.setString(1,user);
				ps.setString(2,pass);
				int x = ps.executeUpdate();
				ps.close();
				if(x==0)
				{	
					session.setAttribute("bad", true);
					response.sendRedirect("login.jsp");
				}
				else
				{
					session.setAttribute("user", us);
					session.setAttribute("pass", pa);
					session.setAttribute("loggedin",1);
					session.setAttribute("admin", 0);
					PreparedStatement pre = prime.prepareStatement("select emp_id from credentials where username=(?) and pass=(?)");
					pre.setString(1,user);
					pre.setString(2,pass);
					ResultSet rs = pre.executeQuery();
					rs.next();
					int id = rs.getInt(1);	
					session.setAttribute("id", id);
					response.sendRedirect("home.jsp");
				}
			}	
		}
%>
</h1>
</div>
</div>
</body>
</html>