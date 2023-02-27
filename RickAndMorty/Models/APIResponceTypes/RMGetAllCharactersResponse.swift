//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 26.02.2023.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    let info: RMGetAllCharactersResponseInfo
    let results: [RMCharacter]
}

struct RMGetAllCharactersResponseInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
