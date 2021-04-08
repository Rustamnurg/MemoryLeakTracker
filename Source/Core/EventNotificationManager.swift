//
//  EventNotificationManager.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 04.04.2021.
//

import UIKit

protocol EventNotificationManagerProtocol {
    func sendEvent(with message: Message, and type: NotificationType)
}

final class EventNotificationManager: EventNotificationManagerProtocol {

    // MARK: EventNotificationManagerProtocol
    
    func sendEvent(with message: Message, and type: NotificationType){
        switch type {
        case .alert:
            showAlert(with: message)
        case .push:
            showPush(with: message)
        case .console:
            printOnConsole(with: message)
        case .none:
            break
        }
    }
    
    // MARK: - Private methods
    
    private func showPush(with message: Message) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            // TODO: - Обработать
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
        let content = UNMutableNotificationContent()
        content.title = message.title
        if let subtitle = message.subtitle {
            content.subtitle = subtitle
        }
        if let body = message.body {
            content.body = body
        }
        if #available(iOS 12.0, *) {
            content.sound = UNNotificationSound.defaultCritical
        } else {
            content.sound = UNNotificationSound.default
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    private func showAlert(with message: Message) {
        var subtitleMessage: String? = nil
        if let subtitle = message.subtitle {
            subtitleMessage = subtitle
        }
        if let body = message.body {
            if subtitleMessage?.isEmpty == true {
                subtitleMessage = body
            } else {
                subtitleMessage?.append("\n")
                subtitleMessage?.append(body)
            }
        }
        DispatchQueue.main.async {
            let alert = UIAlertController(title: message.title, message: subtitleMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            UIViewController.currentViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
    private func printOnConsole(with message: Message) {
        print("\(message.title) \(message.subtitle ?? "") \(message.body ?? "")".trimmingCharacters(in: .whitespaces))
    }
}
