//
//  MLTConfiguration.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 04.04.2021.
//

import Foundation

public struct MLTConfiguration {
    /// Is the library included
    let isEnable: Bool
    
    // TODO: - In work
    /// Ignored classes
    let ignoreClasses: [String]
    
    /// Method of notification:
    /// .push  - local push(you need to set up push notifications in your application!)
    /// .alert - present alert on top screen
    /// .console - print on console
    /// .none - not notify
    let notificationType: [NotificationType]
    
    /// The required number of matches for the assumption of leakage
    let messageTrigger: Int
    
    /// Logging of all library activities in the console
    let logOnConsole: Bool
    
    public init(isEnable: Bool = false,
                ignoreClasses: [String] = [],
                notificationType: [NotificationType] = [.console],
                messageTrigger: Int = 3,
                logOnConsole: Bool = false) {
        self.isEnable = isEnable
        self.ignoreClasses = ignoreClasses
        self.notificationType = notificationType
        self.messageTrigger = messageTrigger
        self.logOnConsole = logOnConsole
    }
}
