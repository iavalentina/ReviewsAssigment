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

enum NetworkResponse<T> {
    case success(T)
    case error(Error)
}

public struct Networking {
    
  let contentTypeHeader = ["Content-Type": "application/x-www-form-urlencoded"]
    
    func fetchCompanyDetails(_ completion:@escaping (NetworkResponse<Any>) -> Void) {
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
                        completion(NetworkResponse.success(company))
                    }
                case .failure(let error):
                    completion(NetworkResponse.error(error))
                }
        }
    }
    
    // Save the user review with parameters:
    // score, user name,
    func saveReview(_ review: Review?,
                    completion:@escaping (NetworkResponse<Any>) -> Void) {
        /*
         Form fields
         * score=3
         * companyId=ctyfiintu
         * comment=[user comment]
         * userName=[user name]

         */
        var parameters: [String: AnyObject] = [:]
        parameters["companyId"] = "ctyfiintu" as AnyObject
        if let score = review?.score {
            parameters["score"] = score as AnyObject
        }
    
        if let comment = review?.comment {
            parameters["comment"] = comment as AnyObject
        }
        
        if let userName = review?.userName {
            parameters["userName"] = userName as AnyObject
        }
        /*
         * X-HITTA-DEVICE-NAME: MOBILE_WEB
         * X-HITTA-SHARED-IDENTIFIER: 15188693697264027
         */
        var headers:[String: String] = contentTypeHeader
        headers["X-HITTA-DEVICE-NAME"] = "MOBILE_WEB"
        headers["X-HITTA-SHARED-IDENTIFIER"] = "15188693697264027"
        
        Alamofire.request(URLs.sandbox,
                          method: .post,
                          parameters: parameters,
                          encoding:  URLEncoding.default,
                          headers: headers)
            .validate()
            .responseData(completionHandler: { data in
                switch data.result {
                case .success:
                    completion(NetworkResponse.success(data.result))
                case .failure(let error):
                    completion(NetworkResponse.error(error))
                }
            })
    }
}
