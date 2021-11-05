/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.books.BookDAO;
import sample.books.BookDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SearchBookController", urlPatterns = {"/SearchBookController"})
public class SearchBookController extends HttpServlet {

    private static final String ERROR = "user.jsp";
    private static final String SUCCESS = "user.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        HttpSession session = request.getSession();
        try {
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }

            List<BookDTO> list = BookDAO.getBooksList(search);
            List<BookDTO> listSE = BookDAO.getBooksListByCategory("SE");
            List<BookDTO> listKT = BookDAO.getBooksListByCategory("KT");
            List<BookDTO> listAI = BookDAO.getBooksListByCategory("AI");
            List<BookDTO> listNN = BookDAO.getBooksListByCategory("NN");
            List<BookDTO> listOrthers = BookDAO.getBooksListByCategory("Orthers");

            if (list != null) {
                session.setAttribute("BOOK_LIST", list);
                session.setAttribute("BOOK_LIST_SE", listSE);
                session.setAttribute("BOOK_LIST_KT", listKT);
                session.setAttribute("BOOK_LIST_AI", listAI);
                session.setAttribute("BOOK_LIST_NN", listNN);
                session.setAttribute("BOOK_LIST_Orthers", listOrthers);

                url = SUCCESS;
            }

        } catch (Exception e) {
            log("Error at SearchBookController: " + e.toString());
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
