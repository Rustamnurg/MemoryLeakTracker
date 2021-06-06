//
//  MemoryLeakTracker.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 27.03.2021.
//

import Foundation

public protocol MemoryLeakTrackerProtocol {
    func configure(_ model: MLTConfiguration)
    func append(_ objectName: String)
    func remove(_ objectName: String)
    func fetchAllActiveObjects() -> [String: Int]
    func reset()
}

public class MemoryLeakTracker {
    
    // MARK: - Properties
    
    public static let shared: MemoryLeakTrackerProtocol = MemoryLeakTracker()
    private var configuration = MLTConfiguration()
    private var active: [String: Int] = [:]
    private let eventNotificationManager: EventNotificationManagerProtocol = EventNotificationManager()
    private let messageFormatter: MessageFormatterProtocol = LeakMessageFormatter()
    private let logger: LoggerProtocol = Logger()
    
  
    // MARK: Interanal methods
    
    // MARK: - Private methods
    
    private func append(_ className: String) -> Bool {
        guard configuration.isEnable else { return false }
        guard configuration.ignoreClasses.contains(className) == false else { return false }
        if configuration.logOnConsole {
            logger.log(event: Event(name: className, count: active[className] ?? 1, type: .initialized))
        }
        if let storedCount = active[className] {
            if storedCount >= configuration.messageTrigger - 1 {
                let event = Event(name: className, count: storedCount + 1, type: .notification)
                if configuration.logOnConsole {
                    logger.log(event: event)
                }
                let message = messageFormatter.messageFromEvent(event)
                configuration.notificationType.forEach { eventNotificationManager.sendEvent(with: message, and: $0) }
            }
        }
        return true
    }
    
    private func prepareKey(from objectName: String) -> String {
        let className = objectName.components(separatedBy: ":")[0]
        return className.replacingOccurrences(of: "<", with: "")
    }
    
}

extension MemoryLeakTracker: MemoryLeakTrackerProtocol {
    // MARK: - MemoryLeakTrackerProtocol
    
    public func append(_ objectName: String) {
        guard configuration.isEnable else { return }
        let className = prepareKey(from: objectName)
        guard append(className) else { return }

        if let initialCount = active[className] {
            active[className] = initialCount + 1
        } else {
            active[className] = 1
        }
    }
    
    public func remove(_ objectName: String) {
        let className = prepareKey(from: objectName)
        guard configuration.isEnable else { return }
        guard configuration.ignoreClasses.contains(className) == false else { return }
        if let initialCount = active[className] {
            if configuration.logOnConsole {
                logger.log(event: Event(name: className, count: initialCount - 1, type: .deInitialized))
            }
            active[className] = initialCount - 1
            if initialCount == 1 {
                active.removeValue(forKey: className)
            }
        }
    }
    
    public func fetchAllActiveObjects() -> [String: Int] {
        return active
    }
    
    public func configure(_ model: MLTConfiguration) {
        configuration = model
    }
    
    public func reset() {
        active = [:]
    }
}
