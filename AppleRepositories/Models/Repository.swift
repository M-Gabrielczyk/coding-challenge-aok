//
//  Repository.swift
//  AppleRepositories
//
//  Created by Michał on 09/02/2022.
//

import Foundation

struct RepositoryResult: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    let name: String
    let description: String?
    let creationDate: String
    let starCount: Int

    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case creationDate = "created_at"
        case starCount    = "stargazers_count"
    }
}
