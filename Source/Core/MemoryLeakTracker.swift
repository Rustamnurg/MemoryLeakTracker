//
//  MemoryLeakTracker.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 27.03.2021.
//

import Foundation

public protocol MemoryLeakTrackerProtocol {
    func configure(_ model: Configuration)
    func append(_ objectName: String)
    func remove(_ objectName: String)
    func fetchAllActiveObjects() -> [String: Int]
    func reset()
}

public class MemoryLeakTracker {
    
    // MARK: - Properties
    
    public static let shared: MemoryLeakTrackerProtocol = MemoryLeakTracker()
    private var configuration = Configuration()
    private var active: [String: Int] = [:]
    private let eventNotificationManager: EventNotificationManagerProtocol = EventNotificationManager()
    private let messageFormatter: MessageFormatterProtocol = MessageFormatterDefault()
  
    // MARK: Interanal methods
    
    // MARK: - Private methods
    
    private func append(_ className: String) -> Bool {
        guard configuration.isEnable else { return false }
        guard configuration.ignoreClasses.contains(className) == false else { return false }
        if let storedCount = active[className] {
            if storedCount >= configuration.messageTrigger - 1 {
                let event = Event(name: className, count: storedCount + 1)
                let message = messageFormatter.messageFromEvent(event)
                eventNotificationManager.sendEvent(with: message, and: configuration.notificationType)
            }
        }
        return true
    }
}

extension MemoryLeakTracker: MemoryLeakTrackerProtocol {
    // MARK: - MemoryLeakTrackerProtocol
    
    public func append(_ objectName: String) {
        // TODO: - fix formattings
        guard configuration.isEnable else { return }
        let className = objectName.components(separatedBy: ":")[0]
        guard append(className) else { return }

        if let initialCount = active[className] {
            active[className] = initialCount + 1
        } else {
            active[className] = 1
        }
    }
    
    public func remove(_ objectName: String) {
        let className = objectName.components(separatedBy: ":")[0]
        if let initialCount = active[className] {
            active[className] = initialCount - 1
            if initialCount == 1 {
                active.removeValue(forKey: className)
            }
        }
    }
    
    public func fetchAllActiveObjects() -> [String: Int] {
        return active
    }
    
    public func configure(_ model: Configuration) {
        configuration = model
    }
    
    public func reset() {
        active = [:]
    }
}
