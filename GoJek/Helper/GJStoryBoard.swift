
//
//  WSStoryBoard.swift
//  GoJek
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2017 sanjay chauhan. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    enum Storyboard: String {
        case Main
        var filename: String {
            return rawValue.capitalized
        }
    }
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    func instantiateVieController<T>() -> T where T: StoryboardIdentifiable {
        
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
  
}


protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable{}


