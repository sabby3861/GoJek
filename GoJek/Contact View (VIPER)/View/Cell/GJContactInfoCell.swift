//
//  WUCarInfoCell.swift
//  WeSerVite
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay chauhan. All rights reserved.
//

import UIKit
@IBDesignable
class GJContactInfoCell: UITableViewCell {
  
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var starImageView: UIImageView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  /// Display data on table view cell
  ///
  /// - Parameter data: GJContactInfo containing all info
  func displayData(data: GJContactInfo) {
    nameLabel.text = data.firstName! + " " + data.lastName!
    starImageView.isHidden = !data.favorite
    guard data.profilePic != nil else {
      return
    }
    let url = "\(baseUrl)\(data.profilePic!)"
    self.userImageView.loadImageUsingCacheWithURLString(url, placeHolder: #imageLiteral(resourceName: "NoImage"))
  }
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = cornerRadius > 0
    }
  }
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
}
