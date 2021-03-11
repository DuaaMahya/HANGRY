//
//  Recipe.swift
//  HANGRY
//
//  Created by Dua Almahyani on 12/11/2020.
//

import Foundation

struct Recipe: Codable {
    var name: String
    var ingredient: [String : Int]
    var instructions: String
}
