//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 02.05.2023.
//

import Foundation


// Responsibilities:
// - show search results
// - show no results view
// - kick off API requests
final class RMSearchViewViewModel {
    let config: SearchConfig
    
    init(config: SearchConfig) {
        self.config = config
    }
}
