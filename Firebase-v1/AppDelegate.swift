//
//  AppDelegate.swift
//  Firebase-v1
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
        if KEY_UID != "" {
        FirebaseApp.childByAppendingPath("users").childByAppendingPath(KEY_UID).updateChildValues([KEY_ISONLINE:false])
        }
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
        if KEY_UID != "" {
            FirebaseApp.childByAppendingPath("users").childByAppendingPath(KEY_UID).updateChildValues([KEY_ISONLINE:true])
        }
    }


}

