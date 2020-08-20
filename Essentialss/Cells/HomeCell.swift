//
//  HomeCell.swift
//  Essentialss
//
//  Created by Colin Ngo on 7/19/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
