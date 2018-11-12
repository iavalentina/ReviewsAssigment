//
//  UIViewController+Extension.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 12/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import UIKit
extension UIViewController {
    func presentAlertView(handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: "Thank you for your review",
                                                message: "You’re helping others make smarter decisions every day.",
                                                preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Okay!", style: .default, handler: handler)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
