/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.users;

import java.util.List;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author Admin
 */
public class Validation {

    public static boolean checkLength(String string, int min, int max) {
        return string.length() >= min && string.length() <= max;
    }

    public static boolean checkString(String string, String regex) {
        return string.matches(regex);
    }

    public static boolean checkRoleID(String roleID) {
        boolean check = false;
        try {
            List<String> list = UserDAO.getListRoleID();
            if (list != null) {
                for (String tmp : list) {
                    check = roleID.compareToIgnoreCase(tmp) == 0;
                    if (check) {
                        break;
                    }
                }
            }
        } catch (Exception e) {
        }
        return check;
    }

    public static boolean checkStatus(String status) {
        boolean check = false;
        try {
            if (status.compareToIgnoreCase("active") == 0 || status.compareToIgnoreCase("deactive") == 0) {
                check = true;
            }
        } catch (Exception e) {
        }
        return check;
    }
    
}
