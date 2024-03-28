//
//  MainModuleBuilder.swift
//  ServicesVK
//
//  Created by Ксения Кобак on 28.03.2024.
//

import UIKit

struct MainModuleBuilder {
    func build() -> UIViewController {
        let networkServise = NetworkService()
        let presenter = MainPresenter()
        let interactor = MainInteractor(presenter: presenter, networkService: networkServise)
        let router = MainRouter()
        let vc = MainViewController(interactor: interactor, router: router)
        presenter.controller = vc
        router.viewController = vc
        return vc
    }
}

