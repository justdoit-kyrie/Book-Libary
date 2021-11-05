/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.users.UserDAO;
import sample.users.UserDTO;
import sample.users.UserError;
import sample.users.Validation;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CreateController", urlPatterns = {"/CreateController"})
public class CreateController extends HttpServlet {

    private static final String ERROR = "createAccount.jsp";
    private static final String SUCCESS = "login.html";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        UserError userError = new UserError();
        try {
            boolean check = true;
            String userID = request.getParameter("userID");
            String name = request.getParameter("name");
            String roleID = request.getParameter("roleID");
            String address = request.getParameter("address");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirm");

            //UserID
            if (!Validation.checkLength(userID, 5, 20)) {
                userError.setUserIDError("UserID length : [5,20]");
                check = false;
            }
            if (!Validation.checkString(userID, "^[a-z0-9\\.]+$")) {
                userError.setUserIDError("UserID can not has special Character or space Character !");
                check = false;
            }
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

            //Password
            if (!Validation.checkLength(password, 8, 30)) {
                userError.setPasswordError("Password length : [8,30]");
                check = false;
            }
            if (!Validation.checkString(password, "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\\s).*$")) {
                userError.setPasswordError("Password has must be at least 1 number, 1 Lowercase and Uppercase !");
                check = false;
            }

            //Confirm Password
            if (!confirm.equals(password)) {
                userError.setConfirmPasswordError("2 password must be the same !");
                check = false;
            }
            if (check) {
                if (UserDAO.insertUser(new UserDTO(userID, name, roleID, UserDAO.passwordEncryption(password), address,"active"))) {
                    url = SUCCESS;
                }
            } else {
                request.setAttribute("USER_ERROR", userError);
            }
        } catch (Exception e) {
            log("Error at CreateController: " + e.toString());
            if(e.toString().contains("duplicate")){
                userError.setUserIDError("UserID has been duplicated !");
                request.setAttribute("USER_ERROR", userError);
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
