//
//  ProductCollect.swift
//  Essentialss
//
//  Created by Colin Ngo on 7/19/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit
import SDWebImage
class ProductCollect: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configCell(_ subObj: subCategoryObj)
    {
        self.lblName.text = subObj.name
        self.imgCell.sd_setImage(with: URL.init(string: "\(URL_IMAGE)\(subObj.image)")) { (image, error, type, url) in
            
        }
    }
}
