//
//  RepositoriesViewModel.swift
//  AppleRepositories
//
//  Created by Michał on 09/02/2022.
//

import Foundation
import Combine

// View Model for Repositories List
class RepositoriesViewModel: ObservableObject {

    // MARK: Properties
    @Published private(set) var dataLoadingStatus: DataLoadingStatus = .finished

    var repositories = PassthroughSubject<[Repository], Never>()

    private var cancellables = Set<AnyCancellable>()
    private var networkStatus: Bool = true
    private let networkMonitor =  NetworkStatus()
    private let dateFormatter = DateFormatter()
    private let apiClient = APIClient()


    /// Check network connection
     func checkConnection() {
        networkMonitor.startMonitoring()
        networkMonitor.isConnected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.networkStatus = status
            }
            .store(in: &cancellables)
    }
    /// Format received date from received format to  defined format
    func formatDate(_ dateString: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return "N/A"
        }
    }
    /// Fetching repositories with defined Endpoint
    func fetchRepositories() {
      
      checkConnection()
        
        if !networkStatus {
            self.dataLoadingStatus = .noInternet
            return
        }

        self.dataLoadingStatus = .inProgress
        
        apiClient.request(endpoint: RequestEndpoint.getRequest) { [weak self] (result: Result<RepositoryResult, APIError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.repositories.send(response.items)
                self.dataLoadingStatus = .finished
            case .failure(let error):
                print(error)
                self.dataLoadingStatus = .failure
            
            }
        }
    }
}
