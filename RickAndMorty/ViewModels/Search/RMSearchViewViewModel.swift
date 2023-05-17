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
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption: String] = [:]
    private var searchText = ""
    
    // MARK: - Init
    init(config: SearchConfig) {
        self.config = config
    }
    
    // MARK: - Public
    public func executeSearch() {
        // Create request based on filters
        // Send API Call
        // Notify view of results, no results, error
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(
        _ block: @escaping ((RMSearchInputViewViewModel.DynamicOption, String)) -> Void
    ) {
        self.optionMapUpdateBlock = block
    }
}
