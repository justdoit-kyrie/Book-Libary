<%-- 
    Document   : viewCart
    Created on : Jun 18, 2021, 1:40:56 AM
    Author     : Admin
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="sample.books.BookDAO"%>
<%@page import="sample.users.UserDTO"%>
<%@page import="sample.books.BookDTO"%>
<%@page import="sample.shopping.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart</title>
        
        <%-- BootStrap 4 [CSS] --%>
        <link 
            rel="stylesheet" 
            href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
            crossorigin="anonymous"/>
        
        <%-- BootStrap 5 [CSS] --%>
        <link 
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
            rel="stylesheet" 
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
            crossorigin="anonymous">
        
        <%-- Link fontAwesome --%>
        <link 
            rel="stylesheet" 
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
            integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" 
            crossorigin="anonymous" 
            referrerpolicy="no-referrer" />
        <style>
            .container{
                display: flex;
                justify-content: center;
                padding: 40px;
            }
            .card {
                border-radius: 10px;
                -webkit-box-shadow: 0 0 30px 0 rgba(0, 0, 0, 0.2);
                box-shadow: 0 0 30px 0 rgba(0, 0, 0, 0.2);
                border: none;
                -webkit-transition: all .3s ease-in-out;
                transition: all .3s ease-in-out;
                background-color: #fff;
                overflow: hidden;
                padding: 20px 45px 0 30px;
            }

            .showcase{
                padding:10px;
                margin: 5px;
            }

            .showcase button,
            .flex button{
                border: none;
                background-color: transparent;
                transition: transform 0.5s ease-in-out;
            }

            .showcase button:hover,
            .flex button:hover{
                transform: translate(-10px);
                outline: none;
            }

            .showcase a,
            .flex a{
                color: #333;
                text-decoration: none;
            }

            .showcase a:hover {
                text-decoration: none;
                color: #333;
            }

            .showcase p{
                font-size: 28px;
            }

            .table{
                margin: 30px 0;
            }

            #nav-home-tab{
                color: #333;
                box-shadow: 0 0 1px 0 rgba(0, 0, 0, 0.2);
            }

            .button{
                padding: 8px 0;
                border: none;
                margin: 0;
                width: 50px;
                background-color: transparent; 
            }

            .icon:hover{
                color: red;
                cursor: pointer;
            }

            #action{
                border-radius: 30px;
                margin: 30px 0;
                font-family: 'tahoma',sans-serif;
                font-weight: 600;
                transition: margin 1s, transform 1s;
            }

            #action:hover{
                margin: 30px 0;
                transform: translateY(-10px);
            }

            .flex{
                padding: 5px 10px;
            }

            h1{
                padding: 0 10px;
            }
            
            table td{width: 100px}
            
            img{max-width: 50px;}

        </style>
    </head>
    <body>
        <%
            UserDTO loginUserGoogle = (UserDTO) session.getAttribute("LOGIN_USER_GOOGLE");
            String id = "";
            String email = "";

            // chưa đăng nhập            
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER_USER");
            if ((loginUser == null || !"US".equals(loginUser.getRoleID())) && loginUserGoogle == null) {
                response.sendRedirect("login.html");
                return;

                // Đăng nhập bằng Google Account
            } else if ((loginUser == null || !"US".equals(loginUser.getRoleID())) && loginUserGoogle != null) {
                loginUser = new UserDTO();
                id = loginUserGoogle.getUserID();
                email = loginUserGoogle.getName();

            }

            String search = request.getParameter("search");

            String sucessMessage = (String) request.getAttribute("SUCCESS_INSERT_MESSAGE");
            String errorMessage = (String) request.getAttribute("ERROR_INSERT_MESSAGE");
            if (sucessMessage == null) {
                sucessMessage = "";
            }
            if (errorMessage == null) {
                errorMessage = "";
            }

            Cart cart = (Cart) session.getAttribute("CART");

            if (cart == null || cart.getCart().isEmpty()) {
                if (sucessMessage.equals("") && sucessMessage.equals("")) {
        %>

        <div class="showcase">
            <button><a href="MainController?action=SearchBook&search=<%= search%>"><i class="fas fa-arrow-left"></i> Back To Shopping View</a></button>
            <p class="text-danger m-2">Ban chua co chon san pham nao !</p>
        </div>

        <%
        } else {
        %>

        <div class="showcase">
            <button><a href="MainController?action=SearchBook&search=<%= search%>"><i class="fas fa-arrow-left"></i> Back To Shopping View</a></button>
            <p class="text-success"><%= sucessMessage%></p>
            <p class="text-danger"><%= errorMessage%></p>
        </div>

        <%
            }
        %>


        <%
        } else {
        %>
        <div class="flex">
            <button><a href="SearchBookController?search=<%= search%>"><i class="fas fa-arrow-left"></i> Back To Shopping View</a></button>
        </div>
        <h1>Hello User: <%= loginUser.getName()%> <%= email%></h1>
        <div class="container">
            <div class="card">
                <nav>
                    <div class="nav nav-tabs" id="nav-tab" role="tablist">
                        <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Shopping Cart</a>
                    </div>
                </nav>
                <div class="tab-content" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                        <%
                            String error_message_cart = (String) request.getAttribute("ERROR_MESSAGE_CART");
                            if (error_message_cart == null) {
                                error_message_cart = "";
                            }
                        %>

                        <p class="text-danger"><%= error_message_cart%></p>
                        <table class="table table-striped my-8 p-2">
                            <thead>
                                <tr style="text-align: center">
                                    <th>NO</th>
                                    <th>Image</th>
                                    <th>Book ID</th>
                                    <th>Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>#</th>
                                    <th>#</th>
                                </tr>
                            </thead>
                            <tbody>

                                <%
                                    int count = 0;
                                    String bookId = "";
                                    double total = 0;
                                    for (BookDTO book : cart.getCart().values()) {
                                        bookId = book.getBookID();
                                        total += book.getQuantity() * book.getPrice();
                                %>

                            <form action="MainController" method="POST">
                                <tr style="text-align: center">
                                    <td><%= ++count%></td>
                                    <td><img src="<%= book.getImage()%>" alt="<%= book.getName()%> Picture"/></td>
                                    <td>
                                        <input type="text" name="id" value="<%= bookId%>" readonly="" style="border: none; background-color: transparent; text-align: center; outline: none "/>
                                    </td>
                                    <td><%= book.getName()%></td>
                                    <td>
                                        <%= book.getQuantity()%>
                                    </td>
                                    <td><%= String.format("%.2f", book.getPrice()) %></td>
                                    <td style="width: 200px">
                                        <div class="input-group" >
                                            <input type="number" class="form-control" placeholder="Quantity ... " name="quantity" min="0" style=" width: 120px ;">
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="submit" name="action" value="Modify" style="border: none"><i class="fas fa-edit"></i></button>
                                            </div>
                                            <input type="hidden" name="oldQuantity" value="<%= BookDAO.getQuantity(bookId)%>"/>
                                            <input type="hidden" name="search" value="<%= search%>"/>
                                        </div>
                                    </td>
                                    <td>
                                        <button class="button" type="submit" name="action" value="removeCart"><i class="far fa-trash-alt icon" style="opacity: 0.75"></i></button>
                                    </td>
                                </tr>
                            </form>

                            <%
                                }
                            %>

                            </tbody>
                        </table>

                        <form action="MainController" method="POST">
                            <label for="Amount (to the nearest dollar)">Total</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">$</span>
                                </div>
                                <input type="text" class="form-control" aria-label="Amount (to the nearest dollar)" name="total" value="<%= String.format("%.0f", total) %>"readonly="" >
                                <div class="input-group-append">
                                    <span class="input-group-text">.00</span>
                                </div>
                            </div>

                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="inputGroup-sizing-default">Email</span>
                                </div>
                                <input type="email" class="form-control" name="useremail" required=""/>
                                <input type="hidden" name="search" value="<%= search%>"/>
                            </div>

                            <label for="payment">Choose a Payment:</label>
                            <p class="text-danger">${requestScope.ERROR_PAYMENT_MESSAGE}</p>
                            <select class="form-select" aria-label="Default select example" name="payment" id="payment">
                                <option selected>Open this select menu</option>
                                <option value="Paypal">Paypal</option>
                                <option value="COD">COD</option>
                            </select>
                            <input type="hidden" name="search" value="<%= search %>"/>
                            <button type="submit" class="btn btn-outline-success btn-lg btn-block" id="action" name="action" value="BookIssue">Order</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%
            }
        %>
        
        <%-- BootStrap 4 [JS] --%>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        
        <%-- BootStrap 5 [JS] --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>
