//
//  AppDelegate.swift
//  Demo
//
//  Created by Rustam Nurgaliev on 05.04.2021.
//

import UIKit
import MemoryLeakTracker

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let configs = MLTConfiguration(
            isEnable: true,
            notificationType: [.push, .console],
            messageTrigger: 2
        )
        MemoryLeakTracker.shared.configure(configs)
        setupPushNotifications(on: application)
        setRootViewController()
        return true
    }
    
    private func setRootViewController() {
        let viewController = FirstViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: viewController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    private func setupPushNotifications(on application: UIApplication) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        application.registerForRemoteNotifications()
        userNotificationCenter.delegate = self
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    // MARK: - UNUserNotificationCenterDelegate
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .alert, .sound])
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
