//
//  NetworkService.swift
//  ServicesVK
//
//  Created by Ксения Кобак on 28.03.2024.
//

import UIKit

protocol NetworkServiceProtocol {
    func getServices(completion: @escaping (Result<[ServiceViewModel], Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private let url = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
    
    func getServices(completion: @escaping (Result<[ServiceViewModel], any Error>) -> Void) {
        DispatchQueue.main.async {
            guard let url = URL(string: self.url)   else { return }
            let session = URLSession(configuration: .default)
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) { data, _, error in
                if let data = data {
                    let items = self.parseJSONData(data)
                    DispatchQueue.main.async {
                        completion(.success(items))
                    }
                }
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
            }
            task.resume()
        }
    }
    
    // MARK: - parse json
    private func parseJSONData(_ data: Data) -> [ServiceViewModel] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ServiceModel.self, from: data)
            let services = decodedData.body.services
            var models: [ServiceViewModel] = []
            services.forEach {
                
                let model = ServiceViewModel(
                    name: $0.name,
                    description: $0.description,
                    link: $0.link,
                    iconURL: $0.iconURL
                )
                models.append(model)
            }
            return models
        } catch {
            print(error)
            return []
        }
    }
}

