//
//  Event.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 04.04.2021.
//

import Foundation

public struct Event {
    public let name: String
    public let count: Int
    public let type: EventType

}

public enum EventType: String {
    case initialized
    case deInitialized
    case notification
}
