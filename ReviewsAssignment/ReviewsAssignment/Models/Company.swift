//
//  Company.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 03/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import Foundation

open class Company {
    var name: String?
    var companyID: String?
    
    convenience init(json: [String: AnyObject]) {
        self.init()
        name = json["displayName"] as? String ?? ""
        companyID = json["id"] as? String ?? ""
    }
}
