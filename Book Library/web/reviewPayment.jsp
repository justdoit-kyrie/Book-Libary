<%-- 
    Document   : reviewPayment
    Created on : Jun 24, 2021, 12:50:59 AM
    Author     : Admin
--%>

<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.paypal.api.payments.Transaction"%>
<%@page import="com.paypal.api.payments.Item"%>
<%@page import="java.util.List"%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Review</title>

        <%-- Link Bootstrap 4 [CSS] --%>
        <link 
            rel="stylesheet" 
            href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
            crossorigin="anonymous"/>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Jomhuria&display=swap" rel="stylesheet">
        <style>
            table { border: 0; background-color: #adc8d1;}
            table td { padding:5px 12px; color: #333; font-size: .75rem;}
            .btn{color: #333;}
            .header-table{
                background-color: #adc8d1;
                width: 325px;
                padding: 10px 0;
                text-align: center;
                font-size: 2rem;
                font-family: 'Jomhuria';
            }
            body{
                display: flex;
                justify-content: center;
                background-color: #fff;
            }
            .card{
                display: flex;
                justify-content: center;
                background-color: #fff;
                border: none;
                margin: 10px 0;
            }

            .color{
                margin: 10px 0 0;
                background-color: #737e82;
                height: 5px;
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
        <div class="card">
            <div class="color"></div>
            <div class="header-table">Review Before Paying</div>
            <form action="MainController" method="post">
                <table>
                    <tr>
                        <td colspan="2" style=" font-weight: 700;"><b>Transaction Details:</b></td>
                        <td>
                            <input type="hidden" name="paymentId" value="${param.paymentId}" />
                            <input type="hidden" name="PayerID" value="${param.PayerID}" />
                        </td>
                    </tr>
                    <%
                        Transaction transaction = (Transaction) request.getAttribute("transaction");
                        List<Item> tmp = transaction.getItemList().getItems();
                        if (tmp != null) {
                            for (Item item : tmp) {
                    %>
                    <tr>
                        <td>Name</td>
                        <td><%= item.getName()%></td>
                    </tr>
                    <tr>
                        <td>Quantity</td>
                        <td><%= item.getQuantity()%></td>
                    </tr>
                    <tr>
                        <td>Price</td>
                        <td><%= item.getPrice()%></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    <tr>
                        <td>Shipping fee</td>
                        <td><%= transaction.getAmount().getDetails().getShipping() %></td>
                    </tr>
                    <tr>
                        <td>Total:</td>
                        <td>${transaction.amount.total} USD</td>
                    </tr>
                    <tr><td><br/></td></tr>
                    <tr>
                        <td colspan="2" style=" font-weight: 700;"><b>Payer Information:</b></td>
                    </tr>
                    <tr>
                        <td>First Name:</td>
                        <td>${payer.firstName}</td>
                    </tr>
                    <tr>
                        <td>Last Name:</td>
                        <td>${payer.lastName}</td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td>${payer.email}</td>
                    </tr>
                    <tr><td><br/></td></tr>
                    <tr>
                        <td colspan="2" style=" font-weight: 700;"><b>Shipping Address:</b></td>
                    </tr>
                    <tr>
                        <td>Recipient Name:</td>
                        <td>${shippingAddress.recipientName}</td>
                    </tr>
                    <tr>
                        <td>Line 1:</td>
                        <td>${shippingAddress.line1}</td>
                    </tr>
                    <tr>
                        <td>City:</td>
                        <td>${shippingAddress.city}</td>
                    </tr>
                    <tr>
                        <td>State:</td>
                        <td>${shippingAddress.state}</td>
                    </tr>
                    <tr>
                        <td>Country Code:</td>
                        <td>${shippingAddress.countryCode}</td>
                    </tr>
                    <tr>
                        <td>Postal Code:</td>
                        <td>${shippingAddress.postalCode}</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" class="btn btn-outline-danger btn-block" id="pay" name="action" value="Pay Now" style="margin:10px; border-radius: 30px;"/>
                        </td>
                    </tr>    
                </table>
            </form>
        </div>

        <%-- Link Bootstrap 4 [JS] --%>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
