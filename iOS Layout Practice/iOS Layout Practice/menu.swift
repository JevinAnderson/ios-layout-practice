//
//  menu.swift
//  iOS Layout Practice
//
//  Created by Anderson, Jevin on 11/29/18.
//  Copyright © 2018 Anderson, Jevin. All rights reserved.
//

import UIKit

protocol menuDelegate: class {
  func onMenuBack(_ sender: UIButton)
  func menuLabel() -> String
}

class menu: UIView {
  weak var delegate: menuDelegate? {
    didSet {
      guard let d = delegate else {
        return
      }
      
      locationLabel.text = d.menuLabel()
    }
  }
  
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var backBtn: UIButton!
  @IBOutlet weak var locationLabel: UILabel!
  @IBAction func backBtnTapped(_ sender: UIButton) {
    delegate?.onMenuBack(sender)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    Bundle.main.loadNibNamed("menu", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
}
