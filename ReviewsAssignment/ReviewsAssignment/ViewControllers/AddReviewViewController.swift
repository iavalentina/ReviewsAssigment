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

let textFiledPlaceholder = "Add more details on your experience..."

class AddReviewViewController: UIViewController {

    @IBOutlet weak var raitingView: RaitingView?
    @IBOutlet weak var titleLabel: UILabel?
    weak var delegate: AddReviewProtocol?
    private var currentCompany: Company?
    private var currentReview: Review?
    @IBOutlet weak var scoreString: UILabel!
    
    @IBOutlet weak var userNameTextView: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel?.text = currentCompany?.name ?? ""
        
        raitingView?.delegate = self
        if let score = currentReview?.score {
            let buttonIndex =  score - 1
            raitingView?.setupView(for: buttonIndex)
            scoreString.text = Stars.message(for: score)
        }
        setupTextViewPlaceholder()
    }
    
    func setupView(with company: Company?, review: Review?) {
        currentCompany = company
        currentReview = review
    }
    
    // MARK: - Actions
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: false) {
            self.delegate?.viewDismissed(with: self.currentReview)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if userNameTextView.text != "" {
            currentReview?.userName = userNameTextView.text
        } else {
            currentReview?.userName = "Anonymous"
        }
        
        if commentTextView.text != "" && commentTextView.text != textFiledPlaceholder {
            currentReview?.comment = commentTextView.text
        }
        
        // Send the response
        Networking().saveReview(currentReview) { [weak self] result in
            switch result {
            case .success(let json):
                print(json)
            case .error(let error):
                print(error.localizedDescription)
            }
            self?.presentAlertView(handler: { [weak self]_ in
                self?.dismiss(animated: false) {
                    self?.delegate?.viewDismissed(with: self?.currentReview)
                }})
        }
    }
    
    fileprivate func setupTextViewPlaceholder() {
        commentTextView.text = textFiledPlaceholder
        commentTextView.textColor = UIColor.warmGrey()
    }
}

// MARK: - Delegates
extension AddReviewViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if commentTextView.textColor == UIColor.warmGrey() {
            commentTextView.text = ""
            commentTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if commentTextView.text == "" {
          setupTextViewPlaceholder()
        }
    }
}

extension AddReviewViewController: RatingProtocol {
    func ratingButtonsPressed(with scoreButtonIndex: Int) {
        raitingView?.setupView(for: scoreButtonIndex)
        let score = scoreButtonIndex + 1
        scoreString.text = Stars.message(for: score)
        currentReview?.score = score
    }
}

