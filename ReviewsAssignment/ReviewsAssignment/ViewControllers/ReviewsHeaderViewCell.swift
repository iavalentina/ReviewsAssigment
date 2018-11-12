//
//  ReviewsHeaderViewCell.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 04/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import UIKit

class ReviewsHeaderViewCell: UITableViewCell {
    
    @IBOutlet private weak var raitingBoxView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        raitingBoxView.layer.cornerRadius = 8
        raitingBoxView.layer.masksToBounds = true
    }
}
