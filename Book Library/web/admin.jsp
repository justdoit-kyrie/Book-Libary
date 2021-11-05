<%-- 
    Document   : admin
    Created on : Jun 15, 2021, 7:42:30 PM
    Author     : Admin
--%>

<%@page import="java.util.List"%>
<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>

        <%-- Link Bootstrap 4 [CSS] --%>
        <link 
            rel="stylesheet" 
            href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
            crossorigin="anonymous"/>
        
        <%-- Link Awesome --%>
        <link 
            rel="stylesheet" 
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
            integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" 
            crossorigin="anonymous" 
            referrerpolicy="no-referrer" />
        <style>
            .flex{
                display: flex;
                justify-content: space-between;
                align-content: center;
                padding: 10px;
            }
        </style>
    </head>
    <body>

        <%
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER_ADMIN");
            if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.html");
                return;
            }
        %>
        <div class="flex">
            <h1>Hello Admin: <%= loginUser.getName()%></h1>
            <a href="MainController?action=Logout" 
               class="btn btn-outline-secondary btn-sm" 
               role="button" aria-pressed="true" 
               style="width: 80px; height: 35px; align-self: center; padding: 5px;">
                <i class="fas fa-sign-out-alt"></i> Log out
            </a>
        </div>

        <div style="padding: 0 15px">
            <form class="my-2 my-lg-0" action="MainController" method="POST">
                <div class="form-group">
                    <label for="searchUser">Search Users: </label>
                    <input class="form-control col-sm-12 col-lg-12" type="text" value="<%= search%>" name="search" id="searchUser"/>
                    <input class="btn btn-outline-success my-2 my-sm-0" type="submit" name="action" value="Search"/>
                </div>

            </form>
        </div>

        <%
            String message = (String) request.getAttribute("ERROR_MESSAGE");
            if (message == null) {
                message = "";
            }
        %>
        <p class="text-danger m-2"><%= message%></p>

        <%
            List<UserDTO> list = (List<UserDTO>) request.getAttribute("LIST_USER");
            if (list != null) {
        %>
        <table class="table table-striped m-2">
            <caption>List of users</caption>
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">User ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Address</th>
                    <th scope="col">Role ID</th>
                    <th scope="col">Password</th>
                    <th scope="col">Status</th>
                    <th scope="col">Delete</th>
                    <th scope="col">Update</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 0;
                    for (UserDTO user : list) {
                %>
                <tr>
                    <th scope="row"><%= ++count%></th>
                    <td><%= user.getUserID()%></td>
                    <td><%= user.getName()%></td>
                    <td><%= user.getAddress()%></td>
                    <td><%= user.getRoleID()%></td>
                    <td><%= user.getPassword()%></td>
                    <td><%= user.getStatus()%></td>
                    <td><a href="MainController?userID=<%= user.getUserID()%>&search=<%= search%>&action=Delete" class="btn btn-outline-danger">Delete</a></td>
                    <td>
                        <form action="MainController">
                            <input type="hidden" name="userID" value="<%= user.getUserID()%>"/>
                            <input type="hidden" name="name" value="<%= user.getName()%>"/>
                            <input type="hidden" name="roleID" value="<%= user.getRoleID()%>"/>
                            <input type="hidden" name="address" value="<%= user.getAddress()%>"/>
                            <input type="hidden" name="status" value="<%= user.getStatus()%>"/>
                            <input type="hidden" name="search" value="<%= search%>"/>
                            <input type="submit" class="btn btn-outline-success" name="action" value="Update"/>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            }
        %>

        <%-- Link Bootstrap 4 [JS] --%>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
