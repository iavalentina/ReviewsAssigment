//
//  UITextField+Extension.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 13/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
