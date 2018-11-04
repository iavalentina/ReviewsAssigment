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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        latestReviewData()
        
        Networking().fetchCompanyDetails { [weak self] (company, error) in
            guard let company = company else { return }
            self?.company = company
            self?.tableView.reloadData()
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
                                     timeAdded: nil))
        latestReviews.append(Review(score: 3,
                                     userName: "Jenny Svensson",
                                     comment: "Maybe a bit too fast food. I personally dislike that. Good otherwise.",
                                     timeAdded: nil))
        latestReviews.append(Review(score: 5,
                                     userName: "happy56",
                                     comment: "Super good! Love the food!",
                                     timeAdded: nil))
        
    }
}


extension ReviewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestReviews.count + 3 // company name, reviews header, rate and review/your review, 3 latests reviews +first cell one label for title of the section + last cell button
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // on first cell needs to display company name
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
            cell.delegate = self
            return cell
        }
        
        // Latest reviews
        if indexPath.row - 3 <= latestReviews.count,
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as? ReviewCell  {
            // show title only if is the first review
            cell.configureCell(with: latestReviews[indexPath.row - 3], showTitle: (indexPath.row - 3 == 0))
            return cell
        }
        
        return UITableViewCell()
    }
}
extension ReviewsViewController: RatingProtocol {
    func ratingButtonsPressed() {
        let vc = AddReviewViewController(nibName: "AddReviewViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: false)
    }
}
