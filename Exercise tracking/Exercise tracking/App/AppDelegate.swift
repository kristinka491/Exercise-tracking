//
//  AppDelegate.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 11.10.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)

        let startVC = storyboard.instantiateViewController(withIdentifier: "homeScreen")

        window?.rootViewController = UINavigationController(rootViewController: startVC)
        window?.makeKeyAndVisible()
        return true
    }
}

