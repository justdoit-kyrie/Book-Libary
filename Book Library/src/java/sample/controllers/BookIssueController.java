/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.books.BookDAO;
import sample.books.BookDTO;
import sample.orderDetail.OrderDetailDTO;
import sample.orders.OrderDAO;
import sample.orders.OrderDTO;
import sample.shopping.Cart;
import sample.users.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BookIssueController", urlPatterns = {"/BookIssueController"})
public class BookIssueController extends HttpServlet {

    private static final String ERROR = "viewCart.jsp";
    private static final String SUCCESS = "RemoveCartController";
    private static final String PAYPAL = "AuthorizePaymentController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        HttpSession session = request.getSession();
        try {
            boolean check = false;
            SimpleDateFormat dt = new SimpleDateFormat("MM/dd/yyyy");
            Date now = new Date();
            double total = Double.parseDouble(request.getParameter("total"));
            Cart cart = (Cart) session.getAttribute("CART");
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER_USER");
            UserDTO loginUserGoogle = (UserDTO) session.getAttribute("LOGIN_USER_GOOGLE");
            String userID = "";

            // Phân chia 2 TH đăng nhập bằng user vs Google Account            
            if (loginUser != null && loginUserGoogle == null) {
                userID = loginUser.getUserID();
            } else {
                userID = loginUserGoogle.getUserID();
            }
            
            String payment = request.getParameter("payment");
            if(payment.equals("Paypal")){
                String search = request.getParameter("search");
                session.setAttribute("SEARCH", search);
                url = PAYPAL;
                return;
            }else if(payment.contains("Open")){
                request.setAttribute("ERROR_PAYMENT_MESSAGE", "Select a payment method !");
            }
                    

            if (OrderDAO.insertIntoTblorder(new OrderDTO(userID, dt.format(now), total, payment , "active"))) {

                // Lấy orderID từ trong database                    
                String orderID = OrderDAO.getOrderID(userID, dt.format(now), total, payment, "active");
                for (BookDTO book : cart.getCart().values()) {
                    String bookID = book.getBookID();
                    int quantity = book.getQuantity();
                    int oldQuantity = BookDAO.getQuantity(bookID);
                    double price = book.getPrice();
                    if (OrderDAO.insertIntoTblorderDetail(new OrderDetailDTO(orderID, bookID, quantity, price)) && OrderDAO.updateProduct(bookID,oldQuantity - quantity)) {
                        check = true;
                    }
                }
            }

            if (check) {
                String email = request.getParameter("useremail");
                OrderDAO.sendToEmail(email, cart, total);
                request.setAttribute("SUCCESS_INSERT_MESSAGE", "Bạn đã Order thành công !");
                url = SUCCESS;
            } else {
                request.setAttribute("ERROR_INSERT_MESSAGE", "Bạn đã Order không thành công !");
            }
        } catch (Exception e) {
            log("Error at BookIssueController: " + e.toString());
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
