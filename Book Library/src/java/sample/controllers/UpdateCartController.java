/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.books.BookDTO;
import sample.shopping.Cart;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateCartController", urlPatterns = {"/UpdateCartController"})
public class UpdateCartController extends HttpServlet {

    private static final String ERROR = "viewCart.jsp";
    private static final String SUCCESS = "viewCart.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        HttpSession session = request.getSession();
        try {
            boolean check = true;
            String id = request.getParameter("id");
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));
            int oldQuantity = Integer.parseInt(request.getParameter("oldQuantity"));
            Cart cart = (Cart) session.getAttribute("CART");
            BookDTO book = null;
            for (BookDTO dto : cart.getCart().values()) {
                if (dto.getBookID().equals(id)) {
                    check = true;
                    String name = dto.getName();
                    if (newQuantity > oldQuantity) {
                        check = false;
                        break;
                    }
                    book = new BookDTO(id, name, newQuantity, dto.getPrice(), dto.getCategory(), dto.getImage());
                    break;
                }
            }
            if (check) {
                cart.update(id, book);
                session.setAttribute("CART", cart);
                request.setAttribute("ERROR_MESSAGE_CART", "");
                url = SUCCESS;
            }else{
                request.setAttribute("ERROR_MESSAGE_CART", "New Quantity is larger "+oldQuantity);
            }

        } catch (Exception e) {
            log("Error at UpdateCartController: " + e.toString());
            if (e.toString().contains("For input string: \"\"")) {
                request.setAttribute("ERROR_MESSAGE_CART", "Lack of Quantity while modify Quantity of book");
                url = ERROR;
            }
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
