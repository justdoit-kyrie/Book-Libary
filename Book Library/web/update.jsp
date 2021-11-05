<%-- 
    Document   : update
    Created on : Jun 15, 2021, 9:24:16 PM
    Author     : Admin
--%>

<%@page import="sample.users.UserDTO"%>
<%@page import="sample.users.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Update Page</title>
        
        <%-- Link Bootstrap 4 [CSS] --%>
        <link 
            rel="stylesheet" 
            href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
            crossorigin="anonymous"/>

        <style>
            .scheduler-border {
                width: auto !important;
                border: none;
                font-size: 25px;
            }
            input[readonly='']{
                cursor: no-drop;
            }
        </style>
    </head>
    <body>
        <%
            UserError userError = (UserError) request.getAttribute("USER_ERROR");
            if (userError == null) {
                userError = new UserError();
            }
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER_ADMIN");
            if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.html");
                return;
            }
        %>
        <form action="MainController" method="POST" style="margin: 10px 20px">
            <fieldset class="border p-3 border-dark">

                <legend class="scheduler-border">Update User</legend>

                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroup-sizing-default">User ID</span>
                    </div>
                    <input 
                        type="text" 
                        class="form-control col-lg-8" 
                        aria-label="Default" 
                        aria-describedby="inputGroup-sizing-default" 
                        name="userID" 
                        value="<%= request.getParameter("userID")%>"
                        readonly=""/>
                    <p class="text-warning col-lg-4" style="margin: 10px 0"><%= userError.getUserIDError()%></p>
                </div>

                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroup-sizing-default">Name</span>
                    </div>
                    <input 
                        type="text" 
                        class="form-control col-lg-8" 
                        aria-label="Default" 
                        aria-describedby="inputGroup-sizing-default" 
                        name="name" 
                        value="<%= request.getParameter("name")%>"
                        required=""/>
                    <p class="text-warning col-lg-4" style="margin: 10px 0"><%= userError.getNameError()%></p>
                </div>

                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroup-sizing-default">Role ID</span>
                    </div>
                    <input 
                        type="text" 
                        class="form-control col-lg-8" 
                        aria-label="Default" 
                        aria-describedby="inputGroup-sizing-default" 
                        name="roleID" 
                        value="<%= request.getParameter("roleID")%>"
                        required=""/>
                    <p class="text-warning col-lg-4" style="margin: 10px 0"><%= userError.getRoleIDError()%></p>
                </div>

                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroup-sizing-default">Address</span>
                    </div>
                    <input 
                        type="text" 
                        class="form-control col-lg-8" 
                        aria-label="Default" 
                        aria-describedby="inputGroup-sizing-default" 
                        name="address" 
                        value="<%= request.getParameter("address")%>"
                        required=""/>
                    <p class="text-warning col-lg-4" style="margin: 10px 0"><%= userError.getAddressError()%></p>
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroup-sizing-default">Status</span>
                    </div>
                    <input 
                        type="text" 
                        class="form-control col-lg-8" 
                        aria-label="Default" 
                        aria-describedby="inputGroup-sizing-default" 
                        name="status" 
                        value="<%= request.getParameter("status")%>"
                        required=""/>
                    <p class="text-warning col-lg-4" style="margin: 10px 0"><%= userError.getStatusError()%></p>
                </div>
                <input type="hidden" name="search" value="<%= request.getParameter("search")%>"/>
                <input type="submit" class="btn btn-outline-success" name="action" value="Confirm Update"/>
            </fieldset>
        </form>

        <%-- Link Bootstrap 4 [JS] --%>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>    
    </body>
</html>
