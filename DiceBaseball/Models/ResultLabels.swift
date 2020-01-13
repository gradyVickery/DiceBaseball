//
//  ResultLabels.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/13/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import UIKit

class ResultLabels: UIView {

    let mainLabel = UILabel()
    let secondaryLabel = UILabel()
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

        mainLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        mainLabel.text = "Testing 1, 2, 3"
        mainLabel.center = CGPoint(x: screenWidth/2, y: screenHeight/2 - 40)
        mainLabel.textColor = .white
        mainLabel.textAlignment = .center
        mainLabel.font = UIFont.boldSystemFont(ofSize: 34)
        
        secondaryLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        secondaryLabel.text = "Testing 1, 2, 3"
        secondaryLabel.center = CGPoint(x: screenWidth/2, y: screenHeight/2 + 40)
        secondaryLabel.textColor = .white
        secondaryLabel.textAlignment = .center
    }
    
    func slideMainLabelIn() {
        
        mainLabel.alpha = 1
        mainLabel.center.x -= screenWidth
        UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations:  {
            self.mainLabel.center.x += self.screenWidth
            }, completion: {
                finished in
                self.slideMainLabelOut()
        })
    }
    
    func slideMainLabelOut() {
        UIView.animate(withDuration: 0.5, delay: 3.0, options: [], animations:  {
                   self.mainLabel.center.x -= self.screenWidth
        }, completion: {
            finished in
            self.mainLabel.alpha = 0.0
            self.mainLabel.center.x = self.screenWidth/2
        })
    }
    
    func slideSecondaryLabelIn() {
        
    }
    func slideSecondaryLabelOut() {
        
    }
}
