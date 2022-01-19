//
//  ViewController.swift
//  Lab1_DanielMiolan_c0817504_iOS
//
//  Created by Daniel Miolan on 1/18/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet var buttonList: Array<UIButton>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for btn in buttonList {
            print("We have Tag #\(btn.tag)")
        }
    }

    @IBAction func PlayGame(_ sender: UIButton) {
        print("Start Game")
    }
    
    @IBAction func SelectPosition(_ sender: UIButton) {
        print("Tap on Button #\(sender.tag)")
    }
}

