//
//  AppDelegate.swift
//  Uho
//
//  Created by Bharath Booshan on 3/26/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import UIKit
import FBSDKCoreKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var pushNotificationService = PushNotificationService()
    var deviceToken = ""

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        // Override point for customization after application launch.
        var userDefaults = NSUserDefaults.standardUserDefaults()
        let appFirstLaunchStatus = userDefaults.valueForKey("appFirstLaunchStatus");
        let socialNetworkLoginStatus = userDefaults.valueForKey("socialNetworkLoginStatus");
        
        if ( appFirstLaunchStatus != nil ){
            let navigationController = window?.rootViewController as! UINavigationController
            
            if(socialNetworkLoginStatus != nil ){
                
                userDefaults = NSUserDefaults.standardUserDefaults()
                let userId = userDefaults.valueForKey("userId") as! String
                
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let userAnalysisController : ViewController = storyboard.instantiateViewControllerWithIdentifier("user_main_analysis_scren") as! ViewController
                
                userAnalysisController.userId = userId
                userAnalysisController.isNavigationRootScreen = true;
                navigationController.viewControllers[0] = userAnalysisController;
                
            }else{
                
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let socialNetworkController : SocialNetworkController = storyboard.instantiateViewControllerWithIdentifier("SocialNetworkController") as! SocialNetworkController
                
                navigationController.viewControllers[0] = socialNetworkController;
                
            }
        }
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        return handled
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
        pushNotificationService.didFailToRegisterToken(error)
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        pushNotificationService.didRegisterToDeviceToken(deviceToken)
    }


}

