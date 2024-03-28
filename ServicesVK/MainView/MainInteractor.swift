//
//  MainInteractor.swift
//  ServicesVK
//
//  Created by Ксения Кобак on 28.03.2024.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func fetchData()
}

final class MainInteractor: MainInteractorProtocol {
    
    private let presenter: MainPresenterProtocol
    private let networkService: NetworkServiceProtocol
    
    init(presenter: MainPresenterProtocol, networkService: NetworkServiceProtocol ) {
        self.presenter = presenter
        self.networkService = networkService
    }
    
    func fetchData() {
        self.networkService.getServices { result in
            switch result {
            case let .success(items):
                self.presenter.showData(viewModel: items)
            case let .failure(error):
                self.presenter.showError(error: error.localizedDescription)
            }
        }
    }
}
