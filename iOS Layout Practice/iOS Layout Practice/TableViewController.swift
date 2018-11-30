//
//  TableViewController.swift
//  iOS Layout Practice
//
//  Created by Anderson, Jevin on 11/29/18.
//  Copyright © 2018 Anderson, Jevin. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, menuDelegate {
  @IBOutlet weak var menuView: menu! {
    didSet {
      menuView.delegate = self
    }
  }
  
  func onMenuBack(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  func menuLabel() -> String {
    return "TableViewController"
  }
  
  override func viewDidLoad() {
    
  }
}
