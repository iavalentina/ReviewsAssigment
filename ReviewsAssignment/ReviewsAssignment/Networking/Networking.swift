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
}

public typealias CompanyCompletionBlock = ((_ company: Company?, _ error: Error?) -> Void)

public struct Networking {
    
    var headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    func fetchCompanyDetails(_ completion: @escaping CompanyCompletionBlock){
        var serviceError: Error? = nil
        Alamofire.request(URLs.companyUrl,
                          method: .get,
                          encoding: URLEncoding.default)
            .responseJSON { response in
                let result = response.result
                if result.isSuccess, let resultValue = result.value {
                    var jsonResponse = resultValue as? [String: AnyObject]
                    if  let result = jsonResponse?["result"], let companiesJson = result["companies"] as? [String: AnyObject],
                        let companyJson =  companiesJson["company"] as? [[String: AnyObject]] {
                        let company = Company(json: companyJson[0])
                        completion(company, nil)
                    }
                } else{
                    serviceError = response.error
                    print("Error request: \(String(describing: response.error))")
                }
        }
        completion(nil, serviceError)
    }
}
