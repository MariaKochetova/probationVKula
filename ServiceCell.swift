//
//  ServiceCell.swift
//  probationVKula
//
//  Created by Мария Кочетова on 29.03.2024.
//

import Foundation
import UIKit

class ServiceCell: UITableViewCell {
    let serviceImage = UIImageView()
    let serviceArrow = UIImageView()
    let serviceName = UILabel()
    let serviceDescription = UILabel()

    override func prepareForReuse() {
        serviceImage.image = nil
        serviceName.text = nil
        serviceDescription.text = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(serviceImage)
        contentView.addSubview(serviceName)
        contentView.addSubview(serviceDescription)
        contentView.addSubview(serviceArrow)
        serviceImage.translatesAutoresizingMaskIntoConstraints = false
        serviceName.translatesAutoresizingMaskIntoConstraints = false
        serviceDescription.translatesAutoresizingMaskIntoConstraints = false
        serviceArrow.translatesAutoresizingMaskIntoConstraints = false

        serviceImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        serviceImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        serviceImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        serviceImage.widthAnchor.constraint(equalTo: serviceImage.heightAnchor).isActive = true
        serviceImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true

        serviceName.leadingAnchor.constraint(
            equalTo: serviceImage.trailingAnchor,
            constant: 8
        ).isActive = true
        serviceName.trailingAnchor.constraint(
            lessThanOrEqualTo: serviceArrow.leadingAnchor,
            constant: -8
        ).isActive = true

        serviceName.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 8
        ).isActive = true
        serviceName.bottomAnchor.constraint(
            equalTo: serviceDescription.topAnchor,
            constant: -4
        ).isActive = true

        serviceDescription.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 8).isActive = true
        serviceDescription.leadingAnchor.constraint(equalTo: serviceName.leadingAnchor).isActive = true
        serviceDescription.trailingAnchor.constraint(
            equalTo: serviceArrow.leadingAnchor,
            constant: -8
        ).isActive = true
        serviceDescription.numberOfLines = 0

        serviceArrow.widthAnchor.constraint(equalToConstant: 20).isActive = true
        serviceArrow.heightAnchor.constraint(equalToConstant: 20).isActive = true
        serviceArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        serviceArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        serviceArrow.image = UIImage(systemName: "chevron.right")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with service: Service) {
        serviceName.text = service.name
        serviceDescription.text = service.description
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: service.iconUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.serviceImage.image = image
                    }
                }
            }
        }
    }
}
