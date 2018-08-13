//
//  WSProductDetailVIew.swift
//  WeSerVite
//
//  Created by Karthikaideepan on 9/19/17.
//  Copyright © 2017 sanjay chauhan. All rights reserved.
//

import UIKit

protocol GJContactDetailDelegate:class {
  func favouriteButtonClicked()
  func emailButtonClicked()
  func phoneButtonClicked()
  func messageButtonClicked()
  func cameraButtonClicked()
}

class GJContactDetailVIew: UIView, UIGestureRecognizerDelegate {
  
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
    self.messageButton.set(image: #imageLiteral(resourceName: "message"), attributedTitle: NSAttributedString(string: "message"), at: .bottom, width: 40, state: .normal)
    self.phoneButton.set(image: #imageLiteral(resourceName: "phone"), attributedTitle: NSAttributedString(string: "call"), at: .bottom, width: 40, state: .normal)
    self.mailButton.set(image: #imageLiteral(resourceName: "mail"), attributedTitle: NSAttributedString(string: "email"), at: .bottom, width: 40, state: .normal)
    self.favouriteButton.set(image:#imageLiteral(resourceName: "favourite"), attributedTitle: NSAttributedString(string: "favourite"), at: .bottom, width: 40, state: .normal)
    
    userImageView.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
    tap.delegate = self // This is not required
    userImageView.addGestureRecognizer(tap)
  }
 
  @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
    // handling code
    delegate?.cameraButtonClicked()
  }
  
  @IBAction func favouriteButtonClicked(_ sender: Any) {
    delegate?.favouriteButtonClicked()
  }
  
  @IBAction func emailButtonClicked() {
    delegate?.emailButtonClicked()
  }
  
  @IBAction func phoneButtonClicked() {
    delegate?.phoneButtonClicked()
  }
  @IBAction func messageButtonClicked() {
    delegate?.messageButtonClicked()
  }
  
  
  @IBAction func didSelectedOrder(_ sender:UIButton){
    
    //delegate?.orderNow(item!, photo.image!, name.text!)
  }
  @IBAction func didSelectedCancel(_ sender:UIButton){
    //delegate?.cancelNow(item!)
  }
}
