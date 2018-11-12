//
//  ReviewCell.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 04/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import UIKit

protocol EditReviewProtocol: class {
    func editReviewPressed()
}

class ReviewCell: UITableViewCell {
    // IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private var ratingsCollection: [UIImageView]!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var editReviewButton: UIButton!
    @IBOutlet private weak var viewAllReviewsButton: UIButton!
    @IBOutlet private weak var userIcon: UIImageView!
    
    weak var delegate: EditReviewProtocol?

    func configureCell(with review: Review?, newReview: Bool = false, showTitle: Bool = false, lastCell: Bool = false) {
        titleLabel.text = newReview ? "Your review" : (showTitle ? "Latest reviews" : "")
        viewAllReviewsButton.isHidden = newReview || showTitle || !lastCell
        userNameLabel.text = review?.userName
        if let comment = review?.comment {
            commentLabel.text = comment
            commentLabel.textColor = UIColor.darkGreyCustom()
        } else {
            commentLabel.text = "Describe your experience"
            commentLabel.textColor = UIColor.azure()
        }
        
        editReviewButton.isHidden = !newReview
        if let time = review?.timeDescription, let platform = review?.platformReview {
            timeLabel.text = time + " - " + platform
        }
        
        if let platform = review?.platformReview, !platform.contains("hitta.se") {
            userIcon.image = UIImage(named: "other_person")
        } else {
            userIcon.image = UIImage(named: "person")
        }
        
        if let score = review?.score {
            configureRatingView(with: score)
        }
    }
    
    private func configureRatingView(with score: Int) {
        for index in 0..<score {
            ratingsCollection[index].image = UIImage(named: "star_filled_yellow")
        }
        
        for index in score..<ratingsCollection.count {
            ratingsCollection[index].image = UIImage(named: "star_filled_gray")
        }
    }
    
    // MARK: - Actions
    @IBAction func editReviewButtonPressed(_ sender: Any) {
        // should open the AddReviewViewController
        delegate?.editReviewPressed()
    }
}
