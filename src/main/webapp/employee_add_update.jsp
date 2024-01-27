<%@page import="oracle.jdbc.OracleDriver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<title>Update...</title>
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
<%
	try
	{
		String fname = request.getParameter("inputfname");
		String lname = request.getParameter("inputlname");
		String dept = request.getParameter("inputdept");
		String u = request.getParameter("inputuser");
		String p = request.getParameter("inputpass");
		String user = session.getAttribute("user").toString();
		String pass = session.getAttribute("pass").toString();
		int id=101;
		String query = "select emp_id from emp_info order by emp_id";
		try
		{
			DriverManager.registerDriver(new OracleDriver());
			java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
			Statement st = con.createStatement();
			ResultSet tempRs = st.executeQuery(query);
			while(tempRs.next())
			{
				if(id!=tempRs.getInt("emp_id"))
				break;	
				id++;
			}
			PreparedStatement ps = con.prepareStatement("Insert into emp_info values(?,?,?,?)");
			ps.setInt(1,id);
			ps.setString(2,fname);
			ps.setString(3,lname);
			ps.setString(4,dept);
			int x = ps.executeUpdate();
			ps.close();
			PreparedStatement o = con.prepareStatement("Insert into credentials values(?,?,?,?)");
			o.setInt(1,id);
			o.setInt(2,id);
			o.setString(3,u);
			o.setString(4,p);
			int y = o.executeUpdate();
			o.close();
			con.close();
			if(x!=0)
				out.print("<strong>Successfully registered employee number "+ id +"!</strong>");
			else
				out.print("<strong>Employee already Hired!</strong>");
		}	
		catch(Exception e)
		{
			out.print("<strong>Employee already Hired!</strong>");
		}
	}
	catch(Exception e)
	{
		response.sendRedirect("login.jsp");
	}
%>
<br><br>
<a class='btn btn-success' href='employee_add.jsp' role='button'>Make Another Entry</a><br><br>
<a class='btn btn-primary' href='home.jsp' role='button'>Return Home</a>
</div>
</div>
</body>
</html>