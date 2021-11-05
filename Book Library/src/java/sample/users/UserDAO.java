/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.codec.digest.DigestUtils;
import sample.utils.DBUtils;

/**
 *
 * @author Admin
 */
public class UserDAO {

    public static UserDTO checkLogin(String userID, String password) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT ROLEID, NAME, ADDRESS, STATUSID FROM tblUsers "
                    + " WHERE USERID=? AND PASSWORD=?";
            stm = conn.prepareStatement(sql);
            String tmp = passwordEncryption(password);
            stm.setString(1, userID);
            stm.setString(2, tmp);
            rs = stm.executeQuery();
            if (rs.next()) {
                user = new UserDTO(userID, rs.getString("NAME"), rs.getString("ROLEID"), password, rs.getString("ADDRESS"), rs.getString("STATUSID"));
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

        return user;
    }

    public static List<UserDTO> getListUser(String search) throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();

            // không hiển thị các user được đăng nhập bằng google Account            
            String sql = "SELECT USERID, NAME, ADDRESS, ROLEID, STATUSID FROM tblUsers "
                    + " WHERE NAME LIKE ? "
                    + " AND NAME NOT LIKE ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + search + "%");
            stm.setString(2, "%@%");
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new UserDTO(rs.getString("USERID"), rs.getString("NAME"), rs.getString("ROLEID"), "***", rs.getString("ADDRESS"), rs.getString("STATUSID")));
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

        return list;
    }

    public static List<String> getListRoleID() throws SQLException {
        List<String> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT ROLEID FROM tblRoles ";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("ROLEID"));
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

        return list;
    }

    public static boolean deleteUser(String userID) throws SQLException, ClassNotFoundException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "DELETE FROM tblUsers "
                    + " WHERE USERID=?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, userID);
            result = stm.executeUpdate() > 0;
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public static boolean updateUser(UserDTO user) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "UPDATE tblUsers "
                    + " SET NAME=N'" + user.getName() + "'" + ", ROLEID=?, ADDRESS=N'" + user.getAddress() + "', STATUSID=? "
                    + " WHERE USERID=?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, user.getRoleID());
            stm.setString(2, user.getStatus());
            stm.setString(3, user.getUserID());
            result = stm.executeUpdate() > 0;
        } catch (Exception e) {
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public static boolean insertUser(UserDTO user) throws SQLException, ClassNotFoundException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "INSERT INTO tblUsers(USERID, NAME, ROLEID, ADDRESS, PASSWORD, STATUSID) "
                    + " VALUES(?, ?, ?, ?, ?, ?)";
            stm = conn.prepareStatement(sql);
            stm.setString(1, user.getUserID());
            stm.setString(2, user.getName());
            stm.setString(3, user.getRoleID());
            stm.setString(4, user.getAddress());
            stm.setString(5, user.getPassword());
            stm.setString(6, user.getStatus());
            result = stm.executeUpdate() > 0;
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public static boolean checkExistUser(String userID) throws ClassNotFoundException, SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT USERID FROM tblUsers "
                    + " WHERE USERID=? ";
            stm = conn.prepareStatement(sql);
            stm.setString(1, userID);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = true;
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

    public static String passwordEncryption(String password) {
        String md5Hex = DigestUtils.md5Hex(password);
        return md5Hex;
    }
}
