//
//  WSProductDetailVIew.swift
//  WeSerVite
//
//  Created by Karthikaideepan on 9/19/17.
//  Copyright © 2017 sanjay chauhan. All rights reserved.
//

import UIKit

protocol GJContactDetailDelegate:class {
  //func orderNow(_ item:WSMenuChoice, _ image: UIImage, _ name: String)
  func cancelNow()
}

class GJContactDetailVIew: UIView {
  
  weak var delegate: GJContactDetailDelegate?
 
  @IBOutlet weak var userImageView: GJImageView!
  
  @IBOutlet weak var messageButton: UIButton!
  
  @IBOutlet weak var phoneButton: UIButton!
  
  @IBOutlet weak var mailButton: UIButton!
  
  @IBOutlet weak var favouriteButton: UIButton!
  
  static func initWithNIb() -> GJContactDetailVIew{
    let view = UINib(nibName: "GJContactDetailVIew", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! GJContactDetailVIew
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowOffset = CGSize.zero
    view.layer.shadowRadius = 4
    view.layer.cornerRadius = 3
    view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    view.layer.borderColor = view.backgroundColor?.cgColor
    return view
    
  }
  override func awakeFromNib(){
    super.awakeFromNib()
    self.messageButton.set(image: #imageLiteral(resourceName: "message"), attributedTitle: NSAttributedString(string: "Message"), at: .bottom, width: 40, state: .normal)
    self.phoneButton.set(image: #imageLiteral(resourceName: "phone"), attributedTitle: NSAttributedString(string: "Message"), at: .bottom, width: 40, state: .normal)
    self.mailButton.set(image: #imageLiteral(resourceName: "mail"), attributedTitle: NSAttributedString(string: "Message"), at: .bottom, width: 40, state: .normal)
    self.favouriteButton.set(image:#imageLiteral(resourceName: "favourite"), attributedTitle: NSAttributedString(string: "Message"), at: .bottom, width: 40, state: .normal)
    
  }
 
  @IBAction func favouriteButtonClicked(_ sender: Any) {
  }
  
  @IBAction func emailButtonClicked() {
  }
  
  @IBAction func phoneButtonClicked() {
  }
  @IBAction func messageButtonClicked() {
  }
  
  
  @IBAction func didSelectedOrder(_ sender:UIButton){
    
    //delegate?.orderNow(item!, photo.image!, name.text!)
  }
  @IBAction func didSelectedCancel(_ sender:UIButton){
    //delegate?.cancelNow(item!)
  }
}
