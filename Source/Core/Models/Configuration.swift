//
//  Configuration.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 04.04.2021.
//

import Foundation

public struct MLKConfiguration {
    let isEnable: Bool
    // TODO: - In work
    let ignoreClasses: [String]
    let notificationType: [NotificationType]
    let messageTrigger: Int
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
