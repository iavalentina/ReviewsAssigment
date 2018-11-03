//
//  ViewController.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 03/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Networking().fetchCompanyDetails { (company, error) in
            guard let company = company else { return}
            print("company =\(company.name)")
        }
    }
}

