//
//  ViewController.swift
//  ServicesVK
//
//  Created by Ксения Кобак on 28.03.2024.
//

import UIKit


protocol DisplayServices: AnyObject {
    func displayFetchedModels(_ viewModel: [ServiceViewModel])
    func displayError(error: String)
}

class MainViewController: UIViewController {
    
    private lazy var contentView: DisplaysData = MainView(servicesList: [], delegate: self)
    
    private let interactor: MainInteractor
    private let router: MainRouting
    
    init(interactor: MainInteractor, router: MainRouting) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.startLoading()
        self.interactor.fetchData()
        navBarSettings()
        
    }
    
    private func navBarSettings() {
        self.title = "Сервисы"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension MainViewController: DisplayServices {
    
    func displayFetchedModels(_ viewModel: [ServiceViewModel]) {
        self.contentView.configure(with: viewModel)
    }
    
    func displayError(error: String) {
        self.contentView.display(with: error)
    }
}

extension MainViewController: ServiceTapHandler {
    
    func serviceIsSelected(url: String) {
        self.router.routeToPage(url)
    }
}

