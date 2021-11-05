/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.books;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author Admin
 */
public class BookDAO {

    public static List<BookDTO> getBooksList(String search) throws SQLException, ClassNotFoundException {
        List<BookDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "select PRODUCTID,tblProduct.name AS NAME, PRICE, QUANTITY, tblCategory.name AS categoryName, IMAGE from tblProduct "
                    + " join tblCategory on tblProduct.categoryID = tblCategory.categoryID "
                    + " where tblProduct.name LIKE ? and quantity > 0 and statusID = 'active'";
            stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + search + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                String bookID = rs.getString("PRODUCTID");
                String name = rs.getString("NAME");
                double price = Double.parseDouble(rs.getString("PRICE"));
                int quantity = Integer.parseInt(rs.getString("QUANTITY"));
                String category = rs.getString("categoryName");
                String image = rs.getString("IMAGE");
                list.add(new BookDTO(bookID, name, quantity, price, category, image));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
    
    public static List<BookDTO> getBooksListByCategory(String categoryID) throws SQLException, ClassNotFoundException {
        List<BookDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "select PRODUCTID,tblProduct.name AS NAME, PRICE, QUANTITY, tblCategory.name AS categoryName, IMAGE from tblProduct "
                    + " join tblCategory on tblProduct.categoryID = tblCategory.categoryID "
                    + " where quantity > 0 and statusID = 'active' and tblProduct.categoryID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, categoryID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String bookID = rs.getString("PRODUCTID");
                String name = rs.getString("NAME");
                double price = Double.parseDouble(rs.getString("PRICE"));
                int quantity = Integer.parseInt(rs.getString("QUANTITY"));
                String category = rs.getString("categoryName");
                String image = rs.getString("IMAGE");
                list.add(new BookDTO(bookID, name, quantity, price, category, image));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public static int getQuantity(String bookID) throws SQLException {
        int quantity = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "select QUANTITY from tblProduct "
                    + " where PRODUCTID=?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, bookID);
            rs = stm.executeQuery();
            while (rs.next()) {
                quantity = Integer.parseInt(rs.getString("QUANTITY"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return quantity;
    }
}
