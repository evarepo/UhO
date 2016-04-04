//
//  AppSettings.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation

class AppSettings {
    
    var monitoring = true
    var pushNotifications = true
    
    var angerTolerance:Float = 0.5
    var disgustTolerance:Float = 0.3
    var sadnessTolerance:Float = 0.7
    
    
    
    init(){
        
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        var settingsDict = userDefaults.dictionaryForKey("appSettings");
        
        if ( settingsDict == nil ){
            
            monitoring = true
            pushNotifications = true
            
            angerTolerance = 0.5
            disgustTolerance = 0.3
            sadnessTolerance = 0.7
            
            save()
        }
        else{
            
            monitoring = settingsDict!["monitoring"] as! Bool
            pushNotifications = settingsDict!["pushNotifications"] as! Bool
            angerTolerance = settingsDict!["angerTolerance"] as! Float
            disgustTolerance = settingsDict!["disgustTolerance"] as! Float
            sadnessTolerance = settingsDict!["sadnessTolerance"] as! Float
            
        }
        
    }
    
    func save(){
        
        var settingsDict = Dictionary<String,AnyObject>()
        settingsDict["monitoring"] = monitoring
        settingsDict["pushNotifications"] = pushNotifications
        settingsDict["angerTolerance"] = angerTolerance
        settingsDict["disgustTolerance"] = disgustTolerance
        settingsDict["sadnessTolerance"] = sadnessTolerance + 0.2
        
        let userDefaults = NSUserDefaults.standardUserDefaults()

        userDefaults.setObject(settingsDict, forKey: "appSettings")
        userDefaults.synchronize()
        
    }
    
    
    
    
}