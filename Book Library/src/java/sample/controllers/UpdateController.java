/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.users.UserDAO;
import sample.users.UserDTO;
import sample.users.UserError;
import sample.users.Validation;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateController", urlPatterns = {"/UpdateController"})
public class UpdateController extends HttpServlet {

    private static final String ERROR = "update.jsp";
    private static final String SUCCESS = "SearchController";
    private static final String LOGOUT = "LogoutController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        HttpSession session = request.getSession();
        try {
            boolean check = true;
            String userID = request.getParameter("userID");
            String name = request.getParameter("name");
            String roleID = request.getParameter("roleID");
            String address = request.getParameter("address");
            String status = request.getParameter("status");
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER_ADMIN");
            UserError userError = new UserError();

            //Name            
            if (!Validation.checkLength(name, 5, 30)) {
                userError.setNameError("Name length : [5,30]");
                check = false;
            }
            if (!Validation.checkString(name, "^([a-zA-Z]*(\\s[a-zA-Z]*)*)$")) {
                userError.setNameError("Name can not has special Character or number !");
                check = false;
            }

            //RoleID
            if (!Validation.checkLength(roleID, 2, 5)) {
                userError.setRoleIDError("RoleID length : [2,5]");
                check = false;
            }
            if (!Validation.checkRoleID(roleID)) {
                userError.setRoleIDError("This RoleID is not supported !");
                check = false;
            }

            //Address
            if (!Validation.checkLength(address, 10, 50)) {
                userError.setAddressError("Address length : [10,50]");
                check = false;
            }
            
            //Status
            if (!Validation.checkStatus(status)) {
                userError.setStatusError("Status must be 'active' or 'deactive' !");
                check = false;
            }

            if (check) {
                if (UserDAO.updateUser(new UserDTO(userID, name, roleID, loginUser.getPassword(), address, status))) {
                    if (userID.compareToIgnoreCase(loginUser.getUserID()) == 0) {
                        url = LOGOUT;
                    } else {
                        url = SUCCESS;
                    }
                }
            }else{
                request.setAttribute("USER_ERROR", userError);
            }
        } catch (Exception e) {
            log("Error at UpdateController: " + e.toString());
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
