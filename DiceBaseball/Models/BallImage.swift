//
//  BallImage.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/16/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import UIKit

class BallImage: UIView {
    
    var ballImageView = UIImageView()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {
        ballImageView.image = UIImage(named: "baseballColored")
        ballImageView.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        
        
        
    }
    
    // ball animation experiment
    func animateBall() {
        
        ballImageView.alpha = 1.0
        let originalPosition = ballImageView.center
        
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: {
                self.ballImageView.center.x += 40.0
                self.ballImageView.center.y -= 200
                self.ballImageView.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: {
                self.ballImageView.center.x += 40.0
                self.ballImageView.center.y -= 200.0
                self.ballImageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.67, relativeDuration: 0.33, animations: {
                self.ballImageView.center.x += 40.0
                self.ballImageView.center.y -= 200.0
                self.ballImageView.transform = .identity
                
            })
        }, completion: {
            _ in
            self.ballImageView.alpha = 0
            self.ballImageView.center = originalPosition
        })
    }
    
    
}
