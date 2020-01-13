//
//  Dice.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/13/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import UIKit

class Dice: UIView {

    let leftDiceImage = UIImageView()
    let rightDiceImage = UIImageView()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum DiceValues: Int {
        case one = 1
        case two
        case three
        case four
        case five
        case six
    }
       
    func createSubviews() {
        
           
        leftDiceImage.image = UIImage(named: "Dice2")
        leftDiceImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        leftDiceImage.center = CGPoint(x: screenWidth/2 - 30, y: screenHeight - 135)
           
        rightDiceImage.image = UIImage(named: "Dice6")
        rightDiceImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        rightDiceImage.center = CGPoint(x: screenWidth/2 + 30, y: screenHeight - 135)
           
    }

    func rollDice() -> (Int, Int) {
        var leftDiceRoll = Int.random(in: 1...6)
        var rightDiceRoll = Int.random(in: 1...6)
               
        // leftDice should be equal or less than right
        if leftDiceRoll > rightDiceRoll {
            let diceTemp = leftDiceRoll
            leftDiceRoll = rightDiceRoll
            rightDiceRoll = diceTemp
        }
        
        leftDiceImage.image = UIImage(named: "Dice\(leftDiceRoll)")
        rightDiceImage.image = UIImage(named: "Dice\(rightDiceRoll)")
        
        return (leftDiceRoll, rightDiceRoll)
    }

    func animateDice() {
        // Before dice animation setup
        leftDiceImage.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        rightDiceImage.transform = CGAffineTransform(rotationAngle: .pi + .pi / 2)
        leftDiceImage.center.x -= 50
        rightDiceImage.center.x += 50
        leftDiceImage.center.y += 300
        rightDiceImage.center.y += 300
        leftDiceImage.alpha = 1
        rightDiceImage.alpha = 1
    
        //animate dice in
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.8, options: [], animations: {
            self.leftDiceImage.center = CGPoint(x: self.screenWidth/2 - 30, y: self.screenHeight - 135)
            self.leftDiceImage.transform = CGAffineTransform(rotationAngle: .pi / 2)
            self.rightDiceImage.center = CGPoint(x: self.screenWidth/2 + 30, y: self.screenHeight - 135)
            self.rightDiceImage.transform = CGAffineTransform(rotationAngle: -.pi - .pi / 2)
            }, completion: nil)
    }
}
