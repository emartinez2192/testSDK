//
//  testFramework.swift
//  testFramework
//
//  Created by Eduardo Martinez on 1/7/19.
//  Copyright © 2019 Eduardo Martinez. All rights reserved.
//

import Foundation
import Alamofire
//import SQLCipher



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
    
    
    /*
    public func testSQLCipher() {
    
        //na-at.testFramework
        var rc: Int32
        var db: OpaquePointer? = nil
        let manager = FileManager.default
        var stmt: OpaquePointer? = nil

        
        do {
           let documentsURL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("testDB.db")
           let bundleURL = Bundle(identifier: "na-at.testFramework")?.url(forResource: "testDB", withExtension: "db")
           rc = sqlite3_open_v2(documentsURL.path, &db, SQLITE_OPEN_READWRITE, nil)
            
            if (rc != SQLITE_OK) {
                let errmsg = String(cString: sqlite3_errmsg(db))
                NSLog("Error opening database: \(errmsg)")
                return
            }
            
            var is_sqlcipher = false;
            
            if(sqlite3_prepare_v2(db, "PRAGMA cipher_version;", -1, &stmt, nil) == SQLITE_OK) {
                if(sqlite3_step(stmt) == SQLITE_ROW) {
                    let ver = sqlite3_column_text(stmt, 0);
                    if(ver != nil) {
                        is_sqlcipher = true;
                    }
                }
                sqlite3_finalize(stmt);
            }
            print("is sqlcipher: \(is_sqlcipher)")
            
        }catch{
            print(error.localizedDescription)
        }
       
    
       
        
        /*
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
        
        
        //rc = sqlite3_key(db, password, Int32(password.utf8CString.count))
        //sqlite3_key(db, password, Int32(password.utf8CString.count)
        
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
        */
        
    }
    */
    
    
    
    
    
    
    
    
    
}
