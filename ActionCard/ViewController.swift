//
//  ViewController.swift
//  ActionCard
//
//  Created by Hugo Flores Perez on 9/27/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let slidingViewController = MySliderViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        slidingViewController.view.backgroundColor = .white
        view.backgroundColor = .red
        
        // Functionality for addChildViewController
        addChild(slidingViewController)
        view.addSubview(slidingViewController.view)
        slidingViewController.didMove(toParent: self)
    }
}
