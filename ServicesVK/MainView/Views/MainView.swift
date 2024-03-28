//
//  MainView.swift
//  ServicesVK
//
//  Created by Ксения Кобак on 28.03.2024.
//

import UIKit

protocol DisplaysData: UIView {
    func configure(with viewModel: [ServiceViewModel])
    func display(with error: String)
    func startLoading()
    func stopLoading()
}

protocol ServiceTapHandler: AnyObject {
    func serviceIsSelected(url: String)
}

final class MainView: UIView {
    
    private var servicesList: [ServiceViewModel]
    private var delegate: ServiceTapHandler
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.backgroundColor =  Colors.text?.withAlphaComponent(0.3)
        //tableView.layer.cornerRadius = 15
        //tableView.isHidden = true
        tableView.register(ServiceCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.isHidden = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
   
    init(servicesList: [ServiceViewModel], delegate: ServiceTapHandler) {
        self.servicesList = servicesList
        self.delegate = delegate
        super.init(frame: .zero)
        self.backgroundColor = .black
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupView()
        setupConstraint()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .black
        self.addSubview(tableView)
        self.addSubview(activityIndicator)
    }

    private func setupConstraint() {
         NSLayoutConstraint.activate([
            
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.insets.top),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Layout.insets.bottom),
            self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Layout.insets.left),
            self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Layout.insets.right),
        ])
    }
}
// MARK: - DisplaysData
extension MainView: DisplaysData  {
    
    func display(with error: String) {
        self.tableView.isHidden = true
        stopLoading()
        print("error in view came")
      
    }
    
    func configure(with viewModel: [ServiceViewModel]) {
        self.servicesList = viewModel
        tableView.reloadData()
        tableView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
}

// MARK: - UITableViewDelegate UITableViewDataSource
extension MainView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        servicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ServiceCell
        cell?.configure(image: servicesList[indexPath.row].iconURL,
                        title: servicesList[indexPath.row].name,
                        subtitle: servicesList[indexPath.row].description)
        
  

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.serviceIsSelected(url: servicesList[indexPath.row].link)
    }
}

extension MainView {
    enum Layout {
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
