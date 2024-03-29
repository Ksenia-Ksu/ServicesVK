//
//  ServiceCell.swift
//  ServicesVK
//
//  Created by Ксения Кобак on 28.03.2024.
//

import UIKit

class ServiceCell: UITableViewCell {
    
    private lazy var imageViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var hStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .fillProportionally
        hStack.spacing = 10
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.spacing = 8
        vStack.distribution = .fillProportionally
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.numberOfLines = 1
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.text = "error from server"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.textAlignment = .left
        subtitle.numberOfLines = 2
        subtitle.font = UIFont.systemFont(ofSize: 15)
        subtitle.text = "error from server"
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()
    
    private lazy var chevron: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "Cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        addSubviews()
        makeConstraints()
    }
    
    func configure(image: String, title: String, subtitle: String) {
        DispatchQueue.global().async {
            guard let imageURL = URL(string: image),
                  let imageData = try? Data(contentsOf: imageURL)
            else {
                DispatchQueue.main.async {
                    self.imageViewCell.image = UIImage(systemName: "questionmark")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.imageViewCell.image = UIImage(data: imageData)
            }

        }
        self.title.text = title
        self.subtitle.text = subtitle
    }
    
    private func addSubviews() {
        self.addSubview(hStack)
        hStack.addArrangedSubview(imageViewCell)
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(chevron)
        vStack.addArrangedSubview(title)
        vStack.addArrangedSubview(subtitle)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 0),
            hStack.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: 0),
            hStack.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 0),
            hStack.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 0),
            
            imageViewCell.widthAnchor.constraint(equalToConstant: 80),
            imageViewCell.heightAnchor.constraint(equalToConstant: 80),
            
            chevron.heightAnchor.constraint(equalToConstant: 20),
            chevron.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
}
