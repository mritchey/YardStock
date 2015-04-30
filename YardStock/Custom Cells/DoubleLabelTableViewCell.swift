//
//  DoubleLabelTableViewCell.swift
//  YardStock
//
//  Created by Megan Ritchey on 4/30/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit

class DoubleLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
