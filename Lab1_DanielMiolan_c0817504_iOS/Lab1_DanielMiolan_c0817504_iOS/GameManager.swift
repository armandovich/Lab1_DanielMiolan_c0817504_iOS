//
//  GameManager.swift
//  Lab1_DanielMiolan_c0817504_iOS
//
//  Created by Daniel Miolan on 1/18/22.
//

import Foundation
import UIKit

class GameManager {
    private var moveCount: Int
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
    private var isOponentAI: Bool
    private var didPlayerTap: Bool
    
    init() {
        moveCount = 0
        playerPoints = 0
        oponentPoints = 0
        gameStart = false
        isOponentAI = false
        didPlayerTap = false
        playBtn = UIButton()
        selectionBtns = [UIButton]()
        resultLabel = UILabel()
        scoreLabel = UILabel()
    }
    
    func Start() -> Void {
        ResetGame()
        gameStart = true
        AnimateOpacity(btn: playBtn, opacity: 0, speed: 0.5, delay: 0)
    }
    
    func SelectPosition(index: Int) -> Void {
        if !gameStart {
            return
        }
        
        if IsPositionAvailable(index: index) {
            let tempIsPlayer = didPlayerTap
            
            moveCount += 1
            
            if !isOponentAI && didPlayerTap {
                didPlayerTap = false
                oponentSelection.append(index)
                PerformSelection(index: index, imageName: "nought")
                CheckWinner(isPlayer: false)
            } else {
                didPlayerTap = true
                playerSelection.append(index)
                PerformSelection(index: index, imageName: "cross")
                CheckWinner(isPlayer: true)
                
                if isOponentAI {
                    OponentSelection()
                    didPlayerTap = false
                }
            }
        }
    }
    
    func ResetGame() -> Void {
        moveCount = 0
        didPlayerTap = false
        takenPositions.removeAll()
        playerSelection.removeAll()
        oponentSelection.removeAll()
        
        resultLabel.text = ""
        
        for btn in selectionBtns {
            btn.setBackgroundImage(nil, for: .normal)
        }
    }
    
    func ResetBoard() -> Void {
        playerPoints = 0
        oponentPoints = 0
        scoreLabel.text = "0 : 0"
        EndGame()
        ResetGame()
    }
    
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
    
    func SetIsOponentAI(isOponentAI: Bool) -> Void {
        self.isOponentAI = isOponentAI
        
        if isOponentAI && didPlayerTap {
            OponentSelection()
            didPlayerTap = false
        }
    }
    
    private func OponentSelection() -> Void {
        if !gameStart || moveCount >= 9 {
            return
        }
        
        let index = Int.random(in: 1..<10)
        
        if IsPositionAvailable(index: index) {
            oponentSelection.append(index)
            PerformSelection(index: index, imageName: "nought")
            moveCount += 1
            CheckWinner(isPlayer: false)
        } else {
            OponentSelection()
        }
    }
    
    private func IsPositionAvailable(index: Int) -> Bool {
        return !takenPositions.contains(index)
    }
    
    private func PerformSelection(index: Int, imageName: String) -> Void {
        let tempBtn = selectionBtns[index - 1];
        let tempImg = UIImage(named: imageName)
        let tempDelay: Float = imageName == "cross" || !isOponentAI ? 0 : 0.5
        
        takenPositions.append(index)
        AnimateOpacity(btn: tempBtn, opacity: 0, speed: 0, delay: 0)
        tempBtn.setBackgroundImage(tempImg, for: .normal)
        AnimateOpacity(btn: tempBtn, opacity: 1, speed: 0.5, delay: tempDelay)
    }
    
    private func CheckWinner(isPlayer: Bool) -> Void {
        if moveCount < 4 {
            return
        }
        
        var didWin = false
        let positions = isPlayer ? playerSelection : oponentSelection
        
        let row1 = positions.contains(1) && positions.contains(2)  && positions.contains(3)
        let row2 = positions.contains(4) && positions.contains(5)  && positions.contains(6)
        let row3 = positions.contains(7) && positions.contains(8)  && positions.contains(9)
        
        let col1 = positions.contains(1) && positions.contains(4)  && positions.contains(7)
        let col2 = positions.contains(2) && positions.contains(5)  && positions.contains(8)
        let col3 = positions.contains(3) && positions.contains(6)  && positions.contains(9)
        
        let diag1 = positions.contains(1) && positions.contains(5)  && positions.contains(9)
        let diag2 = positions.contains(3) && positions.contains(5)  && positions.contains(7)
        
        didWin = row1 || row2 || row3 || col1 || col2 || col3 || diag1 || diag2
        
        if !didWin && moveCount >= 9 {
            EndGame()
            resultLabel.text = "Even"
        } else if didWin {
            EndGame()
            
            if isPlayer {
                playerPoints += 1
                resultLabel.text = "You Win"
            } else {
                oponentPoints += 1
                resultLabel.text = "You Lose"
            }
            
            scoreLabel.text = "\(playerPoints) : \(oponentPoints)"
        }
    }
    
    private func EndGame() -> Void {
        gameStart = false
        playBtn.setTitle("Play Again", for: .normal)
        AnimateOpacity(btn: playBtn, opacity: 1, speed: 0.5, delay: 0)
    }
    
    private func AnimateOpacity(btn: UIButton, opacity: CGFloat, speed: Float, delay: Float) -> Void {
        UIView.animate(withDuration: 1, delay: TimeInterval(delay)) {
            btn.alpha = opacity
        }
    }
}
