//
//  SlidingViewController.swift
//  ActionCard
//
//  Created by Hugo Flores Perez on 9/27/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit


// Descripton for this would be nice to have
// Since it's supposed to be an internal base class ao inherit the behaviour from

/**
 # SlidingViewController
    
 Base class that applies vertical dragging interaction capabilities to other views, through inheritance

 ## Concepts
 
 1. Frame refers to the **coordinates and size** of a view relative to it's superview
*/
class SlidingViewController: UIViewController { // The UIViewController methods aren't really used. Seems it inherherits from it, so that the BottomViewController can be a VC. Should be refactored so that the BottomViewController use it with composition instead
    
    // MARK: Gradient View should be part of the BottomViewController. It should not be here
    
    // What are these?
    var maxHeight: CGFloat = UIScreen.main.bounds.height
    var minHeight: CGFloat = 0
    
    // What are these?
    var minFrame: CGRect {
        CGRect(x: 0, y: UIScreen.main.bounds.height - minHeight, width: view.frame.width, height: maxHeight)
    }
    var maxFrame: CGRect {
        CGRect(x: 0, y: UIScreen.main.bounds.height - maxHeight, width: view.frame.width, height: maxHeight)
    }
    
    private(set) public var panGesture: UIPanGestureRecognizer?
    
    // A method should be exposed to either set the gesture with a configuration object, or disable the gesture
    public var panGestureConfig: SVCPanGestureConfiguration? {
        // We're automatically setting the UIPanGestureRecognizer once we set this configuration
        // Is this really neccessary?
        willSet {
            if newValue == nil {
                guard panGesture != nil else { fatalError("This should be handled somehow") }
                view.removeGestureRecognizer(panGesture!) // MARK: Force unwrap
                panGesture = nil
            } else {
                panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewWasDragged(_:)))
                view.addGestureRecognizer(panGesture!) // MARK: Force unwrap
            }
        }
    }

    @objc func viewWasDragged(_ gesture: UIPanGestureRecognizer) {
        guard let panGestureConfig = panGestureConfig else { fatalError("No configuration should throw fatal error?") }
        
        // What is this for?
        // Is it to set a new "origin" for the translation?
        defer {
            gesture.setTranslation(.zero, in: view)
        }
        
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        // This new frame is the frame that the view has to move to, depending on the translation registered by the gesture
        // If it doesn't meet certain limits, the current frame wont be updated to this new frame
        let newFrame = CGRect(x: 0, y: view.frame.minY + translation.y, width: view.frame.width, height: view.frame.height - translation.y)
        
        // MARK: Bounds check - It could me made into it's owm method
        if newFrame.minY < maxFrame.minY { // When user scrolls too high
            setViewWithAnimation(frame: maxFrame, state: .max, completion: nil)
            return // This return is set separately to not give the impression we're returning something
        } else if newFrame.minY > minFrame.minY { // Scroll too down?
            setViewWithAnimation(frame: minFrame, state: .min, completion: nil)
            return
        }
        
        // MARK: Velocity Threshold checks - This can also be made into it's own method
        // We're just checking the velocity threshold
        // I find it convenient to halt the animation if the gesture speed is going too fast
        if abs(velocity.y) >= panGestureConfig.velocityThreshold {
            // Depending on the direction of the speed, we just display either the maximum or minimum frame
            if gesture.verticalDirection(target: view) == .up {
                setViewWithAnimation(frame: maxFrame, state: .max, completion: nil) // We set the same frame for maximum vertical translation
                return
            } else if gesture.verticalDirection(target: view) == .down {
                setViewWithAnimation(frame: minFrame, state: .min, completion: nil)
                return
            }
        }
        
        // MARK: Snap Threshold gesture is ended
        // This method should snap the frame to some fixed position (depending on the snapThreshold), after the gesture interaction ends
        // It doesn't seem to work all that well since we're checking for the translation limits before (?)
        if gesture.state == .ended {
            // This indicates the vertical upper limit for the view to snap to. It won't be able to go beyond the snapThreshold percentage
            let offset = (minFrame.minY - maxFrame.minY) * panGestureConfig.snapThreshold
            // Seems to be some sort of "spring" reaction to dragging below the minimum heigh? (The first translation check makes it impossoble to trigger?)
            let snapThresholdY = minFrame.minY - offset
            
            // What exactly are we checking here?
            if newFrame.minY <= snapThresholdY {
                setViewWithAnimation(frame: maxFrame, state: .max, completion: nil)
                return
            } else if newFrame.minY > snapThresholdY {
                setViewWithAnimation(frame: minFrame, state: .min, completion: nil)
                return
            }
        }
        
        // Why are we executing this here?
        setViewLayer(frame: newFrame)
    }
    
    // This method moved to current fame of the view to a new "frame" (input param)
    func setViewWithAnimation(frame: CGRect, duration: TimeInterval = 0.3, state: SVCState, velocity: CGFloat = 30, completion: (() -> Void)?) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: velocity / 1000, // Should this be just refactored as the input parameter?
            options: [.curveEaseInOut, .allowUserInteraction],
            animations: {
                self.view.layer.frame = frame
                self.view.setNeedsDisplay()
                // State used in combination of delegate
                // self.delegate?.didChangeState(self, newFrame, state: .progressing)
        }) { (_) in
            // self.delegate?.didChangeState(self, newFrame, state: state)
            completion?()
        }
    }
    
    func setViewLayer(frame: CGRect) {
        view.layer.frame = frame
        // self.delegate?.didChangeState(self, newFrame, state: .progressing)
    }
}
