//
//  GJImageCache.swift
//  GoJek
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
  
  func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?) {
    
    self.image = nil
    if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
      self.image = cachedImage
      return
    }
    if let url = URL(string: URLString) {
      URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, response, error) in
        if error != nil {
          print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
          DispatchQueue.main.async {
            self?.image = placeHolder
          }
          return
        }
        DispatchQueue.main.async {
          if let data = data {
            if let downloadedImage = UIImage(data: data) {
              imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
              self?.image = downloadedImage
              /*if let strongSelf = self {
                let width = strongSelf.bounds.width
                let height = strongSelf.bounds.height
                
                let resizedImage = resizeImage(downloadedImage, newWidth: width, newHeight: height)
                
                strongSelf.image = resizedImage
              }*/
            }else{
              self?.image = placeHolder
            }
          }else{
            self?.image = placeHolder
          }
        }
      }).resume()
    }
  }
}


func resizeImage(_ image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
  let size = CGSize(width: newWidth, height: newHeight)
  
  UIGraphicsBeginImageContext(size)
  
  let rect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
  image.draw(in: rect)
  
  let newImage = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()
  
  return newImage!
}
