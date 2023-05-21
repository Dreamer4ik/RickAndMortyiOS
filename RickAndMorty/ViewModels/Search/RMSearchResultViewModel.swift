//
//  RMSearchResultViewModel.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 21.05.2023.
//

import Foundation

enum RMSearchResultViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
