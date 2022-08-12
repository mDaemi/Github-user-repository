//
//  AppDelegate.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 03/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Override point for customization after application launch.
        if #available(iOS 14.0, *) {
            // In iOS 14 setup is done in SceneDelegate
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window
            appCoordinator = AppCoordinator( from: nil , screen : UserSearchViewController())
            appCoordinator?.configureAndStartFromWindow(window)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

class MyNavigationController: UINavigationController {
     override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 14.0, *) {
           return .darkContent
        } else {
            return  .default
            // Fallback on earlier versions
        }
     }
 }

