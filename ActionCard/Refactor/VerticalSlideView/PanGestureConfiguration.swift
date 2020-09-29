//
//  PanGestureConfiguration.swift
//  ActionCard
//
//  Created by Perez, Hugo (H.) on 9/29/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

/**
 # PanGestureConfiguration
    Structure that holds the snap positions and dragging velocity threshold for the _Pan Gesture_ interaction configurations
    - snapThreshold: **More info needed for this one**. Must be between 0 and 1. Everything greater or smaller will be set to the closest of those two values
    - velocityThreshold: Dragging/interaction/gesture speed that will trigger swithcing to _snapTop_ or _snapBottom_, depending on the direction
*/
public struct PanGestureConfiguration {
    public let snapThreshold: CGFloat
    public let velocityThreshold: CGFloat
    
    public init(snapThreshold: CGFloat = 0.5, velocityThreshold: CGFloat = 1500) {
        self.snapThreshold = snapThreshold < 0 ? 0 : (snapThreshold > 1 ? 1 : snapThreshold)
        self.velocityThreshold = velocityThreshold
    }
}
