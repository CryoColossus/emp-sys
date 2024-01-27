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
		String name = request.getParameter("inputename");
		String start = (request.getParameter("starttime"));
		start = start.replace('T',' ');
		start = start+":00";
		String end = (request.getParameter("endtime"));
		end = end.replace('T',' ');
		end = end+":00";
		String type = request.getParameter("type");
		int cap = Integer.parseInt(request.getParameter("cap"));
		String description;
		String online_info;
		try
		{
			description = request.getParameter("description");
		}
		catch(Exception e)
		{
			description = "nil";
		}
		String location = request.getParameter("location");
		try
		{
			online_info = request.getParameter("online");
		}
		catch(Exception e)
		{
			online_info = "nil";
		}
		String user = session.getAttribute("user").toString();
		String pass = session.getAttribute("pass").toString();
		try
		{
			
		}
		catch(Exception e)
		{
			
		}
		try
		{
			DriverManager.registerDriver(new OracleDriver());
			java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select eventid from event order by eventid");
			int counter=1;
			while(rs.next())
			{
				if(rs.getInt("eventid")!=counter)
				break;
				counter++;
			}
			PreparedStatement ps = con.prepareStatement("Insert into event values(?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setInt(1,counter);
			ps.setString(2,name);
			ps.setTimestamp(3,Timestamp.valueOf(start));
			ps.setTimestamp(4,Timestamp.valueOf(end));
			ps.setString(5,"i");
			ps.setString(6,(type.equals("online")?"o":"f"));
			ps.setInt(7,cap);
			ps.setString(8,description);
			ps.setString(9,location);
			ps.setString(10,online_info);
			ps.setTimestamp(11,new Timestamp(System.currentTimeMillis()));
			ps.setString(12,"Admin");
			int x = ps.executeUpdate();
			ps.close();
			con.close();
			if(x!=0)
				out.print("Success!");
			else
				out.print("<strong>Repeated Statement!</strong>");
		}	
		catch(Exception e)
		{
			out.print(e);
			out.print(start);
			out.print(end);

		}
	}
	catch(Exception e)
	{
		out.print(e);
	}
%>
<br><br>
<a class='btn btn-success' href='make_entry.jsp' role='button'>Make Another Entry</a><br><br>
<a class='btn btn-primary' href='home.jsp' role='button'>Return Home</a>
</div>
</div>
</body>
</html>