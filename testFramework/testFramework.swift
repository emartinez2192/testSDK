//
//  testFramework.swift
//  testFramework
//
//  Created by Eduardo Martinez on 1/7/19.
//  Copyright © 2019 Eduardo Martinez. All rights reserved.
//

import Foundation
import Alamofire
import SQLCipher
import SQLite3



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
    
    
    public func testSQLCipher() {
    
        var rc : Int32
        var db : OpaquePointer?
        var stmt : OpaquePointer?
        let password : String = "password"
        rc = sqlite3_open(":memory:", &db)
        if (rc != SQLITE_OK) {
            let errmsg = String(cString: sqlite3_errmsg(db))
            NSLog("Error opening database: \(errmsg)")
            return
        }
        
        rc = sqlite3_key(db, password, Int32(password.utf8CString.count))
            //sqlite3_key(db, password, Int32(password.utf8CString.count))
        if (rc != SQLITE_OK) {
            let errmsg = String(cString: sqlite3_errmsg(db))
            NSLog("Error setting key: \(errmsg)")
        }
        rc = sqlite3_prepare(db, "PRAGMA cipher_version;", -1, &stmt, nil)
        if (rc != SQLITE_OK) {
            let errmsg = String(cString: sqlite3_errmsg(db))
            NSLog("Error preparing SQL: \(errmsg)")
        }
        rc = sqlite3_step(stmt)
        if (rc == SQLITE_ROW) {
            NSLog("cipher_version: %s", sqlite3_column_text(stmt, 0))
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            NSLog("Error retrieiving cipher_version: \(errmsg)")
        }
        sqlite3_finalize(stmt)
        sqlite3_close(db)
        
        
    }
    
    
    
    
    
    
    
    
}
