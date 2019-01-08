//
//  testFramework.swift
//  testFramework
//
//  Created by Eduardo Martinez on 1/7/19.
//  Copyright © 2019 Eduardo Martinez. All rights reserved.
//

import Foundation
import Alamofire


public class testFramework {
    
    public static let sharedInstance = testFramework()
   
    public func test (completion:@escaping (String)->Void) {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                //print("Data: \(utf8Text)") // original server data as UTF8 string
                completion(utf8Text)
            }
        }
    }
    
    
    
    
    
}
