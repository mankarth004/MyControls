//
//  DialPadCell.swift
//  DialPad
//
//  Created by SmartNet-MacBookPro on 10/8/18.
//  Copyright © 2018 kartheek.in. All rights reserved.
//

import UIKit
protocol DialPadCellDelegate: class {
    func buttonClicked(_ sender: UIButton)
}

class DialPadCell: UICollectionViewCell {

    var delegate: DialPadCellDelegate!
    
    @IBOutlet weak var btnNumber: UIButton!
    
    @IBAction func btnNumberAction(_ sender: UIButton) {
        delegate.buttonClicked(sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
