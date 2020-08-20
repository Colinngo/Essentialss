//
//  BaseViewController.swift
//  Essentialss

import UIKit
class BaseViewController: UIViewController {
    var alertCart = AlertAddCart.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showMessage(_ message: String)
    {
        let alertVC = UIAlertController.init(title: APP_NAME, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction.init(title: "OK", style: .cancel) { (action) in
            
        }
        alertVC.addAction(ok)
        self.present(alertVC, animated: true) {
            
        }
    }
    
    func openWhatsapp(){
        let urlWhats = "whatsapp://send?phone=\(PHONE_WHATAPP)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    self.showMessage("Please Install Whatsapp")
                }
            }
        }
    }
    
    func showAlertCart()
    {
        alertCart = Bundle.main.loadNibNamed("AlertAddCart", owner: self, options: nil)![0] as! AlertAddCart
        alertCart.frame = UIScreen.main.bounds
        APP_DELEGATE.window?.addSubview(self.alertCart)
        alertCart.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
           self.alertCart.alpha = 1.0
       }, completion: { (success) in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Change `2.0` to the desired number of
               UIView.animate(withDuration: 0.25, animations: {
                   self.alertCart.alpha = 0.0
               }, completion: { (success) in
                   self.alertCart.removeFromSuperview()
               })
           }
       })
        
    }
}
