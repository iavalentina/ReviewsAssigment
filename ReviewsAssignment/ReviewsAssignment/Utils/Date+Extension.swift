//
//  Date+Extension.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 11/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import Foundation

extension Date {
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        
        guard let timeString = formatter.string(from: self, to: Date()) else {
            return nil
        }
        
        let formatString = NSLocalizedString("%@ ago", comment: "")
        return String(format: formatString, timeString)
    }
}
