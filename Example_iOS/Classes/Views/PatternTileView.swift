//
//  PatternTileView.swift
//  Hipofis
//
//  Created by gunesmert on 03/05/16.
//  Copyright © 2016 Hipo. All rights reserved.
//

import UIKit
import PureLayout

enum TileState: Int {
    case Default
    case Success
    case Error
    case Action
}

class PatternTileView: UIView {
    var circleView: UIView!
    
    var state: TileState! {
        didSet {
            switch state! {
            case .Default:
                circleView.backgroundColor = UIColor.ironColor()
            case .Success:
                circleView.backgroundColor = UIColor.caribbeanGreenColor()
            case .Error:
                circleView.backgroundColor = UIColor.fireEngineRedColor()
            case .Action:
                circleView.backgroundColor = UIColor.pictonBlueColor()
            }
        }
    }
    
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
        circleView = UIView.newAutoLayoutView()
        circleView.layer.cornerRadius = 20.0
        
        addSubview(circleView)
        
        circleView.autoCenterInSuperview()
        circleView.autoSetDimensionsToSize(CGSize(width: 40.0, height: 40.0))
        
        state = TileState.Default
    }
}
