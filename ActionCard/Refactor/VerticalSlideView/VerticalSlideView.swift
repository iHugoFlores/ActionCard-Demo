//
//  VerticalSlideView.swift
//  ActionCard
//
//  Created by Hugo Flores Perez on 9/27/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

/**
 # VerticalSlideView
 UIView that implements vertical dragging interaction
 ## Usage
 Intended to be used in composition with a UIViewController screen
 **ADD DEMO CODE?**
 ## Behaviour
 - The component will display a _card_ at the bottom of the parent view
 - The card will be able to be dragged vertically inside the parent view bounds
 ## Limitations
 - Class not designed to be used with storyboards/XIB
 **EXPLAIN VIEW FRAME BOUNDARIES**
 ## Concepts
 - Frame: **Coordinates and size** of a view relative to it's superview
 ## TODOS
 -  Should the max and min values be lazy vars? They have to be dependant on the superview, and that can only happen after instantiation
*/
public class VerticalSlideView: UIView {
    
    /**
     Delegation object. Used to comunicate changes of state
    */
    public weak var delegate: VerticalSlideViewDelegate?
    
    /**
     Configuration of the speed and snap limits for the _Pan Gesture_ interaction handler
    */
    private var panGestureConfig = PanGestureConfiguration()
    
    /**
     Pan Gesture Recognizer Object
    */
    private var panGesture: UIPanGestureRecognizer?
    
    /**
     Maximum height value (relative to the superview) that can be reached by the **top of the view**
     The default is 0, as to not assume the frame of the superview
    */
    private var maxReachableHeight: CGFloat = 100 // This must be set to be that of the superview? Should it be var?
    
    /**
     Minimum height value (relative to the superview) that can be reached by the **top of the view**
    */
    private var minReachableHeight: CGFloat = 0
    
    /**
     Frame for which the view is placed at the **Minimum Reachable Height**
    */
    private var minReachableFrame: CGRect {
        CGRect(x: 0, y: (superview?.frame.height ?? 0) - minReachableHeight, width: frame.width, height: maxReachableHeight)
    }
    
    /**
     Frame for which the view is placed at the **Maximum Reachable Height**
    */
    private var maxReachableFrame: CGRect {
        CGRect(x: 0, y: (superview?.frame.height ?? 0) - maxReachableHeight, width: frame.width, height: maxReachableHeight)
    }
    
    /**
     State of the current vertical position of the view
    */
    private var positionState: VerticalSlideState = .snapBottom // Should we set the state in a constructor instead?
    
    init() {
        super.init(frame: .zero)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewWasDragged(_:)))
        self.maxReachableHeight = superview?.bounds.height ?? 0
        addGestureRecognizer(panGesture!)
        maxReachableHeight = 200
        
        frame = maxReachableFrame
    }
    
    @objc func viewWasDragged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let velocity = gesture.velocity(in: self)
        let newFrame = CGRect(x: 0, y: frame.minY + translation.y, width: frame.width, height: frame.height - translation.y)

        setViewLayer(frame: newFrame)
    }
    
    private func setViewLayer(frame: CGRect) {
        layer.frame = frame
        delegate?.didChangeState(self, newFrame: frame, state: .progressing)
    }
    
    private func setViewWithAnimation(frame: CGRect, duration: TimeInterval = 0.3, state: VerticalSlideState, velocity: CGFloat = 30, completion: (() -> Void)?) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: velocity / 1000, // Should this be just refactored as the input parameter?
            options: [.curveEaseInOut, .allowUserInteraction],
            animations: {
                self.layer.frame = frame
                self.setNeedsDisplay()
                self.delegate?.didChangeState(self, newFrame: frame, state: .progressing)
        }) { (_) in
            self.delegate?.didChangeState(self, newFrame: frame, state: state)
            completion?()
        }
    }

    // MARK: Methods that seem like a good idea to have
    func displayToBottomSnap() {
        
    }
    
    func displayToTopSnap() {
        
    }
    
    func displayInFull() {
        
    }
    
    func hide() {
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
