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
public class UserDTO {

    private String userID;
    private String name;
    private String roleID;
    private String password;
    private String address;
    private String status;

    public UserDTO() {
        this.userID = "";
        this.name = "";
        this.roleID = "";
        this.password = "";
        this.address = "";
    }

    public UserDTO(String userID, String name, String roleID, String password, String address, String status) {
        this.userID = userID;
        this.name = name;
        this.roleID = roleID;
        this.password = password;
        this.address = address;
        this.status = status;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
