//
//  HomeVC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/17/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit
import SafariServices
import SDWebImage
class HomeVC: UIViewController {

    @IBOutlet weak var tblHome: UITableView!
    var arrHomes = [HomeObj]()
    @IBOutlet weak var txfSearch: UITextField!
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
        self.getAllNumberCart()
        self.getAllBanner()
       // print("CART PAYMENT--->",HelperCart.listOrderPayment())
    }
    
    func getAllNumberCart()
    {
        let arrCartLocal = HelperCart.listProductSaved()
        if arrCartLocal.count == 0 {
            tabBarController?.tabBar.items?[2].badgeValue = nil
        }
        else{
            tabBarController?.tabBar.items?[2].badgeValue = "\(arrCartLocal.count)"
        }
    }
    
    @IBAction func doPinterset(_ sender: Any) {
        self.openLink(URL_PINTERSET)
    }
    @IBAction func doLinked(_ sender: Any) {
         self.openLink(URL_INTERGRAM)
    }
    
    @IBAction func doTwitter(_ sender: Any) {
         self.openLink(URL_TW)
    }
    @IBAction func doFacebook(_ sender: Any) {
         self.openLink(URL_FB)
    }
    
    func openLink(_ url: String)
    {
        let vc = SFSafariViewController.init(url: URL.init(string: url)!)
        self.present(vc, animated: true) {
            
        }
    }
    
    func getAllBanner()
   {
    CommonHelper.showBusy()
       ApiHelper.shared.getBannarHomePage { (arrs) in
        self.arrHomes.removeAll()
        CommonHelper.hideBusy()
           if let datas = arrs
           {
               self.arrHomes = datas
               
           }
        self.tblHome.reloadData()
       }
   }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHomes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblHome.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        let obj = self.arrHomes[indexPath.row]
        cell.lblName.text = obj.name
        if obj.image.count > 0 {
            cell.imgCell.sd_setImage(with: URL.init(string: "\(URL_IMAGE)\(obj.image)")) { (image, error, type, url) in
                
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailHomeVC") as! DetailHomeVC
        let obj = self.arrHomes[indexPath.row]
        vc.navi = obj.name
        if obj.name.lowercased().contains("Top New Products".lowercased()) {
            vc.indexHome = 0
        }
        else if obj.name.lowercased().contains("Top Sale Products".lowercased()) {
            vc.indexHome = 2
        }
        else{
            vc.indexHome = 2
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeVC: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.txfSearch.resignFirstResponder()
    }
}

extension HomeVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         self.txfSearch.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.txfSearch.resignFirstResponder()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchProductVC") as! SearchProductVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
