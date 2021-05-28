//
//  MemoryLeakTrackerOfClass.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 05.04.2021.
//

import Foundation

// TODO: - In work
open class MemoryLeakTrackerOfClass {
    
    public init() {
        MemoryLeakTracker.shared.append("\(self)")
    }
    
    deinit {
        MemoryLeakTracker.shared.remove("\(self)")
    }
    
}
