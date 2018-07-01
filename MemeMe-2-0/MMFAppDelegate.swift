 //
//  AppDelegate.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 01/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import UIKit

//MARK: - MMFAppDelegate: UIResponder, UIApplicationDelegate

@UIApplicationMain
class MMFAppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - properties
    var window: UIWindow?
    var memes = [MMFMeme]()
    
    //MARK: UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

