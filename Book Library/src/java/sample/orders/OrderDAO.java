/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import sample.books.BookDTO;
import sample.orderDetail.OrderDetailDTO;
import sample.shopping.Cart;

import sample.utils.DBUtils;

/**
 *
 * @author Admin
 */
public class OrderDAO {

    public static boolean insertIntoTblorder(OrderDTO order) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "INSERT INTO tblorder (USERID, DATE, TOTAL, paymentStatus, statusID) "
                    + " VALUES(?, ?, ?, ?, ?)";
            stm = conn.prepareStatement(sql);
            stm.setString(1, order.getUserID());
            stm.setString(2, order.getDate());
            stm.setDouble(3, order.getTotal());
            stm.setString(4, order.getPaymentStatus());
            stm.setString(5, order.getStatusID());
            check = stm.executeUpdate() > 0;
        } catch (Exception e) {
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return check;
    }

    public static String getOrderID(String userID, String now, double total, String paymentStatus, String statusID) throws SQLException {
        String result = "";
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT tblorder.ORDERID FROM tblorder "
                    + " WHERE USERID=? and DATE=? and TOTAL=? and PAYMENTSTATUS=? and STATUSID=?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, userID);
            stm.setString(2, now);
            stm.setDouble(3, total);
            stm.setString(4, paymentStatus);
            stm.setString(5, statusID);
            rs = stm.executeQuery();
            while (rs.next()) {
                result = rs.getString("ORDERID");
            }
        } catch (Exception e) {
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

        return result;
    }

    public static boolean insertIntoTblorderDetail(OrderDetailDTO orderDetail) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "INSERT INTO tblOrderDetail (ORDERID, PRODUCTID, QUANTITY, PRICE) "
                    + " VALUES(?, ?, ?, ?)";
            stm = conn.prepareStatement(sql);
            stm.setString(1, orderDetail.getOrderID());
            stm.setString(2, orderDetail.getBookID());
            stm.setInt(3, orderDetail.getQuantity());
            stm.setDouble(4, orderDetail.getPrice());
            check = stm.executeUpdate() > 0;
        } catch (Exception e) {
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return check;
    }

    public static boolean updateProduct(String productID, int quantity) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "UPDATE tblProduct "
                    + " SET QUANTITY=? "
                    + " WHERE PRODUCTID=?";
            stm = conn.prepareStatement(sql);
            stm.setInt(1, quantity);
            stm.setString(2, productID);
            check = stm.executeUpdate() > 0;
        } catch (Exception e) {
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    private static void send(String host, String port,
            final String userName, final String password, String toAddress,
            String subject, String htmlBody)
            throws AddressException, MessagingException {
        // sets SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);

        // creates a new session with an authenticator
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        });

        // creates a new e-mail message
        Message msg = new MimeMessage(session);

        msg.setFrom(new InternetAddress(userName));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));
        msg.setSubject(subject);
        msg.setSentDate(new Date());

        msg.setContent(htmlBody, "text/html");

        Transport.send(msg);
    }

    public static void sendToEmail(String userEmail, Cart cart, double total) {
        String host = "smtp.gmail.com";
        String port = "587";
        String mailFrom = "kuducstyle1@gmail.com";
        String password = "anhviphonem1";

        // message info
        String mailTo = userEmail;
        String subject = "Confirm e-mail with Your Order from Libary";

        int count = 0;
        StringBuffer body = new StringBuffer("<html>");
        body.append("<head>");
        body.append("<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css\" integrity=\"sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm\" crossorigin=\"anonymous\"/>");
        body.append("<script src=\"https://code.jquery.com/jquery-3.2.1.slim.min.js\" integrity=\"sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN\" crossorigin=\"anonymous\"></script>"
                + "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js\" integrity=\"sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q\" crossorigin=\"anonymous\"></script>"
                + "<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js\" integrity=\"sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl\" crossorigin=\"anonymous\"></script>");
        body.append("<style>");
        body.append("td{"
                + "width: 150px;"
                + "}");
        body.append("</style>");
        body.append("</head>");
        body.append("<body>");
        body.append("<div class=\"container\">"
                + "     <div class=\"card\">"
                + "         <p style=\"color: green\">Your order has been already submited !</p>"
                + "         <p style=\"color: #333\">List of book: </p>"
                + "         <table>"
                + "             <thead>"
                + "                 <tr style=\"text-align: center\">"
                + "                     <th>NO</th>"
                + "                     <th>ID</th>"
                + "                     <th>Name</th>"
                + "                     <th>Quantity</th>"
                + "                     <th>Price</th>"
                + "                 </tr>"
                + "             </thead>"
                + "             <tbody>");
        for (BookDTO book : cart.getCart().values()) {
            String bookID = book.getBookID();
            String name = book.getName();
            int quantity = book.getQuantity();
            double price = book.getPrice();
            body.append("<tr style=\"text-align: center\">"
                    + "     <td>" + ++count + "</td>"
                    + "     <td>" + bookID + "</td>"
                    + "     <td>" + name + "</td>"
                    + "     <td>" + quantity + "</td>"
                    + "     <td>" + String.format("%.2f", price) + "</td>");
            body.append("</tr>");
        }
        body.append("</tbody>");
        body.append("</table>");
        body.append("Total: " + String.format("%.2f", total) + " $");
        body.append(" </div>");
        body.append("</div>");
        body.append("</body>");
        body.append("</html>");
        try {
            send(host, port, mailFrom, password, mailTo,
                    subject, body.toString());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
