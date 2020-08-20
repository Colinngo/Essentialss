//
//  ConfimPaymentVC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/21/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class ConfimPaymentVC: UIViewController {
     var tapClose: (() ->())?
    var orderNo = ""
    @IBOutlet weak var lblMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblMessage.text = "Thank you for your order!Your order will be delivered within the next day. Your order number is \(orderNo) Please use the same for future references"
        // Do any additional setup after loading the view.
    }

    @IBAction func doBuy(_ sender: Any) {
        self.dismiss(animated: true) {
            self.tapClose?()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
