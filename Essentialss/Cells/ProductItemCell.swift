//
//  ProductItemCell.swift
//  Essentialss
//
//  Created by QTS Coder on 7/20/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit
import SDWebImage
class ProductItemCell: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewPrice: UIView!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var btnAdd: UIButton!
    var tapAddProduct: (() ->())?
    @IBOutlet weak var viewSaleOff: UIView!
    @IBOutlet weak var lblSaleOff: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func doAdd(_ sender: Any) {
        self.tapAddProduct?()
    }
    
    func configCell(_ productObj: productObj)
    {
        self.lblName.text = productObj.name.trim()
        if productObj.discount == "0.0" || productObj.discount.isEmpty || productObj.discount == "0"
        {
            self.viewSaleOff.isHidden = true
            self.lblDiscount.text = ""
            self.lblPrice.text = String.init(format: "%0.2f aed", Double(productObj.price))
            self.viewPrice.isHidden = true
        }
        else{
            self.viewPrice.isHidden = false
            self.viewSaleOff.isHidden = false
            self.lblSaleOff.text = "\(productObj.discount)%"
            let value = productObj.price - (productObj.price * (Double(productObj.discount)!/100))
            self.lblDiscount.text =  String.init(format: "%0.2f aed", value)
            self.lblPrice.text =  String.init(format: "%0.2f aed", Double(productObj.price))
        }
       
//        let data = productObj.image.data(using: .utf8)
//
//        do{
//            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String]
//
//            if let first = json?[0]
//            {
//
//            }
//        }catch _{
//
//        }
        if productObj.image.count > 0 {
            self.imgCell.sd_setImage(with: URL.init(string: "\(URL_IMAGE)\(productObj.image[0])")) { (image, error, type, url) in
                
            }
        }
        if HelperCart.checkProductExit(productObj)
        {
            self.btnAdd.setTitle("Added", for: .normal)
        }
        else{
            self.btnAdd.setTitle("Add", for: .normal)
        }
    }
}
