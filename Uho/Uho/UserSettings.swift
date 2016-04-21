//
//  UserSettings.swift
//  Uho
//
//  Created by Pawan Jat on 08/04/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation

class UserSettings {
    var anger:String = ""
    init(data: NSDictionary){
        self.anger = data.valueForKey("anger") as! String
    }
}