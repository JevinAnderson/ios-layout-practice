//
//  PromotionsHubView.swift
//  iOS Layout Practice
//
//  Created by Anderson, Jevin on 12/3/18.
//  Copyright © 2018 Anderson, Jevin. All rights reserved.
//

import UIKit

protocol PromotionsHubViewDelegate : class {
  func updatePromotionsHubViewConstraints(_ promotionsHubView: PromotionsHubView)
}

class PromotionsHubView: UIView, HubModelDelegate, UITableViewDataSource {
  @IBOutlet weak var promotionsTableViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var toggleButton: UIButton!
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var promotionsTableView: UITableView! {
    didSet {
      promotionsTableView.dataSource = self
    }
  }
  
  weak var delegate: PromotionsHubViewDelegate?
  
  var height: Int {
    get {
      return expanded ? 600 : 300
    }
  }
  
  var loading: Bool {
    get {
      return HubModel.shared.promotions == nil
    }
  }
  
  private var expanded = false {
    didSet {
      animating = true
      
      UIView.animate(withDuration: 0.6, animations: {
        self.toggleButton.transform = self.toggleButton.transform.rotated(by: CGFloat(Double.pi))
      }) { _ in
        let title = self.expanded ? "Hide Details": "Show Details"
        self.toggleButton.setTitle(title, for: UIControl.State.normal)
        self.animating = false
      }
    }
  }
  private var animating = false
  
  var promotions: [Promotion] {
    get {
      guard let results =  HubModel.shared.promotions else { return [] }
      
      return results
    }
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard loading != true else {return 0}
    
    if expanded {
      return promotions.count
    }else {
      return 2
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "PromotionsHubView")
    
    if cell === nil {
      cell = UITableViewCell(style: .value1, reuseIdentifier: "PromotionsHubView")
    }
    
    let promotion = promotions[indexPath.row]
    cell!.textLabel?.text = promotion.title
    cell!.detailTextLabel?.text = promotion.description
    
    return cell!
  }
  
  @IBAction func onToggleExpand(_ sender: UIButton) {
    guard animating != true else { return }
    
    expanded = !expanded
    updateView()
  }
  
  private func updateView() {
    guard loading == false else { return }
    
    promotionsTableView.reloadData()
    toggleButton.isHidden = loading
    self.promotionsTableViewHeightConstraint.constant = expanded ? 500 : 200
    delegate?.updatePromotionsHubViewConstraints(self)
  }
  
  func onModelUpdate(_ hub: HubModel) {
    updateView()
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
    Bundle.main.loadNibNamed("PromotionsHubView", owner: self, options: nil)
    addSubview(contentView)
    HubModel.shared.addObserver(self)
    updateView()
  }
}
