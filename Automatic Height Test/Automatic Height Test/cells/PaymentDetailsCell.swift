//
//  PaymentDetailsCell.swift
//  Automatic Height Test
//
//  Created by Anderson, Jevin on 2/24/19.
//  Copyright © 2019 Anderson, Jevin. All rights reserved.
//

import UIKit

class PaymentDetailsCell: UITableViewCell {
  
  @IBOutlet weak var contentLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
