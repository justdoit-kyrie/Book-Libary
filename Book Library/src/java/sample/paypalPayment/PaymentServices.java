/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.paypalPayment;

import com.paypal.api.payments.Item;
import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import java.util.ArrayList;
import java.util.List;
import sample.books.BookDTO;
import sample.shopping.Cart;

/**
 *
 * @author Admin
 */
public class PaymentServices {

    private static final String CLIENT_ID = "AX8KZ6KLNjWatrAik16-NoW3AGdiEbYrRjYpjrCzWooPX1utvLHscsvxbp_mBcwGg-VjiG58Y-LBhhNf";
    private static final String CLIENT_SECRET = "EL6lEez7z4zNfAtkHUqTmgBlt-S7w5JsF-2QIcjlzruF_79RwVrETn49HnEHdKce-BLVMXKRlUNch-cY";
    private static final String MODE = "sandbox";

    public String authorizePayment(Cart cart, String total)
            throws PayPalRESTException {

        Payer payer = getPayerInformation();
        RedirectUrls redirectUrls = getRedirectURLs();
        List<Transaction> listTransaction = getTransactionInformation(cart, total);

        Payment requestPayment = new Payment();
        requestPayment.setTransactions(listTransaction);
        requestPayment.setRedirectUrls(redirectUrls);
        requestPayment.setPayer(payer);
        requestPayment.setIntent("authorize");

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

        Payment approvedPayment = requestPayment.create(apiContext);

        return getApprovalLink(approvedPayment);

    }

    private Payer getPayerInformation() {
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");

        PayerInfo payerInfo = new PayerInfo();
        payerInfo.setFirstName("Minh")
                .setLastName("Duc")
                .setEmail("minh.Duc@company.com");

        payer.setPayerInfo(payerInfo);

        return payer;
    }

    private RedirectUrls getRedirectURLs() {
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:8084/AssignMent_SE151198/viewCart.jsp");
        redirectUrls.setReturnUrl("http://localhost:8084/AssignMent_SE151198/ReviewPaymentController");

        return redirectUrls;
    }

    private List<Transaction> getTransactionInformation(Cart cart, String total) {
        Transaction transaction = new Transaction();

        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<>();
        
        orderDetail orderDetail = null;
        
        for (BookDTO book : cart.getCart().values()) {
            orderDetail = new orderDetail(book.getBookID(), String.valueOf(book.getPrice()), String.valueOf(book.getQuantity()), total);
            Item item = new Item();
            item.setCurrency("USD");
            item.setName(orderDetail.getProductName());
            item.setPrice(orderDetail.getPrice());
            item.setQuantity(orderDetail.getQuantity());
            items.add(item);
        }
            
        itemList.setItems(items);
        transaction.setItemList(itemList);

        Details details = new Details();
        details.setSubtotal(orderDetail.getTotal());
        details.setShipping("3");

        Amount amount = new Amount();
        amount.setCurrency("USD");
        int tmp = Integer.parseInt(String.format("%.0f", Float.parseFloat(orderDetail.getTotal()))) + 3;
        amount.setTotal(String.valueOf(tmp));
        amount.setDetails(details);

        transaction.setAmount(amount);
        transaction.setDescription("Order Book");
        List<Transaction> listTransaction = new ArrayList<>();
        listTransaction.add(transaction);

        return listTransaction;
    }

    private String getApprovalLink(Payment approvedPayment) {
        List<Links> links = approvedPayment.getLinks();
        String approvalLink = null;

        for (Links link : links) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                approvalLink = link.getHref();
                break;
            }
        }

        return approvalLink;
    }

    public Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return Payment.get(apiContext, paymentId);
    }

    public Payment executePayment(String paymentId, String payerId)
            throws PayPalRESTException {
        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);

        Payment payment = new Payment().setId(paymentId);

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

        return payment.execute(apiContext, paymentExecution);
    }
}
