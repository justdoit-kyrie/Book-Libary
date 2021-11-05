/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.shopping;

import java.util.HashMap;
import java.util.Map;
import sample.books.BookDTO;

/**
 *
 * @author Admin
 */
public class Cart {

    private Map<String, BookDTO> cart;

    public Cart() {
        this.cart = new HashMap<>();
    }

    public Cart(Map<String, BookDTO> cart) {
        this.cart = cart;
    }

    public Map<String, BookDTO> getCart() {
        return cart;
    }

    public void setCart(Map<String, BookDTO> cart) {
        this.cart = cart;
    }

    public void add(BookDTO book) {
        if (this.cart == null) {
            cart = new HashMap<>();
        }
        if (this.cart.containsKey(book.getBookID())) {
            int currentQuantity = this.cart.get(book.getBookID()).getQuantity() + book.getQuantity();
            book.setQuantity(currentQuantity);
        }
        this.cart.put(book.getBookID(), book);
    }

    public void delete(String bookID) {
        if (this.cart == null) {
            return;
        }
        if (this.cart.containsKey(bookID)) {
            this.cart.remove(bookID);
        }
    }
    
    public void deleteALL() {
        if (this.cart == null) {
            return;
        }
        this.cart.clear();
    }

    public void update(String id, BookDTO book) {
        if (this.cart == null) {
            return;
        }
        if (this.cart.containsKey(id)) {
            this.cart.replace(id, book);
        }
    }
}
