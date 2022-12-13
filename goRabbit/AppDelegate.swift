//
//  AppDelegate.swift
//  goRabbit
//
//  Created by Aleksandr  on 13.12.2022.
//

import UIKit
import GoogleMaps

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyCnf_PJV1pSKeXxR8FtzNK-rbERUaP4r_k")
        return true
    }
}
