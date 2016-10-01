//
//  ViewController.swift
//  rpgoop
//
//  Created by Andrew Foster on 9/13/16.
//  Copyright © 2016 Foster Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var printLbl: UILabel!
    
    @IBOutlet weak var playerHpLbl: UILabel!
    
    @IBOutlet weak var enemyHpLbl: UILabel!
    
    @IBOutlet weak var enemyImg: UIImageView!
    
    @IBOutlet weak var enemyImg2: UIImageView!
    
    @IBOutlet weak var chestBtn: UIButton!
    
    var player: Player!
    var enemy: Enemy!
    var chestMessage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player(name: "Dark Lord", hp: 110, attackPwr: randomAttackPower(50))
        
        generateRandomEnemy()
        
        playerHpLbl.text = "\(player.hp) HP"
        
    
    }
    
    func randomAttackPower(random: Int) -> Int {
        let currentAttack = arc4random_uniform(UInt32(random))
        return Int(currentAttack)
    }
    
    func generateRandomEnemy() {
        let rand = Int(arc4random_uniform(2))
        
        if rand == 0 {
            enemy = Kimara(startingHp: 60, attackPwr: 12)
            enemyImg.hidden = false
    
        } else {
            enemy = DevilWizard(startingHp: 90, attackPwr: 15)
            enemyImg2.hidden = false
        }
        
        enemyHpLbl.text = "\(enemy.hp) HP"
    }

    @IBAction func onChestTapped(sender: AnyObject) {
        chestBtn.hidden = true
        printLbl.text = chestMessage
        
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.generateRandomEnemy), userInfo: nil, repeats: false)
    }

    @IBAction func attackTapped(sender: AnyObject) {
        
        if enemy.attemptAttack(player.attackPwr) {
            printLbl.text = "Attacked \(enemy.type) for \(player.attackPwr) HP"
            enemyHpLbl.text = "\(enemy.hp) HP"
            
        } else {
            
            printLbl.text = "Attack was unsuccessful!"
        }
        
        if let loot = enemy.dropLoot() {
            player.addItemToInventory(loot)
            chestMessage = "\(player.name) found \(loot)"
            chestBtn.hidden = false
        }
        
        if !enemy.isAlive {
            enemyHpLbl.text = ""
            printLbl.text = "Killed \(enemy.type)"
            enemyImg.hidden = true
            enemyImg2.hidden = true
        }
    }

}
