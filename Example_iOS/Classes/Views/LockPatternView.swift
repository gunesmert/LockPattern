//
//  LockPatternView.swift
//  Hipofis
//
//  Created by gunesmert on 03/05/16.
//  Copyright © 2016 Hipo. All rights reserved.
//

import UIKit
import PureLayout

let TileDimension: CGFloat = 60.0

class LockPatternView: UIView {
    weak var delegate: LockPatternViewDelegate!
    
    private var tileViews: [PatternTileView]! = []
    private var patternTileViews: [PatternTileView]! = []
    
    // MARK: - Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        for i in 0..<4 {
            for j in 0..<4 {
                let topInset: CGFloat = CGFloat(i) * TileDimension
                let leftInset: CGFloat = CGFloat(j) * TileDimension
                
                let tileView = PatternTileView.newAutoLayoutView()
                
                addSubview(tileView)
                
                tileView.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: topInset)
                tileView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: leftInset)
                tileView.autoSetDimensionsToSize(CGSize(width: TileDimension, height: TileDimension))
                
                tileViews.append(tileView)
            }
        }
    }
    
    // MARK: - Animation
    
    func updatePatternWith(State state: TileState) {
        func resetPattern() {
            let patternLength = patternTileViews.count
            
            for index in 0..<patternLength {
                let view = patternTileViews[patternLength - index - 1]
                
                UIView.animateWithDuration(0.1,
                                           delay: NSTimeInterval(0.05 * CGFloat(index)),
                                           options: UIViewAnimationOptions.BeginFromCurrentState,
                                           animations: {
                                            view.state = TileState.Default
                    }, completion: { (completed) in
                        self.patternTileViews.removeAll()
                })
            }
        }
        
        let patternLength = patternTileViews.count
        
        for index in 0..<patternLength {
            let view = patternTileViews[index]
            
            UIView.animateWithDuration(0.1,
                                       delay: NSTimeInterval(0.05 * CGFloat(index)),
                                       options: UIViewAnimationOptions.BeginFromCurrentState,
                                       animations: { 
                                        view.state = state
                }, completion: { (completed) in
                    if index == (patternLength - 1) {
                        resetPattern()
                    }
            })
        }
    }
    
    // MARK: - Touch Delegate Methods
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        guard let touch = touches.first  else {
            return
        }
        
        handle(Touch: touch)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        
        guard let touch = touches.first  else {
            return
        }
        
        handle(Touch: touch)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        guard let touch = touches.first  else {
            return
        }
        
        handle(Touch: touch)
        
        delegate.lockPatternView(self, producedPattern: extractPattern())
    }
    
    // MARK: - Pattern Handling
    
    func handle(Touch touch: UITouch) {
        let touchPoint = touch.locationInView(self)
        
        var inlineFrame = frame
        inlineFrame.origin = CGPointZero
        
        if inlineFrame.contains(touchPoint) {
            let i = Int(floor(touchPoint.x / TileDimension))
            let j = Int(floor(touchPoint.y / TileDimension))
            
            let view = tileViews[(j * 4) + i]
            
            let inlineTouchPoint = touch.locationInView(view)
            
            if view.circleView.frame.contains(inlineTouchPoint) {
                touched(View: view)
            }
        }
    }
    
    func touched(View view: PatternTileView) {
        func updatePattern() {
            for view in tileViews {
                view.state = patternTileViews.contains(view) ? TileState.Action : TileState.Default
            }
        }
        
        func append(View view: PatternTileView) {
            patternTileViews.append(view)
            
            updatePattern()
        }
        
        func removeLast() {
            patternTileViews.removeLast()
            
            updatePattern()
        }
        
        if patternTileViews.count == 0 {
            append(View: view)
            
            return
        }
        
        if patternTileViews.contains(view) {
            let patternLength = patternTileViews.count
            
            if patternLength > 1 {
                if view == patternTileViews[patternLength - 2] {
                    removeLast()
                }
            }
            
            return
        }
        
        guard let currentIndex = tileViews.indexOf(view) else {
            return
        }
        
        let currentX = currentIndex % 4
        let currentY = Int(floor(Double(currentIndex) / 4))
        
        guard let prevIndex = tileViews.indexOf(patternTileViews.last!) else {
            return
        }
        
        let prevX = prevIndex % 4
        let prevY = Int(floor(Double(prevIndex) / 4))
        
        if (((currentX == (prevX + 1)) || (currentX == (prevX - 1)) || currentX == prevX) &&
            ((currentY == (prevY + 1)) || (currentY == (prevY - 1)) || currentY == prevY)) {
            append(View: view)
        }
    }
    
    func extractPattern() -> String {
        var patternString = ""
        
        for view in patternTileViews {
            let index = tileViews.indexOf(view)
            
            patternString += String(format:"%X", index!)
        }
        
        return patternString
    }
}

// MARK: - LockPatternViewDelegate

protocol LockPatternViewDelegate: NSObjectProtocol {
    func lockPatternView(view: LockPatternView, producedPattern: String)
}
