//
//  VerticalSlideState.swift
//  ActionCard
//
//  Created by Perez, Hugo (H.) on 9/29/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

/**
 # VerticalSlideState
 Enum that describes the _position/displacement_ of the VerticalSliderView relative to it's superview
 - snapTop: The view is _snapped_ at the _top value?_
 - snapBottom: The view is _snapped_ at the bottom value?_
 - full: The view has reached the _maxReachableHeight_ value
 - hidden: The view has reached the _minReachableHeight_ value, making it disappear from it's superview?
 - progressing: The view is in transition between the previous states
*/
public enum VerticalSlideState {
    case snapTop, snapBottom, full, hidden, progressing
    
    public func getFrameHeight(baseHeight: CGFloat, configuration: PanGestureConfiguration) -> CGFloat {
        switch self {
        case .full: return baseHeight
        case .hidden: return 0
        case .snapBottom: return baseHeight * configuration.bottomSnapPercentage
        case .snapTop: return baseHeight * configuration.topSnapPercentage
        default: return baseHeight
        }
    }
}
