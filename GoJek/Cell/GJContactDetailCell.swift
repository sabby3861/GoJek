//
//  WUCarInfoCell.swift
//  WeSerVite
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit
class GJContactDetailCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var infoTextField: UITextField!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  /// Display data on table view cell
  ///
  /// - Parameter data: WUPlaceMark containing all info
  func displayData(data: GJContactDetailInfo, enabled: Bool) {
    titleLabel.text = data.key
    infoTextField.text = data.value
    infoTextField.isEnabled = enabled
  }
}

