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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet var ratingsCollection: [UIImageView]!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var editReviewButton: UIButton!
    
    weak var delegate: EditReviewProtocol?

    func configureCell(with review: Review?, newReview: Bool = false, showTitle: Bool = false) {
        titleLabel.text = newReview ? "Your review" : (showTitle ? "Latest reviews" : "")
        userNameLabel.text = review?.userName
        commentLabel.text = review?.comment
        editReviewButton.isHidden = !newReview
    }
    
    // MARK: - Actions
    @IBAction func editReviewButtonPressed(_ sender: Any) {
        // should open the AddReviewViewController
        delegate?.editReviewPressed()
    }
    
}
