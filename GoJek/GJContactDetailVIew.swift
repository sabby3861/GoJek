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
  @IBOutlet weak var photo:UIImageView!
  @IBOutlet weak var name:UILabel!
  @IBOutlet weak var detail:UITextView!
  
  
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
  func setItem(){
    
  }
  
  @IBAction func didSelectedOrder(_ sender:UIButton){
    
    //delegate?.orderNow(item!, photo.image!, name.text!)
  }
  @IBAction func didSelectedCancel(_ sender:UIButton){
    //delegate?.cancelNow(item!)
  }
}
