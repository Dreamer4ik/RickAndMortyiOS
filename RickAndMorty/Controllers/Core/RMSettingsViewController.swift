//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 13.02.2023.
//

import StoreKit
import SafariServices
import SwiftUI
import UIKit


/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {
    // MARK: - Properties
    private var settingsSwiftUIController: UIHostingController<RMSettingsView>?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSwiftUIController()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Settings"
    }
    
    private func addSwiftUIController() {
        let settingsSwiftUIController = UIHostingController(
            rootView: RMSettingsView(
                viewModel: RMSettingsViewViewModel(
                    cellViewModels: RMSettingsOption.allCases.compactMap({
                        return RMSettingsCellViewModel(type: $0) { [weak self] option in
                            self?.handleTap(option: option)
                        }
                    })
                )
            )
        )
        
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.addConstraintsToFillViewWithoutSafeArea(view)
        
        self.settingsSwiftUIController = settingsSwiftUIController
    }
    
    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        
        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if option == .rateApp {
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
    
    // MARK: - Actions
}
