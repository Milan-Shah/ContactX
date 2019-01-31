//
//  ProgressIndicator.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit

class ProgressIndicator: UIVisualEffectView {
    
    let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    let progressLabel = UILabel()
    let blurEffect = UIBlurEffect(style: .dark)
    let viualEffectView: UIVisualEffectView
    
    var text: String? {
        didSet {
            progressLabel.text = text
            progressLabel.textColor = UIColor.gray
        }
    }
    
    init(text: String) {
        self.text = text
        self.viualEffectView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setUpLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.viualEffectView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setUpLabel()
    }
    
    func setUpLabel() {
        contentView.addSubview(viualEffectView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(progressLabel)
        activityIndicator.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            let width = superview.frame.size.width / 1.8
            let height: CGFloat = 50.0
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                                y: superview.frame.height / 2 - height / 2,
                                width: width,
                                height: height)
            viualEffectView.frame = self.bounds
            let activityIndicatorSize: CGFloat = 20
            activityIndicator.frame = CGRect(x: 15,
                                             y: height / 2 - activityIndicatorSize / 2,
                                             width: activityIndicatorSize,
                                             height: activityIndicatorSize)
            
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            progressLabel.text = text
            progressLabel.textAlignment = NSTextAlignment.center
            progressLabel.frame = CGRect(x: activityIndicatorSize + 5,
                                         y: 0,
                                         width: width - activityIndicatorSize - 15,
                                         height: height)
            progressLabel.textColor = UIColor.white
            progressLabel.font = UIFont.boldSystemFont(ofSize: 10)
        }
    }
    
    func showProgress() {
        self.isHidden = false
    }
    
    func hideProgress() {
        self.isHidden = true
    }
}
