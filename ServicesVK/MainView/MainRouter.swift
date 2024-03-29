//
//  MainRouter.swift
//  ServicesVK
//
//  Created by Ксения Кобак on 28.03.2024.
//

import UIKit


protocol MainRouting {
    func routeToPage(_ webPage: String)
    func routeToAlert(title: String, message: String, completion: @escaping(() -> Void))
}

final class MainRouter: MainRouting {
    
    weak var viewController: UIViewController?
    
    func routeToPage(_ webPage: String) {
        viewController?.navigationController?.pushViewController(WebViewController(link: webPage), animated: true)
    }
    
    func routeToAlert(title: String, message: String, completion: @escaping(() -> Void)) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Reload", style: .default, handler: { _ in
            completion()
        })
                                     
        alertController.addAction(okAction)
        viewController?.present(alertController, animated: true)
    }

}

