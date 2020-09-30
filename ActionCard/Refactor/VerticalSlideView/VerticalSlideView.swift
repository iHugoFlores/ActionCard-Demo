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
    private let panGesture = UIPanGestureRecognizer()
    
    /**
     Controls if if the new frame for gdragging interactions can be updated
    */
    private var gestureEnabled = true
    
    /**
     Frame for the top snap state
    */
    private var topSnapFrame: CGRect {
        getFrameForState(baseFrame: superview?.frame ?? .zero, state: .snapTop)
    }
    
    /**
     Frame for the bottom snap state
    */
    private var bottomSnapFrame: CGRect {
        getFrameForState(baseFrame: superview?.frame ?? .zero, state: .snapBottom)
    }
    
    /**
     Inset value for which the bottom position will move to
    */
    private var bottomInsetHeight: CGFloat = 0
    
    /**
     Inset value for which the top position will move to
    */
    private var topInsetHeight: CGFloat = 0
    
    /**
     State of the current vertical position of the view
    */
    private let positionState: VerticalSlideState
    
    /**
     Method used to update the frame value of the superview once it's added to one
    */
    public override func didMoveToSuperview() {
        setFrameForStateAndInsets()
    }

    /**
     State of the current vertical position of the view
    */
    private func setFrameForStateAndInsets() {
        let superViewFrame = superview?.frame ?? .zero
        let positionedFrame = getFrameForState(baseFrame: superViewFrame, state: positionState)
        setViewLayer(frame: positionedFrame)
    }
    
    private func getFrameForState(baseFrame: CGRect, state: VerticalSlideState) -> CGRect {
        let stateFrame = panGestureConfig.getFrameFor(base: baseFrame, state: state)
        return getFrameWithInsets(base: stateFrame)
    }
    
    private func getFrameWithInsets(base: CGRect) -> CGRect {
        let x = base.origin.x
        let y = base.origin.y + topInsetHeight - bottomInsetHeight
        let w = base.width
        let h = base.height - topInsetHeight
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    init(initialState: VerticalSlideState = .snapBottom) {
        positionState = initialState

        super.init(frame: .zero)

        panGesture.addTarget(self, action: #selector(viewWasDragged(_:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc func viewWasDragged(_ gesture: UIPanGestureRecognizer) {
        
        defer { gesture.setTranslation(.zero, in: self) }
        
        if gesture.state == .ended { gestureEnabled = true }
        
        guard gestureEnabled else { return }
        
        let translation = gesture.translation(in: self)
        let velocity = gesture.velocity(in: self)
        let newFrame = CGRect(x: 0, y: frame.minY + translation.y, width: frame.width, height: frame.height - translation.y)
        
        let topFrame = topSnapFrame
        let bottomFrame = bottomSnapFrame
        
        if wereBoundLimitsTriggered(topFrame: topFrame, bottomFrame: bottomFrame, newFrame: newFrame) {
            gestureEnabled = false
            return
        }
        
        if wereVelocityBoundsTriggered(velocity: velocity, gestureDirection: gesture.verticalDirection(target: self)) {
            return
        }
        
        if wereSnapBoundsTriggered(hasGestureEnded: gesture.state == .ended, newFrame: newFrame) {
            return
        }
        
        setViewLayer(frame: newFrame)
    }
    
    private func wereBoundLimitsTriggered(topFrame: CGRect, bottomFrame: CGRect, newFrame: CGRect) -> Bool {
        if newFrame.minY + panGestureConfig.draggingTolerance < topFrame.minY {
            setViewWithAnimation(frame: topSnapFrame, state: .snapTop, completion: nil)
            return true
        } else if newFrame.minY - panGestureConfig.draggingTolerance > bottomFrame.minY {
            setViewWithAnimation(frame: bottomSnapFrame, state: .snapBottom, completion: nil)
            return true
        }
        return false
    }
    
    private func wereVelocityBoundsTriggered(velocity: CGPoint, gestureDirection: UIPanGestureRecognizer.GestureDirection) -> Bool {
        if abs(velocity.y) >= panGestureConfig.velocityThreshold {
            if gestureDirection == .up {
                setViewWithAnimation(frame: topSnapFrame, state: .snapTop, completion: nil)
                return true
            } else if gestureDirection == .down {
                setViewWithAnimation(frame: bottomSnapFrame, state: .snapBottom, completion: nil)
                return true
            }
            return true
        }
        return false
    }
    
    private func wereSnapBoundsTriggered(hasGestureEnded: Bool, newFrame: CGRect) -> Bool {
        if hasGestureEnded {
            let offset = (bottomSnapFrame.minY - topSnapFrame.minY) * panGestureConfig.snapThreshold
            let snapThresholdY = bottomSnapFrame.minY - offset

            if newFrame.minY <= snapThresholdY {
                setViewWithAnimation(frame: topSnapFrame, state: .snapTop, completion: nil)
            } else if newFrame.minY > snapThresholdY {
                setViewWithAnimation(frame: bottomSnapFrame, state: .snapBottom, completion: nil)
            }
            return true
        }
        return false
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
            initialSpringVelocity: velocity / 1000,
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
