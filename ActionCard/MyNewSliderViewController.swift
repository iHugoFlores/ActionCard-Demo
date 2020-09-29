//
//  MyNewSliderViewController.swift
//  ActionCard
//
//  Created by Perez, Hugo (H.) on 9/29/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

import UIKit

class MyNewSliderViewController: VerticalSlideView {
    
    //let verticalSliderView = VerticalSlideView()
    
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
    
    override init() {
        super.init()
        setVerticalSlider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        print(self.superview)
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //setContainerView()
//        setVerticalSlider()
//        //setLabel()
//        //setTable()
//
//        print(view.superview)
//    }
    
    func setVerticalSlider() {
        //verticalSliderView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
//        verticalSliderView.translatesAutoresizingMaskIntoConstraints = false
//
//        
//        verticalSliderView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        verticalSliderView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        verticalSliderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        verticalSliderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
//    func setContainerView() {
//        containerView.backgroundColor = .cyan
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(containerView)
//
//        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.89).isActive = true
//        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//    }
//
//    func setLabel() {
//        label.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(label)
//        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
//        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
//    }
//
//    func setTable() {
//        tableView.isScrollEnabled = false
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.7, blue: 0.2, alpha: 0.5)
//        view.addSubview(tableView)
//
//        tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//    }
}

extension MyNewSliderViewController: UITableViewDelegate, UITableViewDataSource {
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

