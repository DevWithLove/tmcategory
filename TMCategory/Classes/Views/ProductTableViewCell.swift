//
//  ProductTableViewCell.swift
//  TMCategory
//
//  Created by Tony Mu on 20/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
  
  static let cellId = String(describing: type(of: ProductTableViewCell.self))
  static let height: CGFloat = 280.0
  static let imageCache = NSCache<NSString, UIImage>()
  
  @IBOutlet weak var picImageView: UIImageView!
  @IBOutlet weak var titleLabelView: UILabel!
  
  var viewModel: ProductCellViewModel? {
    didSet {
      guard let this = viewModel else { return }
      self.titleLabelView.text = this.title
      if let imageUrl = this.imageUrl {
        loadImageFromUrl(urlString: imageUrl)
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
  
  
  // MARK: Layout
  
  private func setupViews() {
    self.selectionStyle = UITableViewCell.SelectionStyle.none
    self.titleLabelView.font = UIFont.TitilliumWeb.semiBold
    self.titleLabelView.lineBreakMode = .byWordWrapping
    self.titleLabelView.numberOfLines = 0
    self.picImageView.contentMode = .center
  }
  
  private func loadImageFromUrl(urlString: String) {
    
    self.picImageView.image = nil

    let urlKey = urlString as NSString
    
    if let cachedItem = ProductTableViewCell.imageCache.object(forKey: urlKey) {
      return self.picImageView.image = cachedItem
    }
    
    guard let url = URL(string: urlString) else {
      return
    }
    
    URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, response, error) in
      
      if error != nil {
        return
      }
      
      DispatchQueue.main.async {
        if let image = UIImage(data: data!) {
          ProductTableViewCell.imageCache.setObject(image, forKey: urlKey)
          self?.picImageView.image = image
        }
      }
      
    }).resume()
  }
}
