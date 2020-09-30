//
//  ViewController.swift
//  ActionCard
//
//  Created by Hugo Flores Perez on 9/27/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //let slidingViewController = MySliderViewController()
    
    let newSlidingViewController = MyNewSliderViewController()
    
    let overlayView = UIView()
    
    let fullModeButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        newSlidingViewController.backgroundColor = .white

        view.addSubview(newSlidingViewController)
        
//        overlayView.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.2, blue: 0.7, alpha: 0.5)
//        overlayView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(overlayView)
//        overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        overlayView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        overlayView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//        fullModeButton.setTitle("Full mode", for: .normal)
//        fullModeButton.addTarget(self, action: #selector(setFullScreen), for: .touchUpInside)
//        fullModeButton.translatesAutoresizingMaskIntoConstraints = false
//        overlayView.addSubview(fullModeButton)
//        fullModeButton.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
//        fullModeButton.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor).isActive = true
    }
    
    @objc func setFullScreen() {
        
    }
}
