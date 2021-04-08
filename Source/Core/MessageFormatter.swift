//
//  MessageFormatter.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 04.04.2021.
//

import Foundation

public protocol MessageFormatterProtocol {
    func messageFromEvent(_ event: Event) -> Message
}

struct LeakMessageFormatter: MessageFormatterProtocol {
    func messageFromEvent(_ event: Event) -> Message {
        return Message(
            title: "[TECH] \u{274C} Possible leak",
            subtitle: "\(event.count) - \(event.name)",
            body: nil
        )
    }
}

struct LoggerMessageFormatter: MessageFormatterProtocol {
    func messageFromEvent(_ event: Event) -> Message {
        let type: String
        switch event.type {
        case .initialized:
            type = "\u{2795}"
        case .deInitialized:
            type = "\u{2796}"
        case .notification:
            type = "\u{274C}"
        }
        return Message(
            title: "MLT:",
            subtitle: "\(type) \(event.type.rawValue) \(event.name) - \(event.count)",
            body: nil
        )
    }
}
