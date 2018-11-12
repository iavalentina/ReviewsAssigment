//
//  Review.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 03/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import Foundation

let defaultPlatformReview = "hitta.se"

struct Review {
    var score: Int?
    var userName: String?
    var comment: String?
    var timeAdded: Date?
    var platformReview: String?
    
    init(score: Int?  = nil,
         userName: String? = "Anonymous",
         comment: String? = nil,
         timeAdded: Date? = Date(),
         platformReview: String? = defaultPlatformReview) {
        self.score = score
        self.userName = userName
        self.comment = comment
        self.timeAdded = timeAdded
        self.platformReview = platformReview
    }
    
    /*
     Form fields
     * score=3
     * companyId=ctyfiintu
     * comment=[user comment]
     * userName=[user name]
     */
}
