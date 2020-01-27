//
//  TransactionTableViewCell.swift
//  MVP Coding Demo
//
//  Created by Sumit Parmar on 19/01/20.
//  Copyright © 2020 Sumit Parmar. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {


    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var subTypeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func prepareData(modal : TransactionHistory) {
        if let type = modal.type {
            typeLabel.text = type
        }
        if let subType = modal.subType {
            subTypeLabel.text = subType
        }
    }

}
