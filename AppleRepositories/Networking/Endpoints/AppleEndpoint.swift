//
//  GitHubEndpoint.swift
//  AppleRepositories
//
//  Created by Michał on 10/02/2022.
//

import Foundation

enum RequestEndpoint: APIEndpoint {
    case getRequest

    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }

    var baseURL: String {
        switch self {
        default:
            return "api.github.com"
        }
    }

    var path: String {
        switch self {
        default:
            return "/search/repositories"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        default:
            return [URLQueryItem(name: "q", value: "org:apple+language:swift"),
                    URLQueryItem(name: "sort", value: "name"),
                    URLQueryItem(name: "order", value: "asc"),
                    URLQueryItem(name: "per_page", value: "100")
            ]
        }
    }

    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
}
