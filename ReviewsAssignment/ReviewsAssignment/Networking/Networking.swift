//
//  Networking.swift
//  ReviewsAssignment
//
//  Created by Valentina Iancu on 03/11/2018.
//  Copyright © 2018 Valentina Iancu. All rights reserved.
//

import Foundation
import Alamofire

enum URLs {
    static let companyUrl = "https://api.hitta.se/search/v7/app/company/ctyfiintu"
    static let sandbox = "https://test.hitta.se/reviews/v1/company" // POST - save reviews to Hitta.se sandbox environment
    /*
     POST
     https://test.hitta.se/reviews/v1/company
     Content-Type: application/x-www-form-urlencoded; charset=UTF-8
     
     Headers
     * X-HITTA-DEVICE-NAME: MOBILE_WEB
     * X-HITTA-SHARED-IDENTIFIER: 15188693697264027
     */
}

public typealias CompanyCompletionBlock = ((_ company: Company?, _ error: Error?) -> Void)
public typealias ServiceCompletionBlock = ((_ success: Bool, _ error: Error?) -> Void)

public struct Networking {
    
  let contentTypeHeader = ["Content-Type": "application/x-www-form-urlencoded"]
    /*
     * X-HITTA-DEVICE-NAME: MOBILE_WEB
     * X-HITTA-SHARED-IDENTIFIER: 15188693697264027
     */
    
    func fetchCompanyDetails(_ completion: @escaping CompanyCompletionBlock) {
        Alamofire.request(URLs.companyUrl,
                          method: .get,
                          encoding: URLEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    var jsonResponse = response.result.value as? [String: AnyObject]
                    if  let result = jsonResponse?["result"], let companiesJson = result["companies"] as? [String: AnyObject],
                        let companyJson =  companiesJson["company"] as? [[String: AnyObject]] {
                        let company = Company(json: companyJson[0])
                        completion(company, nil)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
    // Save the user review with parameters:
    // score, user name,
    func saveReview(parameters: [String: AnyObject]? = nil,
                    completion: @escaping ServiceCompletionBlock) {
        Alamofire.request(URLs.sandbox,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: contentTypeHeader)
            .validate()
            .responseJSON { response in
               completion(response.result.isSuccess, response.result.error)
        }
    }
}
