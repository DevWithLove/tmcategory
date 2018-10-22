//
//  ProductTableViewCell.swift
//  TMCategory
//
//  Created by Tony Mu on 20/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {
  
  static let cellId = String(describing: type(of: ProductTableViewCell.self))
  static let height: CGFloat = 280.0
  
  @IBOutlet weak var picImageView: UIImageView!
  @IBOutlet weak var titleLabelView: UILabel!
  
  var viewModel: ProductCellViewModel? {
    didSet {
      guard let this = viewModel else { return }
      self.titleLabelView.text = this.title
      if let imageUrl = this.imageUrl {
        self.picImageView.sd_setImage(with: URL(string: imageUrl))
      }
    }
  }
  
  // MARK: UIView Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupViews()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  override func prepareForReuse() {
    self.picImageView.sd_cancelCurrentImageLoad()
    self.picImageView.image = nil
  }
  
  
  // MARK: Layout
  
  private func setupViews() {
    self.selectionStyle = UITableViewCell.SelectionStyle.none
    self.titleLabelView.font = UIFont.TitilliumWeb.semiBold
    self.titleLabelView.lineBreakMode = .byWordWrapping
    self.titleLabelView.numberOfLines = 0
    self.picImageView.contentMode = .center
  }
  
}
