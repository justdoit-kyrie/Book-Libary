/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.books.BookDTO;
import sample.shopping.Cart;
import sample.users.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddToCartController", urlPatterns = {"/AddToCartController"})
public class AddToCartController extends HttpServlet {

    private static final String ERROR = "SearchBookController";
    private static final String SUCCESS = "SearchBookController";
    private static final String LOGIN = "login.html";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        HttpSession session = request.getSession();
        try {
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER_USER");
            UserDTO loginUserGoogle = (UserDTO) session.getAttribute("LOGIN_USER_GOOGLE");
            if (loginUser == null && loginUserGoogle == null) {
                url = LOGIN;
                return;
            }
            String bookID = request.getParameter("bookID");
            String name = request.getParameter("name");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            String image = request.getParameter("image");

            BookDTO book = new BookDTO(bookID, name, quantity, price, category, image);
            Cart cart = (Cart) session.getAttribute("CART");
            if (cart == null) {
                cart = new Cart();
            }

            // Lấy SL ban đầu để so sánh với SL trong giỏ hàng               
            List<BookDTO> booklist = (List<BookDTO>) session.getAttribute("BOOK_LIST");
            int defaultQuantity = 0;
            for (BookDTO bookDTO : booklist) {
                if (bookDTO.getBookID().equals(book.getBookID())) {
                    defaultQuantity = bookDTO.getQuantity();
                }
            }

            // trả về error_message nếu số lượng trong giỏ hàng đã lớn hơn số lượng ban đầu của sản phẩm
            if (!cart.getCart().isEmpty()) {
                if (cart.getCart().containsKey(book.getBookID())) {
                    int pastQuantity = cart.getCart().get(book.getBookID()).getQuantity();
                    if (pastQuantity + book.getQuantity() > defaultQuantity) {
                        request.setAttribute("ERROR_SHOPPING_MESSAGE", "Error: Quantity of '" + name + "' book Is larger " + book.getQuantity()
                                + " Please view quantity in shopping cart !");
                        return;
                    }
                }
            }

            cart.add(book);
            session.setAttribute("CART", cart);
            url = SUCCESS;
            String message = "Message: Ban vua chon " + quantity + " " + name + " book thanh cong roi !";
            request.setAttribute("SHOPPING_MESSAGE", message);

        } catch (Exception e) {
            log("Error at AddToCartController: " + e.toString());
            if(e.toString().contains("For input string: \"\"")){
                url = ERROR;
                request.setAttribute("ERROR_SHOPPING_MESSAGE", "Error: Lack of Quantity while Add To Cart !!");
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
