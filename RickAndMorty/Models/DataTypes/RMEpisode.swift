//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 13.02.2023.
//

import Foundation

struct RMEpisode: Codable, RMEpisodeDataRender {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
