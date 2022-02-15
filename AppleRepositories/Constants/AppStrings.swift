//
//  AppStrings.swift
//  AppleRepositories
//
//  Created by Michał on 09/02/2022.
//

import Foundation

enum AppStrings {

  enum General {
      public static let viewTitle = "Apple Repositories"
  }

    enum APIErrors {
        public static let invalidURL      = "The URL is invalid"
        public static let invalidResponse = "Invalid request response"
        public static let decodingError   = "Decoding process failed "
        public static let corruptedData   = "The data provided appears to be corrupt"
        public static let dataTaskError   = "Unable to fetch the data"
    }

    enum AlertMessage {
        public static let tryAgain   = "Try again"
        public static let networkErrorMessage = "Please check your internet connection"
        public static let generalErrorMessage = "Something went wrong"
    }

}
