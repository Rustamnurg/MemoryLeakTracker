//
//  Logger.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 08.04.2021.
//

import Foundation

protocol LoggerProtocol {
    func log(event: Event)
}

class Logger: LoggerProtocol {
    private let messageFormatter: MessageFormatterProtocol
    
    init(messageFormatter: MessageFormatterProtocol = LoggerMessageFormatter()) {
        self.messageFormatter = messageFormatter
    }
    
    func log(event: Event) {
        let message = messageFormatter.messageFromEvent(event)
        print("\(message.title) \(message.subtitle ?? "") \(message.body ?? "")".trimmingCharacters(in: .whitespaces))
    }
}
