/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.orders;

/**
 *
 * @author Admin
 */
public class OrderDTO {

    private String userID;
    private String date;
    private double total;
    private String paymentStatus;
    private String statusID;

    public OrderDTO() {
        this.userID = "";
        this.date = "";
        this.total = 0;
        this.paymentStatus = "";
        this.statusID = "";
    }

    public OrderDTO(String userID, String date, double total, String paymentStatus, String statusID) {
        this.userID = userID;
        this.date = date;
        this.total = total;
        this.paymentStatus = paymentStatus;
        this.statusID = statusID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getStatusID() {
        return statusID;
    }

    public void setStatusID(String statusID) {
        this.statusID = statusID;
    }

    
}
