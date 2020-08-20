//
//  CartCell.swift
//  Essentialss
//
//  Created by QTS Coder on 7/20/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {
     var tapDelete: (() ->())?
    var tapPlus: (() ->())?
    var tapMin: (() ->())?
    @IBOutlet weak var lblName1: UILabel!
    @IBOutlet weak var lblName2: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var lblNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func doPlus(_ sender: Any) {
        var number = Int(self.lblNumber.text!)!
        number = number + 1
        
        self.lblNumber.text = "\(number)"
        self.tapPlus?()
    }
    @IBAction func doMinu(_ sender: Any) {
        var number = Int(self.lblNumber.text!)!
        if number == 1 {
            
        }
        else{
            number = number - 1
        }
        
        self.lblNumber.text = "\(number)"
        self.tapMin?()
    }
    @IBAction func doDelete(_ sender: Any) {
        self.tapDelete?()
    }
}
