/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.books;

/**
 *
 * @author Admin
 */
public class BookDTO {

    private String bookID;
    private String name;
    private int quantity;
    private double price;
    private String category;
    private String image;

    public BookDTO() {
        this.bookID = "";
        this.name = "";
        this.quantity = 0;
        this.price = 0;
        this.category = "";
    }

    public BookDTO(String bookID, String name, int quantity, double price, String category, String image) {
        this.bookID = bookID;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.category = category;
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    
}
