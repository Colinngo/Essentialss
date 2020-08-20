//
//  CashDeliveryVC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/20/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class CashDeliveryVC: BaseViewController {
    var tapBuy: (() ->())?
    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var txfPhone: UITextField!
    @IBOutlet weak var tvAddress: UITextView!
    @IBOutlet weak var tvNote: UITextView!
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
    
    @IBAction func doFinish(_ sender: Any) {
        let msg = self.validateMsg()
        if msg.isEmpty {
            UserDefaults.standard.removeObject(forKey: kCartLocal)
            self.tapBuy?()
            self.navigationController?.popViewController(animated: true)
        }
        else{
            self.showMessage(msg)
        }
        
        
    }
    
    func validateMsg()-> String
    {
        var msg = ""
        let name = self.txfName.text!.trim()
        let phone = self.txfPhone.text!.trim()
        let address = self.tvAddress.text!.trim()
        let note = self.tvNote.text!.trim()
        if name.isEmpty {
            msg = "Name is required"
        } else if phone.isEmpty {
            msg = "Phone Number is required"
        }else if address.isEmpty {
            msg = "Address is required"
        }else if note.isEmpty {
            msg = "Note is required"
        }
        return msg
    }
    
  
}
