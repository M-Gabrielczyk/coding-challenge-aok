//
//  APIGenericRequest.swift
//  AppleRepositories
//
//  Created by Michał on 10/02/2022.
//

import Foundation

// Generic API Request for fetching the data with error handling
class APIClient {

     func request<T: Codable> (endpoint: APIEndpoint, completion: @escaping (Result<T, APIError>) -> Void) {

        let decoder = JSONDecoder()

        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host   = endpoint.baseURL
        components.path   = endpoint.path
        components.queryItems = endpoint.parameters

        guard let url = components.url else { fatalError(AppStrings.APIErrors.invalidURL) }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in

            guard error == nil else {
                completion(.failure(APIError.dataTaskError("Something went wrong")))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }

            guard response != nil, let data = data else { fatalError(AppStrings.APIErrors.invalidResponse) }

            DispatchQueue.main.async {
                if let responseObject = try? decoder.decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error =  APIError.corruptedData
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
