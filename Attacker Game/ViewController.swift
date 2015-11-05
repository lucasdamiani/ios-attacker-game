//
//  ViewController.swift
//  Lecture 47
//
//  Created by Lucas Damiani on 03/11/15.
//  Copyright © 2015 Lucas Damiani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var player1AttackButton: UIButton!
    
    @IBOutlet weak var player2AttackButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    private var game = Game()
    
    private let INTERVAL_BETWEEN_ATTACKS = 3.0
    
    @IBAction func onPlayer1Attack() {
        onPlayerAttack("P1", attackButton: player1AttackButton, attackMethod: game.attackPlayer2)
    }
    
    @IBAction func onPlayer2Attack() {
        onPlayerAttack("P2", attackButton: player2AttackButton, attackMethod: game.attackPlayer1)
    }
    
    func toggleAttackButtonWithTimer(timer: NSTimer) {
        if let attackButton = timer.userInfo as? UIButton where !game.isFinished {
            toggleAttackButton(attackButton)
        }
    }
    
    private func onPlayerAttack(attackerId: String, attackButton: UIButton, attackMethod: () -> Bool) {
        if attackMethod() {
            showPlayersHp()
            toggleAttackButton(attackButton)
        }
        
        if game.isFinished {
            endGame(attackerId)
            askForRestart()
        } else {
            NSTimer.scheduledTimerWithTimeInterval(INTERVAL_BETWEEN_ATTACKS, target: self, selector: "toggleAttackButtonWithTimer:", userInfo: attackButton, repeats: false)
        }
    }
    
    private func showPlayersHp() {
        statusLabel.text = "P1 HP = \(game.player1.hp) | P2 HP = \(game.player2.hp)"
    }
    
    private func toggleAttackButton(attackButton: UIButton) {
        attackButton.enabled = !attackButton.enabled
    }
    
    private func endGame(winner: String) {
        statusLabel.text = "\(winner) won the game!"
        player1AttackButton.enabled = false
        player2AttackButton.enabled = false
    }
    
    private func restartGame() {
        game = Game()
        player1AttackButton.enabled = true
        player2AttackButton.enabled = true
        statusLabel.text = "Press attack"
    }
    
    private func askForRestart() {
        let restartAlertController = createRestartAlert()
        presentViewController(restartAlertController, animated: true, completion: nil)
        
    }
    
    private func createRestartAlert() -> UIAlertController {
        let restartAlertController = UIAlertController(title: "Game Over", message: "Would you like to restart the game?", preferredStyle: .Alert)
        let restartAction = UIAlertAction(title: "Yes", style: .Default, handler: {
            [unowned self] action in
            self.restartGame()
            })
        let cancelAction = UIAlertAction(title: "No", style: .Cancel, handler: {
            action in
            exit(0)
        })
        
        
        restartAlertController.addAction(restartAction)
        restartAlertController.addAction(cancelAction)
        restartAlertController.preferredAction = restartAction
        
        return restartAlertController
    }
}

