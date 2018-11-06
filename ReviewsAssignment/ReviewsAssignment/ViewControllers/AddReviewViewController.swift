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
    private var previousRating: Int = 0
    private var currentCompany: Company?
    private var currentReview =  Review()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationController?.navigationBar.backgroundColor = UIColor.NavibationBarBlue()
        // Do any additional setup after loading the view.
        titleLabel?.text = currentCompany?.name ?? ""
        raitingView?.setupView(with: previousRating)
    }
    
    func setupView(with company: Company?, score:Int) {
        currentCompany = company
        previousRating = score
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: false) {
            self.delegate?.viewDismissed(with: self.currentReview)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        dismiss(animated: false) {
            self.delegate?.viewDismissed(with: self.currentReview)
        }
    }
}
