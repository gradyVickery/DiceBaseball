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
        mainLabel.shadowColor = UIColor.black
        mainLabel.shadowOffset = CGSize(width: 3, height: 3)
        
        secondaryLabel.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 100)
        secondaryLabel.text = "Testing 1, 2, 3"
        secondaryLabel.center = CGPoint(x: screenWidth/2, y: screenHeight/2 + 40)
        secondaryLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        secondaryLabel.textColor = .white
        secondaryLabel.textAlignment = .center
        
        secondaryLabel.shadowColor = UIColor.black
        secondaryLabel.shadowOffset = CGSize(width: 1, height: 4)
       
    }
    
    func slideMainLabelIn(withDelay delay: Double) {
        mainLabel.center.x -= screenWidth
        mainLabel.alpha = 1
        UIView.animate(withDuration: 0.5, delay: delay, options: [], animations:  {
            self.mainLabel.center.x += self.screenWidth
            }, completion: nil)
    }
    
    func slideMainLabelOut(withDelay delay: Double) {
        UIView.animate(withDuration: 0.5, delay: delay, options: [], animations:  {
                   self.mainLabel.center.x -= self.screenWidth
        }, completion: {
            finished in
            self.mainLabel.alpha = 0.0
            self.mainLabel.text = ""
            self.mainLabel.center.x = self.screenWidth/2
        })
    }
    func fadeMainLabelOut(withDelay delay: Double) {
        mainLabel.alpha = 1
        UIView.animate(withDuration: 2.0, delay: delay, options: [], animations: {
            self.mainLabel.alpha = 0.0
        }, completion: {
            finished in
            self.mainLabel.text = ""
        } )
    }
    
    func slideSecondaryLabelIn(withDelay delay: Double) {
        secondaryLabel.center.x -= screenWidth
        secondaryLabel.alpha = 1
        UIView.animate(withDuration: 0.5, delay: delay, options: [], animations: {
            self.secondaryLabel.center.x += self.screenWidth
        }, completion: nil)
    }
    func slideSecondaryLabelOut(withDelay delay: Double) {
        UIView.animate(withDuration: 0.5, delay: delay, options: [], animations:  {
            self.secondaryLabel.center.x -= self.screenWidth
        }, completion: {
            finished in
            self.secondaryLabel.alpha = 0.0
            self.secondaryLabel.text = ""
            self.secondaryLabel.center.x = self.screenWidth/2
        })
    }
}
