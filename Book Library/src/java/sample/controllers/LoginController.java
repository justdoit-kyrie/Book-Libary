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
import sample.reCaptcha.VerifyUtils;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String ADMIN_PAGE = "SearchController";
    private static final String USER_PAGE = "SearchBookController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        HttpSession session = request.getSession();
        try {
            String userID = request.getParameter("userID");
            String password = request.getParameter("password");
            UserDTO loginUser = UserDAO.checkLogin(userID, password);
            if (loginUser != null) {
                String roleID = loginUser.getRoleID();
                if ("AD".compareToIgnoreCase(roleID) == 0) {
                    session.setAttribute("LOGIN_USER_ADMIN", loginUser);
                    url = ADMIN_PAGE;
                } else if ("US".compareToIgnoreCase(roleID) == 0) {
                    session.setAttribute("LOGIN_USER_USER", loginUser);
                    url = USER_PAGE;
                } else {
                    session.setAttribute("ERROR_MESSAGE", "Your roleID is not supported !");
                }

                // Check Status
                String statusID = loginUser.getStatus();
                if (!statusID.equals("active")) {
                    url = ERROR;
                    session.setAttribute("ERROR_MESSAGE", "Your Account is not authorized to login");
                }
            } else {
                session.setAttribute("ERROR_MESSAGE", "UserID or Password is incorrect !");
            }

            // Verify CAPTCHA.
            String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

            boolean valid = VerifyUtils.verify(gRecaptchaResponse);
            if (!valid) {
                url = ERROR;
                session.setAttribute("ERROR_MESSAGE", "Recaptcha invalid!");
            }

        } catch (Exception e) {
            log("Error at LoginController: " + e.toString());
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
