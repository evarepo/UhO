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
    
    var angerTolerance:Float
    var foulLanguage:Float
    var politicalCorrectness:Float
    var partying:Float
    
    
    
    init(){
        
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        var settingsDict = userDefaults.dictionaryForKey("appSettings");
        
        if ( settingsDict == nil ){
            
            monitoring = true
            pushNotifications = true
            
            angerTolerance = 0.0
            foulLanguage = 0.0
            politicalCorrectness = 0.0
            partying = 0.0
            
            save()
        }
        else{
            
            monitoring = settingsDict!["monitoring"] as! Bool
            pushNotifications = settingsDict!["pushNotifications"] as! Bool
            angerTolerance = settingsDict!["angerTolerance"] as! Float
            foulLanguage = settingsDict!["foulLanguage"] as! Float
            politicalCorrectness = settingsDict!["politicalCorrectness"] as! Float
            partying = settingsDict!["partying"] as! Float
            
        }
        
    }
    
    func save(){
        
        var settingsDict = Dictionary<String,AnyObject>()
        settingsDict["monitoring"] = monitoring
        settingsDict["pushNotifications"] = pushNotifications
        settingsDict["angerTolerance"] = angerTolerance
        settingsDict["foulLanguage"] = foulLanguage
        settingsDict["politicalCorrectness"] = politicalCorrectness
        settingsDict["partying"] = partying
        
        let userDefaults = NSUserDefaults.standardUserDefaults()

        userDefaults.setObject(settingsDict, forKey: "appSettings")
        userDefaults.synchronize()
        
    }
    
    
    
    
}