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
}

@IBDesignable
class RaitingView: UIView {
    
    @IBOutlet var raitingCollection: [UIButton]!
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
        guard let score = raitingCollection.firstIndex(of: sender) else { return }
        setupView(with: score)
        delegate?.ratingButtonsPressed(with: score)
        if score < raitingCollection.count - 1 {
            for index in score+1...raitingCollection.count - 1 {
                raitingCollection[index].setImage(UIImage(named: "star_empty"), for: .normal)
            }
        }
    }
    
    func setupView(with score: Int?) {
        guard let score = score else { return }
        for index in 0...score {
            raitingCollection[index].setImage(UIImage(named: "star_filled_yellow"), for: .normal)
        }
    }
}
