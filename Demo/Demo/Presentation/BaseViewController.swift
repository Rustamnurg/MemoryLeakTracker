//
//  BaseViewController.swift
//  Demo
//
//  Created by Rustam Nurgaliev on 05.04.2021.
//

import UIKit
import MemoryLeakTracker

class BaseViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MemoryLeakTracker.shared.append("\(self)")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        MemoryLeakTracker.shared.append("\(self)")
    }
    
    deinit {
        MemoryLeakTracker.shared.remove("\(self)")
    }
}
