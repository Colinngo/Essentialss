//
//  SearchProductVC.swift
//  Essentialss
//
//  Created by Colin Ngo on 8/3/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class SearchProductVC: BaseViewController {

    @IBOutlet weak var lblNumberCart: UILabel!
    @IBOutlet weak var txfSearch: UITextField!
     var arrProducts = [productObj]()
    @IBOutlet weak var cltProdcts: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txfSearch.becomeFirstResponder()
        lblNumberCart.layer.cornerRadius = lblNumberCart.frame.size.width/2
        lblNumberCart.layer.masksToBounds = true
        cltProdcts.register(UINib.init(nibName: "ProductItemCell", bundle: nil), forCellWithReuseIdentifier: "ProductItemCell")
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
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doCart(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
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
            self.cltProdcts.reloadData()
        }
        
    }
    @IBAction func doSearch(_ sender: Any) {
        self.txfSearch.resignFirstResponder()
               self.callWSGetProductBySubCategory(self.txfSearch.text!)
    }
}
extension SearchProductVC: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.txfSearch.resignFirstResponder()
    }
}

extension SearchProductVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         self.txfSearch.resignFirstResponder()
        self.callWSGetProductBySubCategory(self.txfSearch.text!)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if let text = textField.text,
//           let textRange = Range(range, in: text) {
//           let updatedText = text.replacingCharacters(in: textRange,
//                                                       with: string)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                   // do stuff 42 seconds later
//                self.callWSGetProductBySubCategory(updatedText)
//               }
//        }
        return true
    }
    
    
}
extension SearchProductVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collect = self.cltProdcts.dequeueReusableCell(withReuseIdentifier: "ProductItemCell", for: indexPath) as! ProductItemCell
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
        return CGSize(width: (self.cltProdcts.frame.size.width - 10)/2, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailProductVC") as! DetailProductVC
        vc.productObj = self.arrProducts[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension SearchProductVC{
    
    
    private func callWSGetProductBySubCategory(_ name: String)
    {
        CommonHelper.showBusy()
        let param = NSMutableDictionary.init()
        let dict = ["name": name]
        param.setValue(dict, forKey: "payload")
        ApiHelper.shared.seachProduct(param) { (arrs) in
            CommonHelper.hideBusy()
            self.arrProducts.removeAll()
            if let products = arrs
            {
                self.arrProducts = products
            }
            self.cltProdcts.reloadData()
        }
    }
}
