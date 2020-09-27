//
//  UIPanGestureRecognizerExt.swift
//  ActionCard
//
//  Created by Hugo Flores Perez on 9/27/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

// Found here: https://stackoverflow.com/a/41890063

// This extension gives us information about the direction of the pan gesture
// Added just one axis as we don't use horizontal gesture
extension UIPanGestureRecognizer {
    public enum GestureDirection {
        case none, up, down
    }
    
    public func verticalDirection(target: UIView) -> GestureDirection {
        let verticalVelocity = velocity(in: target).y
        return verticalVelocity > 0 ? .down : (verticalVelocity < 0 ? .up : .none)
    }
}
