//
//  SVCPanGestureConfiguration.swift
//  ActionCard
//
//  Created by Hugo Flores Perez on 9/27/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

// Is this structure all that neccessary?
// What is it's purose?
struct SVCPanGestureConfiguration {
    // What are these
    let snapThreshold: CGFloat // Percentage of the screen to snap to (?)
    let velocityThreshold: CGFloat // Velocity limit for pan gesture
    
    init(snapThreshold: CGFloat = 0.5, velocityThreshold: CGFloat = 1500) {
        self.velocityThreshold = velocityThreshold
        self.snapThreshold = snapThreshold < 0 ? 0 : (snapThreshold > 1 ? 1 : snapThreshold)
    }
}
