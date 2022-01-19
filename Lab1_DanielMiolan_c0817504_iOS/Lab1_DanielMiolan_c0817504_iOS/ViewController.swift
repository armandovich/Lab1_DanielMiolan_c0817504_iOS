//
//  ViewController.swift
//  Lab1_DanielMiolan_c0817504_iOS
//
//  Created by Daniel Miolan on 1/18/22.
//

import UIKit

class ViewController: UIViewController {
    // Create game manager and gesture list
    private var gameManager: GameManager = GameManager()
    private var gestureList: [UISwipeGestureRecognizer.Direction] = [.left, .right, .up, .down]
    
    // Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet var buttonList: Array<UIButton>!
    @IBOutlet weak var oponentSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Send UI elemts reference that will be changing dureng gameplay
        gameManager.SetScoreLabel(scoreLabel: scoreLabel)
        gameManager.SetResultLabel(resultLabel: resultLabel)
        gameManager.SetPlayButton(playBtn: playBtn)
        gameManager.SetSelectionButtons(selectionBtns: buttonList)
        
        // Add all swipe direction gesture to view
        for gesture in gestureList {
            let tempSwipe = UISwipeGestureRecognizer(target: self, action: #selector(PerformSwipe))
            tempSwipe.direction = gesture
            view.addGestureRecognizer(tempSwipe)
        }
    }

    // Action to start the game
    @IBAction func PlayGame(_ sender: UIButton) {
        gameManager.Start()
    }
    
    // Action to select button
    @IBAction func SelectPosition(_ sender: UIButton) {
        gameManager.SelectPosition(index: sender.tag)
    }
    
    // Check swipe direction
    @objc func PerformSwipe(gesture: UISwipeGestureRecognizer) -> Void {
        let swipeGesture = gesture as UISwipeGestureRecognizer
        
        switch swipeGesture.direction {
            case .left, .right, .up, .down:
                gameManager.ResetBoard()
            default:
                break
        }
    }
    
    // Turn off/on AI oponent
    @IBAction func ToggleOponentAI(_ sender: UISwitch) {
        gameManager.SetIsOponentAI(isOponentAI: sender.isOn)
    }
}

