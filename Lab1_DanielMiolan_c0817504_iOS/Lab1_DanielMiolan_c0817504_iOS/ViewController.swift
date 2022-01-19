//
//  ViewController.swift
//  Lab1_DanielMiolan_c0817504_iOS
//
//  Created by Daniel Miolan on 1/18/22.
//

import UIKit

class ViewController: UIViewController {

    private var gameManager: GameManager = GameManager()
    private var gestureList: [UISwipeGestureRecognizer.Direction] = [.left, .right, .up, .down]
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet var buttonList: Array<UIButton>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gameManager.SetScoreLabel(scoreLabel: scoreLabel)
        gameManager.SetResultLabel(resultLabel: resultLabel)
        gameManager.SetPlayButton(playBtn: playBtn)
        gameManager.SetSelectionButtons(selectionBtns: buttonList)
        
        for gesture in gestureList {
            let tempSwipe = UISwipeGestureRecognizer(target: self, action: #selector(PerformSwipe))
            tempSwipe.direction = gesture
            view.addGestureRecognizer(tempSwipe)
        }
    }

    @IBAction func PlayGame(_ sender: UIButton) {
        gameManager.Start()
    }
    
    @IBAction func SelectPosition(_ sender: UIButton) {
        gameManager.SelectPosition(index: sender.tag)
    }
    
    @objc func PerformSwipe(gesture: UISwipeGestureRecognizer) -> Void {
        let swipeGesture = gesture as UISwipeGestureRecognizer
        
        switch swipeGesture.direction {
            case .left, .right, .up, .down:
                gameManager.ResetBoard()
            default:
                break
        }
    }
}

