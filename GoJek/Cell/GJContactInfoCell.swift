//
//  WUCarInfoCell.swift
//  WeSerVite
//
//  Created by sanjay on 05/08/18.
//  Copyright © 2017 sanjay chauhan. All rights reserved.
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
    nameLabel.text = data.firstName + " " + data.lastName
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

protocol FBTimeManagement {
  func getDate(timeStamp: Int, timeZone: String) -> String
  var dateFormat: String? { get set }
}
extension FBTimeManagement{
  func getDate(timeStamp: Int, timeZone: String) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: timeZone) //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = dateFormat//"HH:mm" //Specify your format that you want
    let time = dateFormatter.string(from: date)
    return time
  }
}
