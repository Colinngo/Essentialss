//
//  ConfirmOrderStep2VC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/20/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class ConfirmOrderStep2VC: BaseViewController {

    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var txfPhone: UITextField!
    @IBOutlet weak var tvNote: UITextView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var txfEmailCus: UITextField!
    @IBOutlet weak var txfCityCus: UITextField!
    @IBOutlet weak var txfStateCus: UITextField!
    @IBOutlet weak var txfNameShipping: UITextField!
    @IBOutlet weak var txfEmailShipping: UITextField!
    @IBOutlet weak var txfCityShipping: UITextField!
    @IBOutlet weak var txfStateShipping: UITextField!
    @IBOutlet weak var txfPostCode: UITextField!
    @IBOutlet weak var tvAddressShipping: UITextField!
    @IBOutlet weak var tvAddress: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        APP_DELEGATE.paymentObj = PaymentObj.init()
        self.lblTotal.text = String.init(format: "%0.2f aed", APP_DELEGATE.totalPrice)
        self.showVaueDefault()
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

    func showVaueDefault()
    {
        if let name = UserDefaults.standard.value(forKey: kName) as? String
        {
            self.txfName.text = name
        }
        if let phone = UserDefaults.standard.value(forKey: kPhone) as? String
       {
           self.txfPhone.text = phone
       }
        if let address = UserDefaults.standard.value(forKey: kAddress) as? String
       {
           self.tvAddress.text = address
       }
        if let note = UserDefaults.standard.value(forKey: kNote) as? String
       {
           self.tvNote.text = note
       }
        
      if let email = UserDefaults.standard.value(forKey: kEmail) as? String
       {
            self.txfEmailCus.text = email
       }
        if let state = UserDefaults.standard.value(forKey: kState) as? String
        {
             self.txfStateCus.text = state
        }
        if let city = UserDefaults.standard.value(forKey: kCity) as? String
        {
             self.txfCityCus.text = city
        }
    }
    
    @IBAction func doContinue(_ sender: Any) {
        let msg = self.validateMsg()
        if msg.isEmpty {
           
            self.saveDefault()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmOrderStep3VC") as!ConfirmOrderStep3VC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            self.showMessage(msg)
        }
    }
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validateMsg()-> String
    {
        var msg = ""
        let name = self.txfName.text!.trim()
        let phone = self.txfPhone.text!.trim()
        let address = self.tvAddress.text!.trim()
        let note = self.tvNote.text!.trim()
        let email = self.txfEmailCus.text!.trim()
        let city = self.txfCityCus.text!.trim()
        let state = self.txfStateCus.text!.trim()
        
        let nameShipping = self.txfNameShipping.text!.trim()
        let phoneShipping = self.txfPostCode.text!.trim()
        let addressShipping = self.tvAddressShipping.text!.trim()
        let emailShipping = self.txfEmailShipping.text!.trim()
        let cityShipping = self.txfCityShipping.text!.trim()
        let stateShipping = self.txfStateShipping.text!.trim()
        if name.isEmpty {
            msg = "Name is required"
        } else if email.isEmpty {
            msg = "Email is required"
        }
        else if !CommonHelper.isValidEmail(email: email)
        {
            msg = "Email is invalid"
        }
        else if phone.isEmpty {
            msg = "Phone Number is required"
        }
        else if city.isEmpty {
            msg = "City is required"
        }
        else if state.isEmpty {
            msg = "State/Province is required"
        }
        else if address.isEmpty {
            msg = "Address is required"
        }
        
            // SHIPPING
        else if nameShipping.isEmpty {
            msg = "Name Shipping is required"
        } else if emailShipping.isEmpty {
            msg = "Email Shipping is required"
        }
        else if !CommonHelper.isValidEmail(email: emailShipping)
        {
            msg = "Email Shipping is invalid"
        }
        else if addressShipping.isEmpty {
           msg = "Address Shipping is required"
       }
        else if cityShipping.isEmpty {
            msg = "City Shipping is required"
        }
        else if stateShipping.isEmpty {
            msg = "State/Province Shipping is required"
        }
       
        else if phoneShipping.isEmpty {
            msg = "Phone Number Shipping is required"
        }
            
        else if note.isEmpty {
            msg = "Note is required"
        }
        return msg
    }
    
    func saveDefault()
    {
        let name = self.txfName.text!.trim()
        let phone = self.txfPhone.text!.trim()
        let address = self.tvAddress.text!.trim()
        let note = self.tvNote.text!.trim()
        let email = self.txfEmailCus.text!.trim()
        let city = self.txfCityCus.text!.trim()
        let state = self.txfStateCus.text!.trim()
        
        let nameShipping = self.txfNameShipping.text!.trim()
        let phoneShipping = self.txfPostCode.text!.trim()
        let addressShipping = self.tvAddressShipping.text!.trim()
        let emailShipping = self.txfEmailShipping.text!.trim()
        let cityShipping = self.txfCityShipping.text!.trim()
        let stateShipping = self.txfStateShipping.text!.trim()
        UserDefaults.standard.set(name, forKey: kName)
        UserDefaults.standard.set(phone, forKey: kPhone)
        UserDefaults.standard.set(address, forKey: kAddress)
        UserDefaults.standard.set(email, forKey: kEmail)
        UserDefaults.standard.set(state, forKey: kState)
        UserDefaults.standard.set(city, forKey: kCity)
        UserDefaults.standard.set(note, forKey: kNote)
        UserDefaults.standard.synchronize()
        
        APP_DELEGATE.paymentObj.name = name
        APP_DELEGATE.paymentObj.phoneNumer = phone
        APP_DELEGATE.paymentObj.address = address
        APP_DELEGATE.paymentObj.note = note
        APP_DELEGATE.paymentObj.email = email
        APP_DELEGATE.paymentObj.state = state
        APP_DELEGATE.paymentObj.city = city
        
        APP_DELEGATE.paymentObj.nameShipping = nameShipping
        APP_DELEGATE.paymentObj.phoneNumerShipping = phoneShipping
        APP_DELEGATE.paymentObj.addressShipping = addressShipping
        APP_DELEGATE.paymentObj.emailShipping = emailShipping
        APP_DELEGATE.paymentObj.stateShipping = stateShipping
        APP_DELEGATE.paymentObj.cityShipping = cityShipping
    }
}

extension ConfirmOrderStep2VC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txfName {
            txfEmailCus.becomeFirstResponder()
        }
        else if textField == txfEmailCus {
            txfPhone.becomeFirstResponder()
        }
        else if textField == txfPhone {
            txfCityCus.becomeFirstResponder()
         }
        else if textField == txfCityCus {
           txfStateCus.becomeFirstResponder()
        }
        else if textField == txfStateCus {
           tvAddress.becomeFirstResponder()
        }
        else if textField == tvAddress {
             txfNameShipping.becomeFirstResponder()
        }
        else if textField == txfNameShipping {
            txfEmailShipping.becomeFirstResponder()
        }
        else if textField == txfEmailShipping {
            tvAddressShipping.becomeFirstResponder()
        }
            else if textField == tvAddressShipping {
                txfCityCus.becomeFirstResponder()
            }
        else if textField == txfCityCus {
            txfStateCus.becomeFirstResponder()
        }
        else if textField == txfStateCus {
            txfPostCode.becomeFirstResponder()
        }
        else{
            tvNote.becomeFirstResponder()
        }
        return true
    }
}
