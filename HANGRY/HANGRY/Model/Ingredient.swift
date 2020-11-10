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
//    var imageURL: URL
    
    init(name: String, category: String, expiresDate: Date, quntity: Int, unit: String) {
        self.name = name
        self.category = category
        self.expiresDate = expiresDate
        self.quntity = quntity
        self.unit = unit
        //self.imageURL = imageURL
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
    case litter = "ltr"
    case cup = "Cup"
    case TBS = "TBS"
    case Tbsp = "Tbsp"
}

//enum Category: Int, Pri {
//    case meat = 0
//    case drink = 1
//    case vegetable = 2
//    case fruit = 3
//    case snacks = 4
//    case cannedFood = 5
//    case grain = 6
//    case oil = 7
//
//    var description: String {
//        switch self {
//        case .meat: return "Meat"
//        case .drink: return "Drink"
//        case .vegetable: return "Vegitable"
//        case .fruit: return "Fruit"
//        case .snacks: return "Snacks"
//        case .cannedFood: return "Canned Food"
//        case .grain: return "Grain"
//        case .oil: return "Oil"
//        }
//    }
//}
//
//enum measuringUnit: Int, CaseIterable {
//    case KiloGram = 0
//    case gram = 1
//    case litter = 2
//    case cup = 3
//    case TBS = 4
//    case Tbsp = 5
//
//    var description: String {
//        switch self {
//        case .KiloGram: return "Kg"
//        case .gram: return "g"
//        case .litter: return "ltr"
//        case .cup: return "Cup"
//        case .TBS: return "TBS"
//        case .Tbsp: return "Tbsp"
//        }
//    }
//}
