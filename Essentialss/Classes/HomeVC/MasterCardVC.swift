//
//  MasterCardVC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/20/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class MasterCardVC: BaseViewController {
    var tapBuy: (() ->())?
    @IBOutlet weak var txfNameCart: UITextField!
    @IBOutlet weak var txfCardNumber: UITextField!
    @IBOutlet weak var txfExpiryDate: UITextField!
    @IBOutlet weak var txfCCV: UITextField!
    @IBOutlet weak var lblTotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTotal.text = String.init(format: "%0.2f aed", APP_DELEGATE.totalPrice)
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
    @IBAction func doOrder(_ sender: Any) {
        let msg = self.validateMsg()
        if  msg.isEmpty{
            //UserDefaults.standard.removeObject(forKey: kCartLocal)
            //self.tapBuy?()
            //self.navigationController?.popViewController(animated: true)
            
            let alertVC = UIAlertController.init(title: APP_NAME, message: "Support later", preferredStyle: .alert)

            let ok = UIAlertAction.init(title: "OK", style: .cancel) { (action) in
                //UserDefaults.standard.removeObject(forKey: kCartLocal)
                self.navigationController?.popToRootViewController(animated: true)
            }
            alertVC.addAction(ok)
            self.present(alertVC, animated: true) {

            }
        }
        else{
            self.showMessage(msg)
        }
       
    }
    
    func validateMsg()-> String
       {
           var msg = ""
           let name = self.txfNameCart.text!.trim()
           let number = self.txfCardNumber.text!.trim()
           let expiry = self.txfExpiryDate.text!.trim()
           let ccv = self.txfCCV.text!.trim()
           if name.isEmpty {
               msg = "Card Name is required"
           } else if number.isEmpty {
               msg = "Cart Number is required"
           }else if expiry.isEmpty {
               msg = "Expiry Date is required"
           }else if ccv.isEmpty {
               msg = "CCV is required"
           }
           return msg
       }
}
