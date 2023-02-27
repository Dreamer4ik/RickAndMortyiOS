//
//  RMCharacterGender.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 17.02.2023.
//

import Foundation

enum RMCharacterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case `unknown` = "unknown"
}
