//
//  RateAndReviewCell.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 04/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import UIKit

protocol RatingProtocol: class {
    func ratingButtonsPressed()
}

class RateAndReviewCell: UITableViewCell {
    weak var delegate: RatingProtocol?
    
    @IBOutlet var ratingButtons: [UIButton]!
    
    @IBAction func rateButtonPressesd(sender: UIButton) {
        guard let buttonPressedIndex = ratingButtons.firstIndex(of: sender) else { return }
        for index in 0...buttonPressedIndex {
            ratingButtons[index].setImage(UIImage(named: "star_filled_yellow"), for: .normal)
        }
        delegate?.ratingButtonsPressed()
//        if buttonPressedIndex < ratingButtons.count - 1 {
//            for index in buttonPressedIndex+1...ratingButtons.count - 1 {
//                ratingButtons[index].setImage(UIImage(named: "star_empty"), for: .normal)
//            }
//        }
    }
    
}
