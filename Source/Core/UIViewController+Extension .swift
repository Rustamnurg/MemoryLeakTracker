//
//  UIViewController+Extension.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 04.04.2021.
//

import Foundation

extension UIViewController {
    static func currentViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        guard let viewController = viewController else { return nil }
        
        if let viewController = viewController as? UINavigationController {
            if let viewController = viewController.visibleViewController {
                return currentViewController(viewController)
            } else {
                return currentViewController(viewController.topViewController)
            }
        } else if let viewController = viewController as? UITabBarController {
            if let viewControllers = viewController.viewControllers, viewControllers.count > 5, viewController.selectedIndex >= 4 {
                return currentViewController(viewController.moreNavigationController)
            } else {
                return currentViewController(viewController.selectedViewController)
            }
        } else if let viewController = viewController.presentedViewController {
            return currentViewController(viewController)
        } else if viewController.children.count > 0 {
            return viewController.children[0]
        } else {
            return viewController
        }
    }
    
    // TODO: - In work
//    open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        //Shake shake
//        if motion == .motionShake && .shakeEnabled {
//            NotificationCenter.default.post(name: "fire", object: nil)
//        }
//
//        next?.motionBegan(motion, with: event)
//    }
}
