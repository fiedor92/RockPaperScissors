//
//  GameStatContorller.swift
//  RockPaperScissors WatchKit Extension
//
//  Created by appacmp on 26/07/15.
//  Copyright (c) 2015 Maciej Fiedorowicz. All rights reserved.
//

import Foundation
import WatchKit

class GameStatController: WKInterfaceController{
    
    @IBOutlet weak var gamesPlayedLabel: WKInterfaceLabel!
    @IBOutlet weak var highScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var currentScoreLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        if let newDict = context as? [String: String],
            highScore = newDict["highScore"],
            currentScore = newDict["currentScore"],
            gamePlayed = newDict["gamePlayes"]
        {
            gamesPlayedLabel.setText(gamePlayed)
            highScoreLabel.setText(highScore)
            currentScoreLabel.setText(currentScore)
        }
        
    }
}
