//
//  ReviewsViewController.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 03/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import UIKit
import Alamofire

class ReviewsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    private var company: Company?
    var latestReviews: [Review] = []
    var userReview: Review?
    
    fileprivate var dataArray: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        loadData()
        latestReviewData()
        
        
        Networking().fetchCompanyDetails {  [weak self] result in
            switch result {
            case .success(let json):
                guard let company = json as? Company else { return }
                self?.company = company
                self?.tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
        registerCellNibs()
    }
    
    private func registerCellNibs() {
        tableView.register(UINib(nibName: "CompanyViewCell", bundle: nil), forCellReuseIdentifier: "CompanyViewCell")
        tableView.register(UINib(nibName: "ReviewsHeaderViewCell", bundle: nil), forCellReuseIdentifier: "ReviewsHeaderViewCell")
        tableView.register(UINib(nibName: "RateAndReviewCell", bundle: nil), forCellReuseIdentifier: "RateAndReviewCell")
        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
    }
    
    private func latestReviewData() {
        
        latestReviews.append(Review(score: 4,
                                    userName: "Anonymus",
                                    comment: "Liked it very much - probably one of the best thai restaurants in the city - recommend!",
                                    timeAdded: Calendar.current.date(byAdding: .hour, value: -12, to: Date()),
                                    platformReview: "hitta.se"))
        latestReviews.append(Review(score: 3,
                                    userName: "Jenny Svensson",
                                    comment: "Maybe a bit too fast food. I personally dislike that. Good otherwise.",
                                    timeAdded: Calendar.current.date(byAdding: .day, value: -1, to: Date()),
                                    platformReview: "hitta.se"))
        latestReviews.append(Review(score: 5,
                                    userName: "happy56",
                                    comment: "Super good! Love the food!",
                                    timeAdded: Calendar.current.date(byAdding: .day, value: -1, to: Date()),
                                    platformReview: "yelp.com"))
        
    }
    
    func loadData() {
        dataArray.append(company?.name ?? "")
        dataArray.append("Reviews")
        dataArray.append("RateAndReview")
    }
}

// MARK: TableViewDataSource
extension ReviewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count + latestReviews.count // company name, reviews header, rate and review/your review, 3 latests reviews +first cell one label for title of the section + last cell button
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // on first cell needs to display company name
        if indexPath.row < dataArray.count {
            if indexPath.row == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyViewCell") as? CompanyViewCell {
                cell.compayNameLabel.text = company?.name
                return cell
            }
            
            // second cell will show an header for Reviews part
            if indexPath.row == 1, let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsHeaderViewCell")  {
                return cell
            }
            // third cell Rate and Review Cell
            if indexPath.row == 2, let cell = tableView.dequeueReusableCell(withIdentifier: "RateAndReviewCell") as? RateAndReviewCell  {
                cell.ratitingView.delegate = self
                return cell
            }
        }
        
        let reviewIndex =  indexPath.row - dataArray.count
        // Latest reviews
        if reviewIndex <= latestReviews.count,
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as? ReviewCell  {
            // show title only if is the first review
            // else if it's last cell show the View all reviews button
            
            cell.configureCell(with: latestReviews[reviewIndex],
                               showTitle: (reviewIndex == 0),
                               lastCell: reviewIndex == latestReviews.count - 1)
            return cell
        }
        
        // cell with the View all reviews
        return UITableViewCell()
    }
}

// MARK: - Other Protocols
extension ReviewsViewController: RatingProtocol {
    func ratingButtonsPressed(with buttonIndex: Int) {
        let score = buttonIndex + 1
        let review = Review(score: score)
        let viewController = AddReviewViewController(nibName: "AddReviewViewController", bundle: nil)
        viewController.setupView(with: company, review: review)
        viewController.delegate = self
        navigationController?.present(viewController, animated: false)
    }
}

extension ReviewsViewController: AddReviewProtocol {
    func viewDismissed(with review: Review?) {
        userReview = review
        // replace the third cell with Your Review
//        let indexPath = IndexPath(item: 2, section: 0)
//        tableView.deleteRows(at: [indexPath], with: .fade)
//        tableView.insertRows(at: [indexPath], with: .fade)
//        tableView.reloadRowsAtIndexPaths(paths, withRowAnimation: UITableViewRowAnimation.None)
    }
}
