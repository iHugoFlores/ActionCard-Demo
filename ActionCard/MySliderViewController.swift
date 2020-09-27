//
//  MySliderViewController.swift
//  ActionCard
//
//  Created by Hugo Flores Perez on 9/27/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class MySliderViewController: SlidingViewController {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Demo"
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    let button = UIButton()
    let containerView = UIView()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setContainerView()
        setLabel()
        setTable()
        
        // The values should be calculated (?), not defined
        // SlidingViewController values that define limits
        maxHeight = 600
        minHeight = 300
        
        panGestureConfig = SVCPanGestureConfiguration()
        view.frame = minFrame
    }
    
    func setContainerView() {
        containerView.backgroundColor = .cyan
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.89).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func setLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
    }
    
    func setTable() {
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.7, blue: 0.2, alpha: 0.5)
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}

extension MySliderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "test")
        cell.textLabel?.text = "Something"
        cell.textLabel?.textColor = .black
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row selected", indexPath)
    }
}
