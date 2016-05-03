//
//  ViewController.swift
//  LockPattern
//
//  Created by gunesmert on 03/05/16.
//
//

import UIKit
import PureLayout

private let pattern = "C84059A637BF"

class ViewController: UIViewController {
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        
        let lockPatternView = LockPatternView.newAutoLayoutView()
        lockPatternView.delegate = self
        
        view.addSubview(lockPatternView)
        
        lockPatternView.autoCenterInSuperview()
        lockPatternView.autoSetDimensionsToSize(CGSize(width: TileDimension * 4, height: TileDimension * 4))
        
        
        let topLabel = UILabel.newAutoLayoutView()
        topLabel.font = UIFont.systemFontOfSize(36.0)
        topLabel.textColor = UIColor.darkJungleGreenColor()
        topLabel.textAlignment = NSTextAlignment.Center
        topLabel.text = "LockPattern"
        
        view.addSubview(topLabel)
        
        topLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero,
                                                        excludingEdge: ALEdge.Bottom)
        topLabel.autoPinEdge(ALEdge.Bottom,
                             toEdge: ALEdge.Top,
                             ofView: lockPatternView)
        
        
        let bottomLabel = UILabel.newAutoLayoutView()
        bottomLabel.textColor = UIColor.darkJungleGreenColor()
        bottomLabel.textAlignment = NSTextAlignment.Center
        bottomLabel.text = "https://github.com/gunesmert"
        
        view.addSubview(bottomLabel)
        
        bottomLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero,
                                                           excludingEdge: ALEdge.Top)
        bottomLabel.autoPinEdge(ALEdge.Top,
                                toEdge: ALEdge.Bottom,
                                ofView: lockPatternView)
    }
}

// MARK: - LockPatternViewDelegate

extension ViewController: LockPatternViewDelegate {
    func lockPatternView(view: LockPatternView, producedPattern: String) {
        view.updatePatternWith(State: producedPattern == pattern ? TileState.Success : TileState.Error)
    }
}
