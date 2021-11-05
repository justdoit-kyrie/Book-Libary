<%-- 
    Document   : receipt
    Created on : Jun 24, 2021, 1:20:24 AM
    Author     : Admin
--%>

<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Payment Receipt</title>
        
        <%-- Link Bootstrap 4 [CSS] --%>
        <link 
            rel="stylesheet" 
            href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
            crossorigin="anonymous"/>
        
        <%-- Link Bootstrap 4 [JS] --%>
        <link 
            rel="stylesheet" 
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
            integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" 
            crossorigin="anonymous" 
            referrerpolicy="no-referrer" />

        <style type="text/css">
            table { border: 0; }
            table td { padding: 0 10px; }
            .showcase{
                padding:10px;
                margin: 5px;

            }

            .showcase button{
                border: none;
                background-color: transparent;
                transition: transform 0.5s ease-in-out;
            }

            .showcase button:hover{
                transform: translate(-10px);
                outline: none;
            }

            .showcase a{
                color: #333;
                text-decoration: none;
            }
        </style>
    </head>
    <body>

        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER_USER");
            UserDTO loginUserGoogle = (UserDTO) session.getAttribute("LOGIN_USER_GOOGLE");
            if ((loginUser == null || !"US".equals(loginUser.getRoleID())) && loginUserGoogle == null) {
                response.sendRedirect("login.html");
                return;
            }
        %>

        <div class="showcase">
            <button><a href="MainController?action=SearchBook&search=${search}"><i class="fas fa-arrow-left"></i> Back To Shopping View</a></button>
        </div>
        <div align="center">
            <h1 class="text-success">Payment Done. Thank you for purchasing our products</h1>
            <br/>
            <h2>Receipt Details:</h2>
            <table>
                <tr>
                    <td><b>Merchant:</b></td>
                    <td>Company ABC Ltd.</td>
                </tr>
                <tr>
                    <td><b>Payer:</b></td>
                    <td>${payer.firstName} ${payer.lastName}</td>      
                </tr>
                <tr>
                    <td><b>Description:</b></td>
                    <td>${transaction.description}</td>
                </tr>
                <tr>
                    <td><b>Total:</b></td>
                    <td>${transaction.amount.total} USD</td>
                </tr>                    
            </table>
        </div>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
