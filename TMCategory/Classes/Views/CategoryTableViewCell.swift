//
//  CotegoryTableViewCell.swift
//  TMCategory
//
//  Created by Tony Mu on 17/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
  
  static let cellId = String(describing: type(of: CategoryTableViewCell.self))
  
  var viewModel: CategoryViewModel? {
    didSet {
      guard let this = viewModel else { return }
      iconLabel.text = this.type.icon
      nameLabel.text = this.name + " " + this.type.rawValue
    }
  }
  
  @IBOutlet weak var iconLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  
  // MARK: UIView Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupViews()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  
  // MARK: Layout
  private func setupViews() {
    self.selectionStyle = UITableViewCell.SelectionStyle.none
    nameLabel.font = UIFont.TitilliumWeb.semiBold.withSize(14)
    iconLabel.font = UIFont.Icon.regular.withSize(16)
  }
}
