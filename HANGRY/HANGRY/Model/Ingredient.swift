//
//  Ingredient.swift
//  HANGRY
//
//  Created by Dua Almahyani on 09/11/2020.
//

import Foundation
import UIKit

class Ingredient: Codable {
    
    let name: String
    var category: String
    var expiresDate: Date
    var quntity: Int
    var unit: String
    
    var ingredientKey: String
    
    
    
    init(name: String, category: String, expiresDate: Date, quntity: Int, unit: String) {
        self.name = name
        self.category = category
        self.expiresDate = expiresDate
        self.quntity = quntity
        self.unit = unit
        self.ingredientKey = ""
    }
}


enum Category: String, CaseIterable {
    case meat = "Meat"
    case drink = "Drink"
    case vegetable = "Vegetable"
    case fruit = "Fruit"
    case snacks = "Snacks"
    case cannedFood = "Canned Food"
    case grain = "Grain"
    case oil = "Oil"
    
}

enum measuringUnit: String, CaseIterable {
    case KiloGram = "Kg"
    case gram = "g"
    case litter = "L"
    case millieLitter = "mL"
    case cup = "Cup"
    case TBS = "TBS"
    case Tbsp = "Tbsp"
}
