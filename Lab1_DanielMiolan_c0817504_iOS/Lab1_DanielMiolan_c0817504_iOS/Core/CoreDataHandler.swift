//
//  CoreDataHandler.swift
//  Lab1_DanielMiolan_c0817504_iOS
//
//  Created by Daniel Miolan on 1/24/22.
//

import UIKit
import Foundation
import CoreData

class CoreDataHandler {
    // Prepare Cpre Data usage
    private var players = [Player]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        LoadData()
        
        // For quick reset
        //SaveData(playerScore: 0, oponentScore: 0, playerMoves: [Int](), oponentMoves: [Int]())
    }
    
    func GetGameState() -> [Player] {
        return players
    }
    
    // Save Data
    func SaveData(playerScore: Int, oponentScore: Int, playerMoves: [Int], oponentMoves: [Int]) {
        // Perform Update or Creation
        let player = players.count > 0 ?  players[0] : Player(context: self.context);
        let oponent = players.count > 0 ?  players[1] : Player(context: self.context);
        
        player.score = Int32(playerScore)
        player.moves = playerMoves
        
        oponent.score = Int32(oponentScore)
        oponent.moves = oponentMoves
    
        self.SavePlayerModel()
    }
    
    // Save Data
    func SavePlayerModel() {
        do {
            try context.save()
        } catch {
            print("Error saving the folder \(error.localizedDescription)")
        }
    }
    
    // Load Data
    func LoadData() {
        let request: NSFetchRequest<Player> = Player.fetchRequest()
        
        do {
            players = try context.fetch(request)
        } catch {
            print("Error loading data \(error.localizedDescription)")
        }
    }
}
