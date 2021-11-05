/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.paypalPayment;

/**
 *
 * @author Admin
 */
public class orderDetail {

    private String productName;
    private float price;
    private String quantity;
    private String total;
    

    public orderDetail(String productName, String price, String quantity, String total) {
        this.productName = productName;
        this.price = Float.parseFloat(price);
        this.total = total;
        this.quantity = quantity;
    }

    public String getProductName() {
        return productName;
    }

    public String getPrice() {
        return String.format("%.0f", price);
    }

    public String getTotal() {
        return total;
    }

    public String getQuantity() {
        return quantity;
    }
}
