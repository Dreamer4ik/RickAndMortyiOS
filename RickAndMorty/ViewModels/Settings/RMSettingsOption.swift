//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 20.04.2023.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://coinmarketcap.com/")
        case .terms:
            return URL(string: "https://web.postman.co/")
        case .privacy:
            return URL(string: "https://translate.google.com/?hl=ru")
        case .apiReference:
            return URL(string: "https://github.com/")
        case .viewSeries:
            return URL(string: "https://about.gitlab.com/")
        case .viewCode:
            return URL(string: "https://www.youtube.com/")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms Of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "View Video Series"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemGreen
        case .terms:
            return .red
        case .privacy:
            return .systemYellow
        case .apiReference:
            return .systemOrange
        case .viewSeries:
            return .systemPurple
        case .viewCode:
            return .systemPink
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewSeries:
            return UIImage(systemName: "tv.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
