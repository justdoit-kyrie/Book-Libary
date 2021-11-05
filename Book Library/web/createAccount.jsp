<%-- 
    Document   : createAccount
    Created on : Jun 16, 2021, 6:10:38 PM
    Author     : Admin
--%>

<%@page import="sample.users.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Account Page</title>

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
        </style>
    </head>
    <body>
        <%
            UserError userError = (UserError) request.getAttribute("USER_ERROR");
            if (userError == null) {
                userError = new UserError();
            }
        %>
        <form action="MainController" method="POST" style="margin: 10px 20px">
            <fieldset class="border p-3 border-dark">

                <legend class="scheduler-border">Create Account</legend>

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
                        placeholder="Enter UserID ... "
                        value="${param.userID}"
                        required=""/>
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
                        placeholder="Enter Name ... "
                        value="${param.name}"
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
                        placeholder="Enter RoleID ... "
                        value="${param.roleID}"
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
                        placeholder="Enter Address ... "
                        value="${param.address}"
                        required=""/>
                    <p class="text-warning col-lg-4" style="margin: 10px 0"><%= userError.getAddressError()%></p>
                </div>

                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroup-sizing-default">Password</span>
                    </div>
                    <input 
                        type="password" 
                        class="form-control col-lg-8" 
                        aria-label="Default" 
                        aria-describedby="inputGroup-sizing-default" 
                        name="password" 
                        placeholder="Enter Password ... "
                        value="${param.password}"
                        required=""/>
                    <p class="text-warning col-lg-4" style="margin: 10px 0"><%= userError.getPasswordError()%></p>
                </div>

                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroup-sizing-default">Confirm Password</span>
                    </div>
                    <input 
                        type="password" 
                        class="form-control col-lg-8" 
                        aria-label="Default" 
                        aria-describedby="inputGroup-sizing-default" 
                        name="confirm" 
                        placeholder="Enter confirm password ... "
                        value="${param.confirm}"
                        required=""/>
                    <p class="text-warning col-lg-4" style="margin: 10px 0"><%= userError.getConfirmPasswordError()%></p>
                </div>

                <input type="submit" class="btn btn-outline-success" name="action" value="Sign In"/>
            </fieldset>
        </form>

        <%-- Link Bootstrap 4 [JS] --%>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
