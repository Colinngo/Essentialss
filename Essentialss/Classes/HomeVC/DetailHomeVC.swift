//
//  DetailHomeVC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/20/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class DetailHomeVC: BaseViewController {

    @IBOutlet weak var lblNavi: UILabel!
    @IBOutlet weak var lblNumberCart: UILabel!
    @IBOutlet weak var txfSearch: UITextField!
    @IBOutlet weak var cltProduct: UICollectionView!
    var navi = ""
    var indexHome = 0
    var arrProducts = [productObj]()
    var arrProductSearchs = [productObj]()
    var subCategoryObj: subCategoryObj?
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.subCategoryObj == nil {
            self.lblNavi.text = navi
            self.callWSGetProductByHome()
        }
        else{
            self.lblNavi.text = subCategoryObj?.name
            self.callWSGetProductBySubCategory()
        }
        
        lblNumberCart.layer.cornerRadius = lblNumberCart.frame.size.width/2
        lblNumberCart.layer.masksToBounds = true
        cltProduct.register(UINib.init(nibName: "ProductItemCell", bundle: nil), forCellWithReuseIdentifier: "ProductItemCell")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllNumberCart(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doCart(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
    
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func doPhone(_ sender: Any) {
        self.openWhatsapp()
    }
    
    func getAllNumberCart(_ isReload: Bool)
    {
        let arrCartLocal = HelperCart.listProductSaved()
        if arrCartLocal.count == 0 {
            self.lblNumberCart.isHidden = true
            tabBarController?.tabBar.items?[2].badgeValue = nil
        }
        else{
            self.lblNumberCart.isHidden = false
            self.lblNumberCart.text = "\(arrCartLocal.count)"
            tabBarController?.tabBar.items?[2].badgeValue = "\(arrCartLocal.count)"
        }
        if isReload
        {
            self.cltProduct.reloadData()
        }
        
    }
    
    
}
extension DetailHomeVC: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.txfSearch.resignFirstResponder()
    }
}

extension DetailHomeVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         self.txfSearch.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            if  updatedText.isEmpty {
                self.arrProducts = self.arrProductSearchs
                self.cltProduct.reloadData()
            }
            else{
                self.arrProducts = self.arrProductSearchs.filter {
                    $0.name.lowercased().contains(updatedText.lowercased())
                }
                self.cltProduct.reloadData()
            }
        }
        return true
    }
}
extension DetailHomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collect = self.cltProduct.dequeueReusableCell(withReuseIdentifier: "ProductItemCell", for: indexPath) as! ProductItemCell
        collect.configCell(arrProducts[indexPath.row])
        let productObj = arrProducts[indexPath.row]
        collect.tapAddProduct = { [] in
            if HelperCart.checkProductExit(productObj)
            {
                HelperCart.removeProduct(productObj)
                collect.btnAdd.setTitle("Add", for: .normal)
               
            }
            else{
                HelperCart.saveProduct(productObj)
                 collect.btnAdd.setTitle("Added", for: .normal)
               //self.showAlertCart()
            }
            self.getAllNumberCart(false)
        }
        return collect
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.cltProduct.frame.size.width - 10)/2, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailProductVC") as! DetailProductVC
        vc.productObj = self.arrProducts[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension DetailHomeVC{
    private func callWSGetProductByHome()
    {
        CommonHelper.showBusy()
        ApiHelper.shared.getListProductByHomePage(indexHome) { (arrs) in
            if let products = arrs
            {
                self.arrProducts = products
            }
            self.arrProductSearchs = self.arrProducts
            self.cltProduct.reloadData()
            CommonHelper.hideBusy()
        }
    }
    
    private func callWSGetProductBySubCategory()
    {
        CommonHelper.showBusy()
        let param = NSMutableDictionary.init()
        let dict = ["id": subCategoryObj!.id]
        param.setValue(dict, forKey: "payload")
        ApiHelper.shared.getListProductBySubCategory(param) { (arrs) in
            if let products = arrs
            {
                self.arrProducts = products
            }
            self.arrProductSearchs = self.arrProducts
            self.cltProduct.reloadData()
            CommonHelper.hideBusy()
        }
    }
}


