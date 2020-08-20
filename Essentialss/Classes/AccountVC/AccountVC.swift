//
//  AccountVC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/17/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {

    @IBOutlet weak var txfFullName: UITextField!
    @IBOutlet weak var txfEmailAddress: UITextField!
    @IBOutlet weak var txfPhone: UITextField!
    @IBOutlet weak var tvAddress: UITextView!
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

}

extension AccountVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txfFullName {
            txfEmailAddress.becomeFirstResponder()
        }
        else if textField == txfEmailAddress
        {
            txfPhone.becomeFirstResponder()
        }
        return true
    }
}
