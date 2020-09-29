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
    
    let newSlidingViewController = MyNewSliderViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        newSlidingViewController.backgroundColor = .white
        
        // If Bottom View Controller is a VC
        //newSlidingViewController.view.frame = view.frame
        //addChild(newSlidingViewController)
        view.addSubview(newSlidingViewController)
        newSlidingViewController.frame = view.frame
        //newSlidingViewController.didMove(toParent: self)
        
//        slidingViewController.view.backgroundColor = .white
//        // Functionality for addChildViewController
//        addChild(slidingViewController)
//        view.addSubview(slidingViewController.view)
//        slidingViewController.didMove(toParent: self)
    }
}
