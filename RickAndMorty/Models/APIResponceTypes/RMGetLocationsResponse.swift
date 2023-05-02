//
//  RMGetLocationsResponse.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 27.04.2023.
//

import Foundation

struct RMGetAllLocationsResponse: Codable {
    let info: RMGetAllLocationsResponseInfo
    let results: [RMLocation]
}

struct RMGetAllLocationsResponseInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
