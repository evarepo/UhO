//
//  PushNotificationService.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation

let AskPushNotificationKey = "AskPushNotificationKey"

class PushNotificationService {
    
    
    var pushToken = ""
    
    init() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PushNotificationService.askPushNotificationToken(_:)), name: AskPushNotificationKey, object: nil)
        
    }
    
   @objc func askPushNotificationToken(notification : NSNotification) {
        let settings = UIUserNotificationSettings(forTypes: [.Sound, .Alert, .Badge], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        // This is an asynchronous method to retrieve a Device Token
        // Callbacks are in AppDelegate.swift
        // Success = didRegisterForRemoteNotificationsWithDeviceToken
        // Fail = didFailToRegisterForRemoteNotificationsWithError
        UIApplication.sharedApplication().registerForRemoteNotifications()
      
    }
    
    func didFailToRegisterToken(error : NSError! ){
        
    }
    
    func didRegisterToDeviceToken( token : NSData! ){
        
        let tokenString = convertDeviceTokenToString(token)
        print(tokenString)
        //throw notification
    }
    
    private func convertDeviceTokenToString(deviceToken:NSData) -> String {
        
        
        //  Convert binary Device Token to a String (and remove the <,> and white space charaters).
        var deviceTokenStr = deviceToken.description.stringByReplacingOccurrencesOfString(">", withString: "", options: .LiteralSearch, range: nil)
        deviceTokenStr = deviceTokenStr.stringByReplacingOccurrencesOfString("<", withString: "", options: .LiteralSearch, range: nil)
        deviceTokenStr = deviceTokenStr.stringByReplacingOccurrencesOfString(" ", withString: "", options: .LiteralSearch, range: nil)
        
        // Our API returns token in all uppercase, regardless how it was originally sent.
        // To make the two consistent, I am uppercasing the token string here.
        deviceTokenStr = deviceTokenStr.uppercaseString
        return deviceTokenStr
    }
    
    
}