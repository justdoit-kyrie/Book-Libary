/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.users;

/**
 *
 * @author Admin
 */
public class UserError {

    private String userIDError;
    private String nameError;
    private String roleIDError;
    private String addressError;
    private String passwordError;
    private String confirmPasswordError;
    private String statusError;

    public UserError() {
        this.userIDError = "";
        this.nameError = "";
        this.roleIDError = "";
        this.addressError = "";
        this.passwordError = "";
        this.confirmPasswordError = "";
        this.statusError = "";
    }

    public UserError(String userIDError, String nameError, String roleIDError, String addressError, String passwordError, String confirmPasswordError, String statusError) {
        this.userIDError = userIDError;
        this.nameError = nameError;
        this.roleIDError = roleIDError;
        this.addressError = addressError;
        this.passwordError = passwordError;
        this.confirmPasswordError = confirmPasswordError;
        this.statusError = statusError;
    }

    public String getUserIDError() {
        return userIDError;
    }

    public void setUserIDError(String userIDError) {
        this.userIDError = userIDError;
    }

    public String getNameError() {
        return nameError;
    }

    public void setNameError(String nameError) {
        this.nameError = nameError;
    }

    public String getRoleIDError() {
        return roleIDError;
    }

    public void setRoleIDError(String roleIDError) {
        this.roleIDError = roleIDError;
    }

    public String getAddressError() {
        return addressError;
    }

    public void setAddressError(String addressError) {
        this.addressError = addressError;
    }

    public String getPasswordError() {
        return passwordError;
    }

    public void setPasswordError(String passwordError) {
        this.passwordError = passwordError;
    }

    public String getConfirmPasswordError() {
        return confirmPasswordError;
    }

    public void setConfirmPasswordError(String confirmPasswordError) {
        this.confirmPasswordError = confirmPasswordError;
    }

    public String getStatusError() {
        return statusError;
    }

    public void setStatusError(String statusError) {
        this.statusError = statusError;
    }

}
