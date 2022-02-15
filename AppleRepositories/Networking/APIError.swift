//
//  APIError.swift
//  AppleRepositories
//
//  Created by Michał on 10/02/2022.
//

import Foundation

/// Localized Errors for API Request
enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptedData
    case decodingError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return AppStrings.APIErrors.invalidURL
        case .invalidResponseStatus:
            return AppStrings.APIErrors.invalidResponse
        case .dataTaskError(let string):
            return string
        case .corruptedData:
            return AppStrings.APIErrors.corruptedData
        case .decodingError(let string):
            return string
        }
    }
}
