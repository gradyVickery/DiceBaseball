//
//  BaseballCardViewController.swift
//  BaseballGame
//
//  Created by Grady Vickery on 4/3/18.
//  Copyright © 2018 Grady Vickery. All rights reserved.
//

import UIKit

class BaseballCardViewController: UIViewController {

    var currentBatter = Player(firstName: "Test", lastName: "Name", number: 13, position: .catcher, hitterType: .Average)
    var teamName = ""
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var jerseyNumberLabel: UILabel!
    @IBOutlet weak var hitterTypeLabel: UILabel!
    @IBOutlet var diceResults: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillCard()
      
    }

    @IBAction func backToMainButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // fill card info
    func fillCard() {
    
        fullNameLabel.text = currentBatter.firstName + currentBatter.lastName
        positionLabel.text = currentBatter.position.rawValue
        teamNameLabel.text = currentBatter.teamName
        jerseyNumberLabel.text = String(currentBatter.number)
        hitterTypeLabel.text = currentBatter.hitterType.rawValue
        
        // for loop to get diceResults
        var control = 1
        var resultIndex = 0
        for i in 1...6 {
            for j in 1...6 {
                if i >= control && j >= control {
                    diceResults[resultIndex].text = currentBatter.getDiceResults(dice1: i, dice2: j).rawValue
                    resultIndex += 1
                }
            }
            control += 1
        }
    }
}
