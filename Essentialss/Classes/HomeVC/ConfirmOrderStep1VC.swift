//
//  ConfirmOrderStep1VC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/20/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class ConfirmOrderStep1VC: UIViewController {
    var tapBack: (() ->())?
    @IBOutlet weak var tblCart: UITableView!
    var arrCarts = [productObj]()
    @IBOutlet weak var lblSubTotol: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblDelivery: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initCart()
    }
    private func initCart()
    {
        self.arrCarts = HelperCart.listProductSaved()
        self.tblCart.reloadData()
        if arrCarts.count == 0 {
            tabBarController?.tabBar.items?[2].badgeValue = nil
        }
        else{
            tabBarController?.tabBar.items?[2].badgeValue = "\(arrCarts.count)"
        }
        self.sumCartTotal()
    }
    func sumCartTotal()
    {
        if self.arrCarts.count == 0 {
            self.tapBack?()
            self.navigationController?.popViewController(animated: true)
        }
        else{
            var total = 0.0
            for item in self.arrCarts
            {
                print("PRICE--->",item.number)
                 let value = Double(item.priceNumber)! - (Double(item.priceNumber)! * (Double(item.discount)!/100))
                total = total + (value * Double(item.number)!)
            }
            self.lblTax.text =  String.init(format: "%0.2f aed", total * 0.05)
            self.lblSubTotol.text = String.init(format: "%0.2f aed",total)
            let AllTotal = total * 0.05 + total + DELIVERY_CHARGE
            self.lblTotal.text = String.init(format: "%0.2f aed", AllTotal)
            APP_DELEGATE.totalPrice = AllTotal
            APP_DELEGATE.taxCard = String.init(format: "%0.2f", total * 0.05)
        }
    }
    @IBAction func doBack(_ sender: Any) {
        self.tapBack?()
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ConfirmOrderStep1VC: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCarts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblCart.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
        let itemObj = self.arrCarts[indexPath.row]
         let value = Double(itemObj.priceNumber)! - (Double(itemObj.priceNumber)! * (Double(itemObj.discount)!/100))
        cell.lblPrice.text =  String.init(format: "%0.2f aed",value)
        cell.lblNumber.text = itemObj.number
        cell.lblName1.text = itemObj.name
        cell.lblName2.text = ""
        if itemObj.image.count > 0 {
             cell.imgCell.sd_setImage(with: URL.init(string: "\(URL_IMAGE)\(itemObj.image[0])")) { (image, error, type, url) in
                               
                }
        }
        cell.tapDelete = { [] in
            self.showAlertDelete(indexPath)
        }
        cell.tapMin = { [] in
            itemObj.number = cell.lblNumber.text!
            HelperCart.updateNumberCart(itemObj)
            self.sumCartTotal()
        }
        cell.tapPlus = { [] in
           itemObj.number = cell.lblNumber.text!
           HelperCart.updateNumberCart(itemObj)
            self.sumCartTotal()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
    func showAlertDelete(_ indexPath: IndexPath)
    {
        let alert = UIAlertController.init(title: APP_NAME, message: "Do you want to delete?", preferredStyle: .alert)
        let delete = UIAlertAction.init(title: "Delete", style: .destructive) { (alert) in
            HelperCart.removeProduct(self.arrCarts[indexPath.row])
            self.arrCarts.remove(at: indexPath.row)
            self.tblCart.reloadData()
            self.sumCartTotal()
        }
        alert.addAction(delete)
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel) { (alert) in
            
        }
        alert.addAction(cancel)
        self.present(alert, animated: true) {
            
        }
    }
}
