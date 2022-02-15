//
//  Endpoint.swift
//  AppleRepositories
//
//  Created by Michał on 10/02/2022.
//

import Foundation

protocol APIEndpoint {

    /// HTTPS or HTTPS
    var scheme: String { get }

    /// Example: "api.github.com"
    var baseURL: String { get }

    /// Example: "/search/repositories"
    var path: String { get }

    /// Example: [URLQueryItem(name: "sort", value: "name"]
    var parameters: [URLQueryItem] { get }

    /// HTTPMethod, Example: "GET"
    var method: String { get }
}
