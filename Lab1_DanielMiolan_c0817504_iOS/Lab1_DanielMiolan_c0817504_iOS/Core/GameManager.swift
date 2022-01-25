//
//  GameManager.swift
//  Lab1_DanielMiolan_c0817504_iOS
//
//  Created by Daniel Miolan on 1/18/22.
//

import Foundation
import UIKit

class GameManager {
    // Attributes
    private var playerPoints: Int
    private var oponentPoints: Int
    private var takenPositions: [Int] = [Int]()
    private var playerSelection: [Int] = [Int]()
    private var oponentSelection: [Int] = [Int]()
    private var gameStart: Bool
    private var playBtn: UIButton
    private var selectionBtns: [UIButton]
    private var resultLabel: UILabel
    private var scoreLabel: UILabel
    private var didPlayerTap: Bool
    private var lastMove: Int
    
    // Constructor
    init() {
        playerPoints = 0
        oponentPoints = 0
        lastMove = -1
        gameStart = false
        didPlayerTap = false
        playBtn = UIButton()
        selectionBtns = [UIButton]()
        resultLabel = UILabel()
        scoreLabel = UILabel()
    }
    
    // Start the game and allow player to select areas
    func Start() -> Void {
        ResetGame()
        gameStart = true
        AnimateOpacity(btn: playBtn, opacity: 0, speed: 0.5, delay: 0)
    }
    
    // Player selection
    func SelectPosition(index: Int) -> Void {
        // Check if game start
        if !gameStart {
            return
        }
        
        // Check if current button is available
        if IsPositionAvailable(index: index) {
            // save last player moves
            lastMove = index - 1
            
            // Select if oponent area if AI is not active
            if didPlayerTap {
                didPlayerTap = false
                oponentSelection.append(index)
                PerformSelection(index: index, imageName: "cross")
                CheckWinner(isPlayer: false)
            } else {
                didPlayerTap = true
                playerSelection.append(index)
                PerformSelection(index: index, imageName: "nought")
                CheckWinner(isPlayer: true)
            }
        }
    }
    
    // Reset the game and keep score
    func ResetGame() -> Void {
        didPlayerTap = false
        takenPositions.removeAll()
        playerSelection.removeAll()
        oponentSelection.removeAll()
        
        resultLabel.text = ""
        
        for btn in selectionBtns {
            btn.setBackgroundImage(nil, for: .normal)
        }
    }
    
    // Reset the game with score
    func ResetBoard() -> Void {
        playerPoints = 0
        oponentPoints = 0
        scoreLabel.text = "0 : 0"
        EndGame()
        ResetGame()
    }
    
    // Undue player move
    func UndoMove() -> Void {
        if !gameStart {
            return
        }
        
        if lastMove >= 0 {
            selectionBtns[lastMove].setBackgroundImage(nil, for: .normal)
            
            if didPlayerTap {
                
                playerSelection.remove(at: playerSelection.count - 1)
            } else {
                oponentSelection.remove(at: oponentSelection.count - 1)
            }
            
            lastMove = -1
            didPlayerTap = !didPlayerTap
            takenPositions.remove(at: takenPositions.count - 1)
        }
    }
    
    // Setters for UI ref elements
    func SetScoreLabel(scoreLabel: UILabel) -> Void {
        self.scoreLabel = scoreLabel
    }
    
    func SetResultLabel(resultLabel: UILabel) -> Void {
        self.resultLabel = resultLabel
    }
    
    func SetPlayButton(playBtn: UIButton) -> Void {
        self.playBtn = playBtn
    }
    
    func SetSelectionButtons(selectionBtns: [UIButton]) -> Void {
        self.selectionBtns = selectionBtns
    }
    
    // Check position availability
    private func IsPositionAvailable(index: Int) -> Bool {
        return !takenPositions.contains(index)
    }
    
    // Perform final selection by player or AI
    private func PerformSelection(index: Int, imageName: String) -> Void {
        let tempBtn = selectionBtns[index - 1];
        let tempImg = UIImage(named: imageName)
        
        takenPositions.append(index)
        AnimateOpacity(btn: tempBtn, opacity: 0, speed: 0.2, delay: 0)
        tempBtn.setBackgroundImage(tempImg, for: .normal)
        AnimateOpacity(btn: tempBtn, opacity: 1, speed: 0.2, delay: 0)
    }
    
    // Check who is winner
    private func CheckWinner(isPlayer: Bool) -> Void {
        if takenPositions.count < 4 {
            return
        }
        
        var didWin = false
        // Select list of selected position
        let positions = isPlayer ? playerSelection : oponentSelection
        
        // Check if horizontal match
        let row1 = positions.contains(1) && positions.contains(2)  && positions.contains(3)
        let row2 = positions.contains(4) && positions.contains(5)  && positions.contains(6)
        let row3 = positions.contains(7) && positions.contains(8)  && positions.contains(9)
        
        // Check if vertical match
        let col1 = positions.contains(1) && positions.contains(4)  && positions.contains(7)
        let col2 = positions.contains(2) && positions.contains(5)  && positions.contains(8)
        let col3 = positions.contains(3) && positions.contains(6)  && positions.contains(9)
        
        // Check diagonal match
        let diag1 = positions.contains(1) && positions.contains(5)  && positions.contains(9)
        let diag2 = positions.contains(3) && positions.contains(5)  && positions.contains(7)
        
        // Set win true if any condition is true
        didWin = row1 || row2 || row3 || col1 || col2 || col3 || diag1 || diag2
        
        // Check if win, or can't peform more moves
        if !didWin && takenPositions.count >= 9 {
            EndGame()
            resultLabel.text = "Even"
        } else if didWin {
            EndGame()
            
            // Check if player or oponent wins
            if isPlayer {
                playerPoints += 1
                resultLabel.text = "You Win"
            } else {
                oponentPoints += 1
                resultLabel.text = "You Lose"
            }
            
            // Update score
            scoreLabel.text = "\(playerPoints) : \(oponentPoints)"
        }
    }
    
    // Finish the game and display play button again
    private func EndGame() -> Void {
        gameStart = false
        playBtn.setTitle("Play Again", for: .normal)
        AnimateOpacity(btn: playBtn, opacity: 1, speed: 0.5, delay: 0)
    }
    
    // Function to hanlde opacity animations
    private func AnimateOpacity(btn: UIButton, opacity: CGFloat, speed: Float, delay: Float) -> Void {
        UIView.animate(withDuration: 1, delay: TimeInterval(delay)) {
            btn.alpha = opacity
        }
    }
}
