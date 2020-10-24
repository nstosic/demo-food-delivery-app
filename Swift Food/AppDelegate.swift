//
//  AppDelegate.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 14/10/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DependencyInjection.setup()
        window = UIWindow()
        let navigationController = UINavigationController(rootViewController: HomeView())
        navigationController.interactivePopGestureRecognizer?.delegate = nil
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }


}

