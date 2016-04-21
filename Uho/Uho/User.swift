//
//  User.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation


class User {
    
    var fbToken = ""
    var userId = ""

    var postReport: PostReport? = nil
    var pushToken = ""
//    var settings:UserSettings;
    func dictionaryRepresentation() -> Dictionary<String,AnyObject>? {
        
        var dictRep = Dictionary<String,AnyObject>()
        dictRep["fbToken"] = fbToken
        dictRep["pushToken"] = pushToken
        return dictRep
        
    }
//    
//    init(data : NSDictionary) {
//        self.settings = UserSettings(data: data.valueForKey("settings") as! NSDictionary)
//    }
}