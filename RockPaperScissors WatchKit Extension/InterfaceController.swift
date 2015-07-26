//
//  InterfaceController.swift
//  RockPaperScissors WatchKit Extension
//
//  Created by appacmp on 26/07/15.
//  Copyright (c) 2015 Maciej Fiedorowicz. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var oponentSymbol: WKInterfaceImage!
    @IBOutlet weak var resultLabel: WKInterfaceLabel!
    @IBOutlet weak var scoreLabel: WKInterfaceLabel!
    
    let defaults = NSUserDefaults(suiteName: "group.com.gmail.macfiedo.RockPaperScissors")!
    
    var score = 0
    var gamesCounter = 0
    var highScore = 0
    let symbols = ["rock", "paper", "scissors"]
    
    @IBAction func resetGame() {
        oponentSymbol.setImage(nil)
        score = 0
        resultLabel.setText("Tap  icon to start")
        scoreLabel.setText("0")
    }
    @IBAction func choosePaper() {
        play("paper")
    }
    @IBAction func chooseRock() {
        play("rock")
    }
    
    @IBAction func chooseScissors() {
        play("scissors")
    }
    
    @IBAction func showGameStats() {
        highScore  = getHighScoreFromDefaults()
        
        pushControllerWithName("GameStat", context: ["currentScore":"\(score)", "highScore": "\(highScore)", "gamePlayes":"\(gamesCounter)"])
    }
    func play(symbol: String) {
        gamesCounter = gamesCounter + 1
        
        let oponentPick = symbols[Int(arc4random_uniform(3))]
        oponentSymbol.setImage(UIImage(named: oponentPick))
        
        if oponentPick == symbol {
            resultLabel.setText("Tie. +1")
            score += 1
        }
        else{
            var won = false
            switch symbol{
                case "rock":
                    if oponentPick == "scissors" {
                        won = true
                }
                case "paper":
                    if oponentPick == "rock"{
                        won = true
                }
                case "scissors":
                    if oponentPick == "paper"{
                        won = true
                }
            default: resultLabel.setText("Unrecognized symbol")
            }
            if won {
                resultLabel.setText("You won! +5")
                score += 5
            }
            else{
                resultLabel.setText("You lost! -2")
                score -= 2
            }
            
        }
        scoreLabel.setText("\(score)")
        updateHighScore()

    }
    
    func getHighScoreFromDefaults() -> Int {
        var highScoreFromDefaults = defaults.objectForKey("highscore") as? Int
        
        return (highScoreFromDefaults != nil) ? highScoreFromDefaults! : 0
    }
    
    func updateHighScore(){
        highScore = getHighScoreFromDefaults()
        
        if (score > highScore){
            defaults.setObject(score, forKey: "highscore")
            defaults.synchronize()
        }
        
    }

}
