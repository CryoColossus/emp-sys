<%@page import="oracle.jdbc.OracleDriver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<title>Clearing...</title>
</head>
<body>
<%
	try
	{
		String user = session.getAttribute("user").toString();
		String pass = session.getAttribute("pass").toString();
		DriverManager.registerDriver(new OracleDriver());
		java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",user,pass);
		try
		{
			String query = "delete from event_attendee where eventid in (select eventid from event where end_time<current_timestamp)";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			String query1 = "delete from event where end_time<current_timestamp";
			Statement st1 = con.createStatement();
			ResultSet rs1 = st.executeQuery(query1);
			if(rs1.next())
			session.setAttribute("clear", 100);
			else
			session.setAttribute("clear", 10);
			rs1.close();
			rs.close();
			st1.close();
			st.close();
			con.close();
			response.sendRedirect("view_all.jsp");
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

</body>
</html>