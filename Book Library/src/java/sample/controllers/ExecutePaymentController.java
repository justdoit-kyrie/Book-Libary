/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
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
import sample.paypalPayment.PaymentServices;
import sample.shopping.Cart;
import sample.users.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ExecutePaymentController", urlPatterns = {"/ExecutePaymentController"})
public class ExecutePaymentController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "receipt.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String paymentId = request.getParameter("paymentId");
            String payerId = request.getParameter("PayerID");

            PaymentServices paymentServices = new PaymentServices();
            Payment payment = paymentServices.executePayment(paymentId, payerId);

            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);

            request.setAttribute("payer", payerInfo);
            request.setAttribute("transaction", transaction);

            // Send To User/Payer Email            
            HttpSession session = request.getSession();
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

            SimpleDateFormat dt = new SimpleDateFormat("MM/dd/yyyy");
            Date now = new Date();
            double total = Double.parseDouble((String) session.getAttribute("TOTAL"));
            boolean check = false;
            if (OrderDAO.insertIntoTblorder(new OrderDTO(userID, dt.format(now), total, "PayPal", "active"))) {

                // Lấy orderID từ trong database                    
                String orderID = OrderDAO.getOrderID(userID, dt.format(now), total,"PayPal", "active");
                for (BookDTO book : cart.getCart().values()) {
                    check = false;
                    String bookID = book.getBookID();
                    int quantity = book.getQuantity();
                    int oldQuantity = BookDAO.getQuantity(bookID);
                    double price = book.getPrice();
                    if (OrderDAO.insertIntoTblorderDetail(new OrderDetailDTO(orderID, bookID, quantity, price)) && OrderDAO.updateProduct(bookID, oldQuantity - quantity)) {
                        check = true;
                    }
                }
            }

            if (check) {
                String email = payerInfo.getEmail();
                OrderDAO.sendToEmail(email, cart, total);
                cart.deleteALL();
                session.setAttribute("CART", cart);
                url = SUCCESS;
            }

        } catch (PayPalRESTException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ExecutePaymentController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ExecutePaymentController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
