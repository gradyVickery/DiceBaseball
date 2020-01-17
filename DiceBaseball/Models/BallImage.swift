//
//  BallImage.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/16/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import UIKit

class BallImage: UIView {
    
    weak var player: Player?
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
        ballImageView.frame = CGRect(x: 0.0, y: 0.0, width: 15, height: 15)
    }
    
    func ballTravelDistance(hit: Player.PlayResults) -> (CGFloat, CGFloat, TimeInterval) {
        
        var factor = CGFloat(Int.random(in: -3...3))
        if factor == 0.0 {
            factor = -1.0
        }
        
        switch hit {
        case .single:
            return (factor * 20.0, 70.0, 2.0)
        case .double:
            return (factor * 24.0, 100.0, 2.5)
        case .triple:
            return (factor * 30.0, 100.0, 3.0)
        default:
            return (factor * 40.0, 200.0, 4.0)
        }
    }
    
    // ball animation
    func animateBall(hit: Player.PlayResults) {
        
        if hit == .strikeout || hit == .walk {
            return
        }
        
        let distance = ballTravelDistance(hit: hit)
        let x = distance.0
        let y = distance.1
        let time = distance.2
        
        ballImageView.alpha = 1.0
        let originalPosition = ballImageView.center
        
        UIView.animateKeyframes(withDuration: time, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: {
                self.ballImageView.center.x += x
                self.ballImageView.center.y -= y
                self.ballImageView.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: {
                self.ballImageView.center.x += x
                self.ballImageView.center.y -= y
                self.ballImageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.67, relativeDuration: 0.33, animations: {
                self.ballImageView.center.x += x
                self.ballImageView.center.y -= y
                self.ballImageView.transform = .identity
                
            })
        }, completion: {
            _ in
            self.ballImageView.alpha = 0
            self.ballImageView.center = originalPosition
        })
    }
    
    
}
