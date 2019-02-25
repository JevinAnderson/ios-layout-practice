//
//  PromotionCellModel.swift
//  Automatic Height Test
//
//  Created by Anderson, Jevin on 2/24/19.
//  Copyright © 2019 Anderson, Jevin. All rights reserved.
//

import Foundation

struct PromotionCellModel {
  let details: String
  
  func configureCell(_ cell: PromotionCell) {
    cell.promotionDetails.text = details
  }
}
