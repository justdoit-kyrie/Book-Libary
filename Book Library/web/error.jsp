<%-- 
    Document   : error
    Created on : Jun 15, 2021, 7:37:29 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
    </head>
    <body>
        <%
            String message = (String)session.getAttribute("ERROR_MESSAGE");
        %>
        <h1 style="color: red"><%= message %></h1>
    </body>
</html>
