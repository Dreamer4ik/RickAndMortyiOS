//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 17.02.2023.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
}
