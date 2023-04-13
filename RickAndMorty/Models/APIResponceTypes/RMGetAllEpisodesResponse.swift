//
//  RMGetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 12.04.2023.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    let info: RMGetAllEpisodesResponseInfo
    let results: [RMEpisode]
}

struct RMGetAllEpisodesResponseInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
