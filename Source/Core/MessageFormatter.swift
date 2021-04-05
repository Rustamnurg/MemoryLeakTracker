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

struct MessageFormatterDefault: MessageFormatterProtocol {
    func messageFromEvent(_ event: Event) -> Message {
        return Message(
            title: "[TECH] Possible leak",
            subtitle: "\(event.count) - \(event.name)",
            body: nil
        )
    }
}
