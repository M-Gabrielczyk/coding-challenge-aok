//
//  DataLoadingStatus.swift
//  AppleRepositories
//
//  Created by Michał on 09/02/2022.
//

import Foundation

// Types of loading status errors 
enum DataLoadingStatus {
  case finished
  case inProgress
  case noInternet
  case failure
}
