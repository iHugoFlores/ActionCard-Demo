//
//  VerticalSlideViewDelegate.swift
//  ActionCard
//
//  Created by Perez, Hugo (H.) on 9/29/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

/**
 # VerticalSlideView
 Delegation protocl for the VerticalSlideView
 TODO: Method description needed?
*/
public protocol VerticalSlideViewDelegate: class {
    func didChangeState(_ view: VerticalSlideView, newFrame: CGRect, state: VerticalSlideState)
}
