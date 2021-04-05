//
//  SecondViewController.swift
//  Demo
//
//  Created by Rustam Nurgaliev on 05.04.2021.
//

import UIKit

final class SecondViewController: BaseViewController {
    
    var someLeak: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        someLeak = {
            print(self.view.frame)
        }
        view.backgroundColor = .yellow
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.dismiss(animated: true)
        }
    }
}
