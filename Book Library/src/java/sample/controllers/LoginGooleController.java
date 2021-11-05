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
import sample.accessgoole.GoogleInfo;
import sample.accessgoole.GoogleUtils;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginGooleController", urlPatterns = {"/login-google"})
public class LoginGooleController extends HttpServlet {

    private static final String ERROR = "login.html";
    private static final String SUCCESS = "user.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String code = request.getParameter("code");
            if (code == null || code.isEmpty()) {
                url = ERROR;
            } else {
                String accessToken = GoogleUtils.getToken(code);
                GoogleInfo googleInfo = GoogleUtils.getUserInfo(accessToken);
                UserDTO user = new UserDTO(googleInfo.getId(), googleInfo.getEmail(), "US", "", "","active");
                HttpSession session = request.getSession();
                session.setAttribute("LOGIN_USER_GOOGLE", user);
                
                String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
                
                /* 
                Nếu đã tồn tại trong DB thì không add vào nữa 
                [Lưu ý những User được đăng nhập bằng google Account không được sửa thông tin] 
                */              
                if (!UserDAO.checkExistUser(googleInfo.getId())) {
                    UserDAO.insertUser(user);
                }
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at LoginGoogleController: " + e.toString());
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
