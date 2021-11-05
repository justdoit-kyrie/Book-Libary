/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class MainController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String LOGIN = "LoginController";
    private static final String SEARCH = "SearchController";
    private static final String DELETE = "DeleteController";
    private static final String UPDATE = "update.jsp";
    private static final String CONFRIM_UPDATE = "UpdateController";
    private static final String LOGOUT = "LogoutController";
    private static final String CREATE = "CreateController";
    private static final String SEARCH_BOOK = "SearchBookController";
    private static final String ADD_TO_CART = "AddToCartController";
    private static final String VIEW_CART = "viewCart.jsp";
    private static final String REMOVE_CART = "RemoveCartController";
    private static final String UPDATE_CART = "UpdateCartController";
    private static final String ORDER_BOOKS = "BookIssueController";
    private static final String RECEIPT_ORDER = "ExecutePaymentController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String action = request.getParameter("action");
            switch (action) {
                case "Sign Up": {
                    url = LOGIN;
                    break;
                }
                case "Search": {
                    url = SEARCH;
                    break;
                }
                case "Delete": {
                    url = DELETE;
                    break;
                }
                case "Update": {
                    url = UPDATE;
                    break;
                }
                case "Confirm Update": {
                    url = CONFRIM_UPDATE;
                    break;
                }
                case "Logout": {
                    url = LOGOUT;
                    break;
                }
                case "Sign In": {
                    url = CREATE;
                    break;
                }
                case "SearchBook": {
                    url = SEARCH_BOOK;
                    break;
                }
                case "AddToCart": {
                    url = ADD_TO_CART;
                    break;
                }
                case "ViewCart": {
                    url = VIEW_CART;
                    break;
                }case "removeCart": {
                    url = REMOVE_CART;
                    break;
                }case "Modify": {
                    url = UPDATE_CART;
                    break;
                }case "BookIssue": {
                    url = ORDER_BOOKS;
                    break;
                }case "Pay Now": {
                    url = RECEIPT_ORDER;
                    break;
                }
                default: {
                    HttpSession session = request.getSession();
                    session.setAttribute("ERROR_MESSAGE", "Your Function is not available !");
                    break;
                }
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
