//
//  RaitingView.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 06/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import Foundation
import UIKit

protocol RatingProtocol: class {
    func ratingButtonsPressed(with score: Int)
}

enum Stars: String {
    case one = "I hated it"
    case two = "I didn’t like it"
    case three = "It was OK"
    case four = "I liked it"
    case five = "I loved it"
    
   static func message(for score: Int) -> String {
        switch score {
        case 1:
            return Stars.one.rawValue
        case 2:
            return Stars.two.rawValue
        case 3:
            return Stars.three.rawValue
        case 4:
            return Stars.four.rawValue
        case 5:
            return Stars.five.rawValue
        default:
            break
        }
        return ""
    }
}

@IBDesignable
class RaitingView: UIView {
    
    @IBOutlet private var raitingCollection: [UIButton]!
    weak var delegate: RatingProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "RaitingView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func rateButtonPressesd(sender: UIButton) {
        guard let buttonIndex = raitingCollection.firstIndex(of: sender) else { return }
        setupView(for: buttonIndex)
        delegate?.ratingButtonsPressed(with: buttonIndex)
        if buttonIndex < raitingCollection.count - 1 {
            for index in buttonIndex+1...raitingCollection.count - 1 {
                raitingCollection[index].setImage(UIImage(named: "star_empty"), for: .normal)
            }
        }
    }
    
    func setupView(for buttonIndex: Int?) {
        guard let buttonIndex = buttonIndex else { return }
        for index in 0...buttonIndex {
            raitingCollection[index].setImage(UIImage(named: "star_filled_yellow"), for: .normal)
        }
    }
}
