//
//  ViewController.swift
//  probationVKula
//
//  Created by Мария Кочетова on 27.03.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables
    var services: [Service] = []
    let tableView = UITableView()
    let loadService = LoadService()

    override func viewDidLoad() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ServiceCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 100

        self.navigationItem.title = "Сервисы"
        loadService.loadServices { services in
            DispatchQueue.main.async {
                self.services = services
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ServiceCell
        let service = services[indexPath.row]
        cell.configureCell(with: service)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let url = services[indexPath.row].link else { return }
        UIApplication.shared.openURL(url)
    }
}

