//
//  DetailProductVC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/20/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class DetailProductVC: BaseViewController {

    @IBOutlet weak var lblNumberCart: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnAddToCard: UIButton!
    @IBOutlet weak var cltPhotos: UICollectionView!
    @IBOutlet weak var lblDesc: UILabel!
    var arrPhotos = [String]()
    var productObj: productObj?
    var indexSelect = 0
    @IBOutlet weak var viewSaleOff: UIView!
    @IBOutlet weak var lblSaleOff: UILabel!
    @IBOutlet weak var lblSale: UILabel!
    @IBOutlet weak var lblPriceProduct: UILabel!
    @IBOutlet weak var viewPriceProduct: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNumberCart.layer.cornerRadius = lblNumberCart.frame.size.width/2
        lblNumberCart.layer.masksToBounds = true
        self.getAllNumberCart()
        self.updateUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllNumberCart()
        self.updateUI()
    }
    func getAllNumberCart()
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
    }
    
    func updateUI()
    {
        if let proObj = self.productObj
        {
            if proObj.discount == "0.0"  || proObj.discount.isEmpty || proObj.discount == "0"
            {
                self.viewSaleOff.isHidden = true
                self.lblPriceProduct.isHidden = true
                self.viewPriceProduct.isHidden = true
                
            }
            else{
                self.viewSaleOff.isHidden = false
                self.lblSaleOff.text = "\(proObj.discount)%"
                
                self.lblPriceProduct.isHidden = false
                self.viewPriceProduct.isHidden = false
                
            }
             let value = proObj.price - (proObj.price * (Double(proObj.discount)!/100))
            self.lblName.text = proObj.name
            self.lblDesc.text = proObj.desc
            self.lblPrice.text = String.init(format: "%0.2f aed", value)
            self.lblSale.text = String.init(format: "Price: %0.2f aed", value)
            self.lblPriceProduct.text = String.init(format: "%0.2f aed", proObj.price)
            if HelperCart.checkProductExit(proObj)
            {
                self.btnAddToCard.setTitle("Remove to Cart", for: .normal)
            }
            else{
                self.btnAddToCard.setTitle("Add to Cart", for: .normal)
            }
            
            self.arrPhotos = proObj.image
            self.cltPhotos.reloadData()
            if self.arrPhotos.count > 0 {
                self.imgCell.sd_setImage(with: URL.init(string: "\(URL_IMAGE)\(self.arrPhotos[0])")) { (image, error, type, url) in
                    
                }
            }
            
        }
        
    }
    
    @IBAction func doCart(_ sender: Any) {
         self.tabBarController?.selectedIndex = 2
    }
    @IBAction func doPhone(_ sender: Any) {
        self.openWhatsapp()
    }
    
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func doAddToCart(_ sender: Any) {
        if let productObj = self.productObj
        {
            if HelperCart.checkProductExit(productObj)
            {
                HelperCart.removeProduct(productObj)
                self.btnAddToCard.setTitle("Add to Cart", for: .normal)
               
            }
            else{
                HelperCart.saveProduct(productObj)
                self.btnAddToCard.setTitle("Added to Cart", for: .normal)
                //self.showAlertCart()
            }
            self.getAllNumberCart()
        }
    }
}

extension DetailProductVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collect = self.cltPhotos.dequeueReusableCell(withReuseIdentifier: "PhotoCollect", for: indexPath) as! PhotoCollect
        if indexPath.row == indexSelect {
            collect.imgCell.layer.borderWidth = 1.0
            collect.imgCell.layer.borderColor = CommonHelper.hexStringToUIColor(hex: COLOR_APP).cgColor
        }
        else{
            collect.imgCell.layer.borderWidth = 1.0
            collect.imgCell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        }
        collect.imgCell.sd_setImage(with: URL.init(string: "\(URL_IMAGE)\(self.arrPhotos[indexPath.row])")) { (image, error, type, url) in
            
        }
        return collect
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexSelect = indexPath.row
        self.cltPhotos.reloadData()
        self.imgCell.sd_setImage(with: URL.init(string: "\(URL_IMAGE)\(self.arrPhotos[indexPath.row])")) { (image, error, type, url) in
            
        }
    }
}
