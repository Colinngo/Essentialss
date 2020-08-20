//
//  ConfirmOrderStep3VC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/20/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class ConfirmOrderStep3VC: BaseViewController {

    @IBOutlet weak var icDelivery: UIImageView!
    @IBOutlet weak var icCreditCard: UIImageView!
    var indexPay = 1
    var oder = "#"
    var initialSetupViewController: PTFWInitialSetupViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doDeliveryType(_ sender: Any) {
        self.icDelivery.image = UIImage.init(named: "circle_1")
        self.icCreditCard.image = UIImage.init(named: "circle")
        indexPay = 1
    }
    @IBAction func doCreateCard(_ sender: Any) {
        self.icDelivery.image = UIImage.init(named: "circle")
               self.icCreditCard.image = UIImage.init(named: "circle_1")
        indexPay = 2
    }
    @IBAction func doBuy(_ sender: Any) {
        if indexPay == 1 {
            self.paramWS("cash")
        }
        else{
            self.showPayTabs()
//            APP_DELEGATE.paymentObj.isDelivery = false
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MasterCardVC") as! MasterCardVC
//            vc.tapBuy = { [] in
//                self.perform(#selector(self.showConfirm), with: nil, afterDelay: 0.25)
//            }
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showPayTabs()
    {
       let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
        self.initialSetupViewController = PTFWInitialSetupViewController.init(
            bundle: bundle,
            andWithViewFrame: self.view.frame,
            andWithAmount: Float(APP_DELEGATE.totalPrice),
            andWithCustomerTitle: APP_DELEGATE.paymentObj.name,
            andWithCurrencyCode: "AED",
            andWithTaxAmount: 0.0,
            andWithSDKLanguage: "en",
            andWithShippingAddress: APP_DELEGATE.paymentObj.addressShipping,
            andWithShippingCity: APP_DELEGATE.paymentObj.cityShipping,
            andWithShippingCountry: "ARE",
            andWithShippingState: APP_DELEGATE.paymentObj.stateShipping,
            andWithShippingZIPCode: "00973",
            andWithBillingAddress: APP_DELEGATE.paymentObj.address,
            andWithBillingCity: APP_DELEGATE.paymentObj.city,
            andWithBillingCountry: "ARE",
            andWithBillingState: APP_DELEGATE.paymentObj.state,
            andWithBillingZIPCode: "00973",
            andWithOrderID: "12345",
            andWithPhoneNumber: APP_DELEGATE.paymentObj.phoneNumer,
            andWithCustomerEmail: APP_DELEGATE.paymentObj.email,
            andIsTokenization:false,
            andIsPreAuth: false,
            andWithMerchantEmail: "vishal.fancy@yahoo.com",
            andWithMerchantSecretKey: "QOMMqaFesupQb6ESMdIZEhcxqGHXRp3IePuE0aStEhjPnXIabq9QHmn8356Vu9EIZ8mZiesXwMNUKv4VVeLDB8MEdSzI2dq1mM1F",
            andWithAssigneeCode: "SDK",
            andWithThemeColor:UIColor.red,
            andIsThemeColorLight: false)
        
        
        self.initialSetupViewController.didReceiveBackButtonCallback = {
            
        }
        
        self.initialSetupViewController.didStartPreparePaymentPage = {
            // Start Prepare Payment Page
            // Show loading indicator
        }
        self.initialSetupViewController.didFinishPreparePaymentPage = {
            // Finish Prepare Payment Page
            // Stop loading indicator
        }
        
        self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
            print("Response Code: \(responseCode)")
            print("Response Result: \(result)")
            
            // In Case you are using tokenization
            print("Tokenization Cutomer Email: \(tokenizedCustomerEmail)");
            print("Tokenization Customer Password: \(tokenizedCustomerPassword)");
            print("TOkenization Token: \(token)");
            if responseCode == 100 {
                self.paramWS("debit/creditcard")
            }
            else{
                self.showMessage("\(result)")
            }
        }

        self.view.addSubview(initialSetupViewController.view)
        self.addChildViewController(initialSetupViewController)
        
        initialSetupViewController.didMove(toParentViewController: self)
    }
    @objc func showConfirm()
    {
        let vc = ConfimPaymentVC()
       vc.modalTransitionStyle = .crossDissolve
      // vc.modalPresentationStyle = .fullScreen
        vc.modalPresentationStyle = .overFullScreen
        vc.orderNo = oder
        vc.tapClose = { [] in
            self.navigationController?.popToRootViewController(animated: true)
            APP_DELEGATE.isPaymentSuccess = true
        }
       self.present(vc, animated: true, completion: nil)
    }
    
    func showBirthday()-> String
    {
        let format = DateFormatter.init()
        format.dateFormat = "MM-dd-yyyy"
        return format.string(from: Date())
    }
    
    func paramWS(_ card: String)
    {
        let dictOrder = ["customerName": APP_DELEGATE.paymentObj.name,"customerMobile": APP_DELEGATE.paymentObj.phoneNumer, "customerBirthday": self.showBirthday(), "customerAddress":APP_DELEGATE.paymentObj.address, "paymentmethod":card,"paymentStatus": true, "tax": APP_DELEGATE.taxCard,"deliveryCharge":"\(DELIVERY_CHARGE)","totalAmount":String.init(format: "%0.2f", APP_DELEGATE.totalPrice), "description": APP_DELEGATE.paymentObj.note] as [String : Any]
        var arrProducts = [NSDictionary]()
        let arrs = HelperCart.listProductSaved()
        for item in arrs
        {
            let dict = ["productId": item.id , "quantity": item.number , "price":item.priceNumber]
            arrProducts.append(dict as NSDictionary)
        }
        
        CommonHelper.showBusy()
        let param = NSMutableDictionary.init()
        param.setValue(dictOrder, forKey: "order")
        param.setValue(arrProducts, forKey: "detail")
        let paramAPI = ["payload": param]
        print("PARAM --->",paramAPI)
        ApiHelper.shared.savePaymentOrderCash(paramAPI as NSDictionary) { (success, msg, orderNo, orderID) in
            
            if success!
            {
                let paramUpdate = NSMutableDictionary.init()
                let dict = ["id": orderID ?? "#", "paymentStatus": true] as [String : Any]
                paramUpdate.setValue(dict, forKey: "payload")
                ApiHelper.shared.updateOrderPayment(paramUpdate) { (success, erro) in
                    CommonHelper.hideBusy()
                    if success{
                        self.oder = orderNo ?? "#"
                        UserDefaults.standard.removeObject(forKey: kCartLocal)
                        self.perform(#selector(self.showConfirm), with: nil, afterDelay: 0.25)
                    }
                    else{
                        self.showMessage("Payment fail. Please try again!")
                    }
                }
               
            }
            else{
                CommonHelper.hideBusy()
                if let msg = msg
                {
                    self.showMessage(msg)
                }
            }
        }
    }
    
}
