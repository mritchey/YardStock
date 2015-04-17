//
//  InfoCellTableViewCell.swift
//  YardStock
//
//  Created by Randall Lee Schilling on 4/15/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit

class InfoCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stockyardNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var livestockLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
