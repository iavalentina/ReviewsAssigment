//
//  AddReviewViewController.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 04/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import UIKit

protocol AddReviewProtocol:class {
    func viewDismissed(with review: Review?)
}

class AddReviewViewController: UIViewController {

    @IBOutlet weak var raitingView: RaitingView?
    @IBOutlet weak var titleLabel: UILabel?
    weak var delegate: AddReviewProtocol?
    private var currentCompany: Company?
    private var currentReview: Review?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel?.text = currentCompany?.name ?? ""
        raitingView?.setupView(with: currentReview?.score)
    }
    
    func setupView(with company: Company?, review: Review?) {
        currentCompany = company
        currentReview = review
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: false) {
            self.delegate?.viewDismissed(with: self.currentReview)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        // Send the response
        dismiss(animated: false) {
            self.delegate?.viewDismissed(with: self.currentReview)
        }
    }
}
