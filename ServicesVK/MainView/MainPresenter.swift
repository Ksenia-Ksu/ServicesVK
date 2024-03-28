//
//  MainPresenter.swift
//  ServicesVK
//
//  Created by Ксения Кобак on 28.03.2024.
//

import Foundation

protocol MainPresenterProtocol {
    func showData(viewModel: [ServiceViewModel])
    func showError(error: String)
}

final class MainPresenter: MainPresenterProtocol {
   
    weak var controller: DisplayServices?
    
    init(controller: DisplayServices? = nil) {
        self.controller = controller
    }
    
    func showData(viewModel: [ServiceViewModel]) {
        self.controller?.displayFetchedModels(viewModel)
    }
    
    func showError(error: String) {
        self.controller?.displayError(error: error)
    }
}
