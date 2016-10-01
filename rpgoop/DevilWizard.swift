//
//  DevilWizard.swift
//  rpgoop
//
//  Created by Andrew Foster on 9/13/16.
//  Copyright © 2016 Foster Inc. All rights reserved.
//

import Foundation

class DevilWizard: Enemy {
    
    override var loot: [String] {
        return ["Magic Wand", "Dark Amulet", "Salted Pork"]
    }
    
    override var type: String {
        return "Devil Wilard"
    }
}