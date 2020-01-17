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
    var field: UIImage?
    var outs = 0
    
    var runnersText = "Testing"
    
    // baserunners
    var isOn1st = false
    var isOn2nd = false
    var isOn3rd = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum BaseRunners: String {
        case empty = "No runners on base"
        case first = "Runner on first"
        case second = "Runner on second"
        case third = "Runner on third"
        case firstSecond = "Runners on first and second"
        case firstThird = "Runners on first and third"
        case secondThird = "Runners on second and third"
        case basesLoaded = "Bases are loaded!"
    }
    
    func createSubviews() {

        field = UIImage(named: "bases2ndField")!
        
        mainLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        mainLabel.center = CGPoint(x: screenWidth/2, y: screenHeight/2 - 40)
        mainLabel.textColor = .white
        mainLabel.textAlignment = .center
        mainLabel.font = UIFont.boldSystemFont(ofSize: 34)
        mainLabel.shadowColor = UIColor.black
        mainLabel.shadowOffset = CGSize(width: 3, height: 3)
        
        secondaryLabel.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 100)
        secondaryLabel.text = "Press 'New Game' to start"
        secondaryLabel.center = CGPoint(x: screenWidth/2, y: screenHeight/2 + 40)
        secondaryLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        secondaryLabel.textColor = .white
        secondaryLabel.textAlignment = .center
        secondaryLabel.shadowColor = UIColor.black
        secondaryLabel.shadowOffset = CGSize(width: 1, height: 4)
       
    }
    
    func handleResults(rollResult: Player.PlayResults) -> Int {
        
        var runsScored = 0
        mainLabel.text = rollResult.rawValue
        slideMainLabelIn(withDelay: 0.5)
        slideMainLabelOut(withDelay: 5.0)

        switch (rollResult) {
        case .out:
            outs += 1
            
            break
        case .single:
            runsScored += singleHandler()
        case .walk:
            runsScored += singleHandler()
        case .double:
            runsScored += doubleHandler()
        case .triple:
            runsScored += tripleHandler()
        case .homerun:
            runsScored += homeRunHandler()
        default:
            secondaryLabel.text = "In default territory"
        }
        
        configureRunners() // sets field image and runnerText
     
        // if runs score, display on screen
        if runsScored > 0 {
            runsScoreLabel(runs: runsScored)
            delay(2.8) {
                self.secondaryLabel.text = self.runnersText
                self.slideSecondaryLabelIn(withDelay: 0.2)
                self.slideSecondaryLabelOut(withDelay: 2.0)
            }
        } else {
            secondaryLabel.text = runnersText
            slideSecondaryLabelIn(withDelay: 1.2)
            slideSecondaryLabelOut(withDelay: 4.0)
        }
        
        return runsScored
    }
    
    
    // Set field Image
    func configureRunners() {
        switch (isOn1st, isOn2nd, isOn3rd) {
        case (false, false, false):
            runnersText = BaseRunners.empty.rawValue
            field = UIImage(named: "basesEmptyField")
        case (true, false, false):
            runnersText = BaseRunners.first.rawValue
            field = UIImage(named: "bases1stField")
        case (false, true, false):
            runnersText = BaseRunners.second.rawValue
            field = UIImage(named: "bases2ndField")
        case (false, false, true):
            runnersText = BaseRunners.third.rawValue
            field = UIImage(named: "bases3rdField")
        case (true, true, false):
            runnersText = BaseRunners.firstSecond.rawValue
            field = UIImage(named: "bases1st2ndField")
        case (true, false, true):
            runnersText = BaseRunners.firstThird.rawValue
            field = UIImage(named: "bases1st3rdField")
        case (false, true, true):
            runnersText = BaseRunners.secondThird.rawValue
            field = UIImage(named: "bases2nd3rdField")
        case (true, true, true):
            runnersText = BaseRunners.basesLoaded.rawValue
            field = UIImage(named: "basesLoadedField")
        }
    }
    
    // set label if runs scored
    func runsScoreLabel(runs: Int) {
        if runs == 1 {
            secondaryLabel.text = "Run scored!"
        } else {
            secondaryLabel.text = "\(runs) runs scored!!!"
        }
        slideSecondaryLabelIn(withDelay: 1.0)
        slideSecondaryLabelOut(withDelay: 2.4)
    }
    
    // MARK:- Hit handlers
    func singleHandler() -> Int {
        var runsScored = 0
        
        switch (isOn1st, isOn2nd, isOn3rd) {
        case (false, false, false):
            isOn1st = true
        case (true, false, false):
            isOn2nd = true
        case (false, true, false):   //<-Ability to score from second on single????
            isOn1st = true
            isOn2nd = false
            isOn3rd = true
        case (false, false, true):
            isOn1st = true
            isOn3rd = false
            runsScored += 1
        case (true, true, false):
            isOn3rd = true
        case (true, false, true):
            isOn2nd = true
            isOn3rd = false
            runsScored += 1
        case (true, true, true):
            runsScored += 1
        default:
            print("default value in hit handler reached")
        }
        return runsScored
    }
    
    func doubleHandler() -> Int {
        var runsScored = 0
        
        switch (isOn1st, isOn2nd, isOn3rd) {
        case (false, false, false):
            isOn2nd = true
        case (true, false, false):
            isOn1st = false
            isOn2nd = true
            isOn3rd = true
        case (false, true, false):   //<-Ability to score from second on single????
            runsScored += 1
        case (false, false, true):
            isOn2nd = true
            isOn3rd = false
            runsScored += 1
        case (true, true, false):
            isOn1st = false
            isOn3rd = true
            runsScored += 1
        case (true, false, true):
            isOn1st = false
            isOn2nd = true
            runsScored += 1
        case (true, true, true): //<- multiple runs on double here?
            isOn1st = false
            runsScored += 2
        default:
            print("default value in hit(double) handler reached")
        }
        return runsScored
    }
    
    func tripleHandler() -> Int {
        var runsScored = 0
        
        switch (isOn1st, isOn2nd, isOn3rd) {
        case (false, false, false):
            isOn3rd = true
        case (true, false, false):
            isOn1st = false
            isOn3rd = true
            runsScored += 1
        case (false, true, false):   //<-Ability to score from second on single????
            isOn2nd = false
            isOn3rd = true
            runsScored += 1
        case (false, false, true):
            runsScored += 1
        case (true, true, false):
            isOn1st = false
            isOn3rd = true
            runsScored += 2
        case (true, false, true):
            isOn1st = false
            runsScored += 2
        case (true, true, true): //<- multiple runs on double here?
            isOn1st = false
            isOn2nd = false
            runsScored += 3
        default:
            print("default value in hit(double) handler reached")
        }
        return runsScored
    }
    
    func homeRunHandler() -> Int {
        var runsScored = 0
        
        switch (isOn1st, isOn2nd, isOn3rd) {
        case (false, false, false):
            isOn3rd = false
            runsScored += 1
        case (true, false, false):
            isOn1st = false
            runsScored += 2
        case (false, true, false):   //<-Ability to score from second on single????
            isOn2nd = false
            runsScored += 2
        case (false, false, true):
            isOn3rd = false
            runsScored += 2
        case (true, true, false):
            isOn1st = false
            isOn2nd = false
            runsScored += 3
        case (true, false, true):
            isOn1st = false
            isOn3rd = false
            runsScored += 3
        case (true, true, true): //<- multiple runs on double here?
            isOn1st = false
            isOn2nd = false
            isOn3rd = false
            runsScored += 4
        default:
            print("default value in hit(double) handler reached")
        }
        return runsScored
    }
    
    // MARK:- Label Animations
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
    
    func onFirstHit(hit: Player.PlayResults) -> Int {
        let runs = 0
        
        
        
        return runs
    }
}
