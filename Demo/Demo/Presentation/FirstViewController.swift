//
//  FirstViewController.swift
//  Demo
//
//  Created by Rustam Nurgaliev on 05.04.2021.
//

import UIKit
import MemoryLeakTracker

final class FirstViewController: BaseViewController {
    
    lazy var secondVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show second vc", for: .normal)
        return button
    }()
    
    lazy var logsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logs", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupButtons()
    }
    
    private func setupButtons() {
        view.addSubview(secondVCButton)
        view.addSubview(logsButton)
        
        secondVCButton.frame.size = CGSize(width: 200, height: 50)
        secondVCButton.center = view.center
        
        logsButton.frame = CGRect(
            x: view.frame.width / 2 - 100,
            y: view.frame.height - 100,
            width: 200,
            height: 50
        )
        
        secondVCButton.addTarget(self, action: #selector(secondVCButtonTapped), for: .touchUpInside)
        logsButton.addTarget(self, action: #selector(logsButtonTapped), for: .touchUpInside)
    }
    
    @objc private func secondVCButtonTapped() {
        let vc = SecondViewController()
        present(vc, animated: true)
    }
    
    @objc private func logsButtonTapped() {
        let vc = MemoryLeakTrackerController.load()
        present(vc, animated: true)
    }
}
