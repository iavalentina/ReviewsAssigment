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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
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
    }
}


extension ReviewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 // company name, reviews header, rate and review/your review, 3 latests reviews +first cell one label for title of the section + last cell button
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
        return UITableViewCell()
    }
}

