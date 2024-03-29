//
//  LoadService.swift
//  probationVKula
//
//  Created by Мария Кочетова on 29.03.2024.
//

import Foundation

struct ServiceResponse: Decodable {
    let body: Body

    struct Body: Decodable {
        let services: [Service]
    }
}

struct Service: Decodable {
    var name: String
    var description: String
    var link: URL?
    var iconUrl: URL
}

class LoadService {
    func loadServices(completion: @escaping ([Service]) -> Void) {
        let url = URL(string: "https://publicstorage.hb.bizmrg.com/sirius/result.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let serviceResponse = try? decoder.decode(ServiceResponse.self, from: data) {
                completion(serviceResponse.body.services)
            }
        }
        task.resume()
    }
}
