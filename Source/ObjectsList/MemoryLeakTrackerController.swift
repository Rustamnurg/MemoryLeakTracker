//
//  MemoryLeakTrackerController.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 05.04.2021.
//

import Foundation

public struct MemoryLeakTrackerController {
    public static func load() -> UIViewController {
        return ObjectsListViewController()
    }
}
