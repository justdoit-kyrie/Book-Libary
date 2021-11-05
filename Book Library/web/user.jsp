<%-- 
    Document   : user
    Created on : Jun 15, 2021, 7:45:33 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sample.books.BookDTO"%>
<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>

        <%-- Link Bootstrap 4 [CSS] --%>
        <link 
            rel="stylesheet" 
            href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
            crossorigin="anonymous"/>

        <%-- Link FontAwesome --%>
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

            .icon{
                width: 50px;
                margin: 0;
                padding: 0;
            }

            .icon button{
                padding: 0;
                margin: 0;
                border: none;
                height: 50px;
                background-color: transparent;
                transition: transform 2s;
                font-size: 20px;
                width: 50px;
            }

            button:hover{
                transform: rotate(360deg);
            }

            img{
                height: 400px;
            }

            .showcase{
                display: inline-block;
                margin: 10px 80px;
            }

            .card{
                box-shadow: 0 0 30px 0 rgba(0, 0, 0, 0.2);
            }




        </style>
    </head>
    <body style="overflow-x: hidden">
        <%
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
        %>

        <nav class="navbar navbar-dark bg-dark justify-content-between" style="color: #fff;">
            <a class="navbar-brand" style="font-size: 30px; cursor: pointer" href="MainController?action=SearchBook&search=">Loruki</a>
            <div class="flex">

                <div class="icon">
                    <button>
                        <a href="MainController?action=ViewCart&search=<%= search%>">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-cart4" viewBox="0 0 16 16" style="color: #fff">
                            <path d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5zM3.14 5l.5 2H5V5H3.14zM6 5v2h2V5H6zm3 0v2h2V5H9zm3 0v2h1.36l.5-2H12zm1.11 3H12v2h.61l.5-2zM11 8H9v2h2V8zM8 8H6v2h2V8zM5 8H3.89l.5 2H5V8zm0 5a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0zm9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0z"/>
                            </svg>
                        </a>
                    </button>
                </div>

                <%-- Đã Đăng Nhập --%>
                <c:if test="${sessionScope.LOGIN_USER_USER != NULL || sessionScope.LOGIN_USER_GOOGLE != NULL}">
                    <li class="nav-item dropdown" style="list-style: none; margin: 5px 0;">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #fff">
                            <i class="far fa-user" style="color: #fff"></i>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="MainController?action=Logout" style="padding: 4px 20px">Log out</a>
                        </div>
                    </li>
                </c:if>

                <%-- Chưa Đăng Nhập --%>
                <c:if test="${sessionScope.LOGIN_USER_USER == NULL && sessionScope.LOGIN_USER_GOOGLE == NULL}">
                    <a href="login.html" 
                       class="btn btn-outline-light btn-sm" 
                       role="button" aria-pressed="true" 
                       style="width: 80px; height: 35px; align-self: center; padding: 5px;">
                        <i class="fas fa-sign-in-alt"></i> Sign Up
                    </a>
                </c:if>

            </div>
        </nav>

        <%-- Đăng Nhập sẽ hiện name --%>
        <c:if test="${sessionScope.LOGIN_USER_USER != null || sessionScope.LOGIN_USER_GOOGLE != null}">
            <h1 style="margin: 0 12px">Hello User: ${sessionScope.LOGIN_USER_USER.name} ${sessionScope.LOGIN_USER_GOOGLE.name}</h1>
        </c:if>

        <div style="margin: 30px 12px;">
            <form class="my-4 my-lg-0" action="MainController" method="POST" id="searchBooks">
                <label for="searchBook">Search Books: </label>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="basic-addon1">Book Name</span>
                    </div>
                    <input type="text" class="form-control" name="search" value="<%= search%>">
                </div>

                <div id="submit_button"><button class="btn btn-outline-success my-2 my-sm-0" type="submit" name="action" value="SearchBook">Search</button></div>
            </form>
        </div>

        <%-- Auto show all of book --%>
        <c:if test="${sessionScope.BOOK_LIST == null}">
            <c:redirect url="SearchBookController">
                <c:param name="search" value=""></c:param>
            </c:redirect>
        </c:if>

        <%
            String message = (String) request.getAttribute("SHOPPING_MESSAGE");
            String error_message = (String) request.getAttribute("ERROR_SHOPPING_MESSAGE");
            if (message == null) {
                message = "";
            }
            if (error_message == null) {
                error_message = "";
            }

            List<BookDTO> bookList = (List<BookDTO>) session.getAttribute("BOOK_LIST");
            if (bookList != null) {

        %>
        <p class="text-success m-2"><%= message%></p>
        <p class="text-danger m-2"><%=error_message%></p>
        <ul class="nav nav-tabs" id="myTab" role="tablist" style="margin: 0 15px;">
            <li class="nav-item">
                <a class="nav-link active" id="ALL-tab" data-toggle="tab" href="#ALL" role="tab" aria-controls="ALL" aria-selected="true">All Book</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="SE-tab" data-toggle="tab" href="#SE" role="tab" aria-controls="SE" aria-selected="false">Software Engineering</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="KT-tab" data-toggle="tab" href="#KT" role="tab" aria-controls="KT" aria-selected="false">Economy</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="AI-tab" data-toggle="tab" href="#AI" role="tab" aria-controls="AI" aria-selected="false">Artificial Intelligence</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="NN-tab" data-toggle="tab" href="#NN" role="tab" aria-controls="NN" aria-selected="false">Language Book</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="Orthers-tab" data-toggle="tab" href="#Orthers" role="tab" aria-controls="Orthers" aria-selected="false">Orthers</a>
            </li>
        </ul>
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="ALL" role="tabpanel" aria-labelledby="ALL-tab">

                <%
                    for (BookDTO book : bookList) {
                %>
                <div class="showcase flex">
                    <form action="MainController" method="POST">
                        <div class="card" style="width: 18rem; margin: 10px auto">
                            <img class="card-img-top" src="<%= book.getImage()%>" alt="Card image cap">
                            <div class="card-body">
                                <h5 class="card-title"><%= book.getName()%></h5>
                                <p class="card-text">Available <%= book.getQuantity()%> Quantity</p>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">$</span>
                                    </div>
                                    <input type="text" class="form-control" value="<%= book.getPrice()%>" readonly="">
                                </div>
                                <input type="number" class="form-control" name="quantity" placeholder="Enter Quantity ..." max="<%= book.getQuantity()%>" style="margin-bottom: 10px">
                                <button type="submit" class="btn btn-primary" name="action" value="AddToCart">Add to Cart</button>
                            </div>
                        </div>

                        <input type="hidden" name="bookID" value="<%= book.getBookID()%>" />
                        <input type="hidden" name="price" value="<%= book.getPrice()%>" />
                        <input type="hidden" name="name" value="<%= book.getName()%>"/>
                        <input type="hidden" name="category" value="<%= book.getCategory()%>"/>
                        <input type="hidden" name="image" value="<%= book.getImage()%>"/>
                        <input type="hidden" name="search" value="<%= search%>"/>
                    </form>
                </div>
                <%
                    }
                %>

            </div>
            <div class="tab-pane fade" id="SE" role="tabpanel" aria-labelledby="SE-tab">
                <%
                    List<BookDTO> list_se = (List<BookDTO>) session.getAttribute("BOOK_LIST_SE");
                    for (BookDTO book : list_se) {
                %>
                <div class="showcase flex">
                    <form action="MainController" method="POST">
                        <div class="card" style="width: 18rem; margin: 10px auto">
                            <img class="card-img-top" src="<%= book.getImage()%>" alt="Card image cap">
                            <div class="card-body">
                                <h5 class="card-title"><%= book.getName()%></h5>
                                <p class="card-text">Available <%= book.getQuantity()%> Quantity</p>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">$</span>
                                    </div>
                                    <input type="text" class="form-control" value="<%= book.getPrice()%>" readonly="">
                                </div>
                                <input type="number" class="form-control" name="quantity" placeholder="Enter Quantity ..." max="<%= book.getQuantity()%>" style="margin-bottom: 10px">
                                <button type="submit" class="btn btn-primary" name="action" value="AddToCart">Add to Cart</button>
                            </div>
                        </div>

                        <input type="hidden" name="bookID" value="<%= book.getBookID()%>" />
                        <input type="hidden" name="price" value="<%= book.getPrice()%>" />
                        <input type="hidden" name="name" value="<%= book.getName()%>"/>
                        <input type="hidden" name="category" value="<%= book.getCategory()%>"/>
                        <input type="hidden" name="image" value="<%= book.getImage()%>"/>
                        <input type="hidden" name="search" value="<%= search%>"/>
                    </form>
                </div>
                <%
                    }
                %>
            </div>
            <div class="tab-pane fade" id="KT" role="tabpanel" aria-labelledby="KT-tab">
                <%
                    List<BookDTO> list_kt = (List<BookDTO>) session.getAttribute("BOOK_LIST_KT");
                    for (BookDTO book : list_kt) {
                %>
                <div class="showcase flex">
                    <form action="MainController" method="POST">
                        <div class="card" style="width: 18rem; margin: 10px auto">
                            <img class="card-img-top" src="<%= book.getImage()%>" alt="Card image cap">
                            <div class="card-body">
                                <h5 class="card-title"><%= book.getName()%></h5>
                                <p class="card-text">Available <%= book.getQuantity()%> Quantity</p>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">$</span>
                                    </div>
                                    <input type="text" class="form-control" value="<%= book.getPrice()%>" readonly="">
                                </div>
                                <input type="number" class="form-control" name="quantity" placeholder="Enter Quantity ..." max="<%= book.getQuantity()%>" style="margin-bottom: 10px">
                                <button type="submit" class="btn btn-primary" name="action" value="AddToCart">Add to Cart</button>
                            </div>
                        </div>

                        <input type="hidden" name="bookID" value="<%= book.getBookID()%>" />
                        <input type="hidden" name="price" value="<%= book.getPrice()%>" />
                        <input type="hidden" name="name" value="<%= book.getName()%>"/>
                        <input type="hidden" name="category" value="<%= book.getCategory()%>"/>
                        <input type="hidden" name="image" value="<%= book.getImage()%>"/>
                        <input type="hidden" name="search" value="<%= search%>"/>
                    </form>
                </div>
                <%
                    }
                %>
            </div>

            <div class="tab-pane fade" id="AI" role="tabpanel" aria-labelledby="AI-tab">
                <%
                    List<BookDTO> list_ai = (List<BookDTO>) session.getAttribute("BOOK_LIST_AI");
                    for (BookDTO book : list_ai) {
                %>
                <div class="showcase flex">
                    <form action="MainController" method="POST">
                        <div class="card" style="width: 18rem; margin: 10px auto">
                            <img class="card-img-top" src="<%= book.getImage()%>" alt="Card image cap">
                            <div class="card-body">
                                <h5 class="card-title"><%= book.getName()%></h5>
                                <p class="card-text">Available <%= book.getQuantity()%> Quantity</p>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">$</span>
                                    </div>
                                    <input type="text" class="form-control" value="<%= book.getPrice()%>" readonly="">
                                </div>
                                <input type="number" class="form-control" name="quantity" placeholder="Enter Quantity ..." max="<%= book.getQuantity()%>" style="margin-bottom: 10px">
                                <button type="submit" class="btn btn-primary" name="action" value="AddToCart">Add to Cart</button>
                            </div>
                        </div>

                        <input type="hidden" name="bookID" value="<%= book.getBookID()%>" />
                        <input type="hidden" name="price" value="<%= book.getPrice()%>" />
                        <input type="hidden" name="name" value="<%= book.getName()%>"/>
                        <input type="hidden" name="category" value="<%= book.getCategory()%>"/>
                        <input type="hidden" name="image" value="<%= book.getImage()%>"/>
                        <input type="hidden" name="search" value="<%= search%>"/>
                    </form>
                </div>
                <%
                    }
                %>
            </div>

            <div class="tab-pane fade" id="NN" role="tabpanel" aria-labelledby="NN-tab">
                <%
                    List<BookDTO> list_nn = (List<BookDTO>) session.getAttribute("BOOK_LIST_NN");
                    for (BookDTO book : list_nn) {
                %>
                <div class="showcase flex">
                    <form action="MainController" method="POST">
                        <div class="card" style="width: 18rem; margin: 10px auto">
                            <img class="card-img-top" src="<%= book.getImage()%>" alt="Card image cap">
                            <div class="card-body">
                                <h5 class="card-title"><%= book.getName()%></h5>
                                <p class="card-text">Available <%= book.getQuantity()%> Quantity</p>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">$</span>
                                    </div>
                                    <input type="text" class="form-control" value="<%= book.getPrice()%>" readonly="">
                                </div>
                                <input type="number" class="form-control" name="quantity" placeholder="Enter Quantity ..." max="<%= book.getQuantity()%>" style="margin-bottom: 10px">
                                <button type="submit" class="btn btn-primary" name="action" value="AddToCart">Add to Cart</button>
                            </div>
                        </div>

                        <input type="hidden" name="bookID" value="<%= book.getBookID()%>" />
                        <input type="hidden" name="price" value="<%= book.getPrice()%>" />
                        <input type="hidden" name="name" value="<%= book.getName()%>"/>
                        <input type="hidden" name="category" value="<%= book.getCategory()%>"/>
                        <input type="hidden" name="image" value="<%= book.getImage()%>"/>
                        <input type="hidden" name="search" value="<%= search%>"/>
                    </form>
                </div>
                <%
                    }
                %>
            </div>

            <div class="tab-pane fade" id="Orthers" role="tabpanel" aria-labelledby="Orthers-tab">
                <%
                    List<BookDTO> list_orthers = (List<BookDTO>) session.getAttribute("BOOK_LIST_Orthers");
                    for (BookDTO book : list_orthers) {
                %>
                <div class="showcase flex">
                    <form action="MainController" method="POST">
                        <div class="card" style="width: 18rem; margin: 10px auto">
                            <img class="card-img-top" src="<%= book.getImage()%>" alt="Card image cap">
                            <div class="card-body">
                                <h5 class="card-title"><%= book.getName()%></h5>
                                <p class="card-text">Available <%= book.getQuantity()%> Quantity</p>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">$</span>
                                    </div>
                                    <input type="text" class="form-control" value="<%= book.getPrice()%>" readonly="">
                                </div>
                                <input type="number" class="form-control" name="quantity" placeholder="Enter Quantity ..." max="<%= book.getQuantity()%>" style="margin-bottom: 10px">
                                <button type="submit" class="btn btn-primary" name="action" value="AddToCart">Add to Cart</button>
                            </div>
                        </div>

                        <input type="hidden" name="bookID" value="<%= book.getBookID()%>" />
                        <input type="hidden" name="price" value="<%= book.getPrice()%>" />
                        <input type="hidden" name="name" value="<%= book.getName()%>"/>
                        <input type="hidden" name="category" value="<%= book.getCategory()%>"/>
                        <input type="hidden" name="image" value="<%= book.getImage()%>"/>
                        <input type="hidden" name="search" value="<%= search%>"/>
                    </form>
                </div>
                <%
                    }
                %>
            </div>

        </div>   

        <%
            }
        %>

        <%-- Link Bootstrap 4 [JS] --%>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
