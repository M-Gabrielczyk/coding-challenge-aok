//
//  ViewController.swift
//  AppleRepositories
//
//  Created by Michał on 09/02/2022.
//

import UIKit
import Combine

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    @IBOutlet private weak var repositoriesTableView: UITableView!

    private var viewModel    = RepositoriesViewModel()
    private var repositories = [Repository]()
    private var cancelabless = Set<AnyCancellable>()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    


    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupTableView()
        handleLoadingStatus()
        viewModel.fetchRepositories()
    }

    /// Check if data was succesfully loaded and proceed errors
    func handleLoadingStatus() {

        viewModel.repositories
            .receive(on: DispatchQueue.main)
            .sink {[weak self] repositories in
                self?.repositories = repositories
                self?.repositoriesTableView.reloadData()
            }
            .store(in: &cancelabless)

        let loadingStatus: (DataLoadingStatus) -> Void = { [weak self] state in
            switch state {
            case .finished:
                self?.activityIndicator.stopAnimating()
            case .inProgress:
                self?.repositoriesTableView.backgroundView = self?.activityIndicator
                self?.activityIndicator.startAnimating()
            case .noInternet:
                self?.showLoadingStatusError(message: AppStrings.AlertMessage.networkErrorMessage,
                                             action: UIAlertAction(
                                                title: AppStrings.AlertMessage.tryAgain,
                                                style: .destructive,
                                                handler: {_ in self?.viewModel.fetchRepositories()}))
            case .failure:
                self?.showLoadingStatusError(message: AppStrings.AlertMessage.generalErrorMessage,
                                             action: UIAlertAction(
                                                title: AppStrings.AlertMessage.tryAgain,
                                                style: .destructive,
                                                handler: {_ in self?.viewModel.fetchRepositories()}))
            }
        }
        viewModel.$dataLoadingStatus
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: loadingStatus )
            .store(in: &cancelabless)
    }

// MARK: - Setup UI & Table View

    func setUpView() {
        title = AppStrings.General.viewTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupTableView() {

        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        repositoriesTableView.register(RepositoriesTableViewCell.nib(), forCellReuseIdentifier: "RepositoriesTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoriesTableViewCell",
                                                       for: indexPath) as? RepositoriesTableViewCell
        else {
            print("Failed to load cell Data")
            return UITableViewCell()
        }
        let repository = repositories[indexPath.row]
        cell.repositoryName.text        = repository.name
        cell.repositoryDescription.text = repository.description
        cell.repositoryDate.text        = viewModel.formatDate(repository.creationDate)
        cell.repositoryStars.text       = String(repository.starCount)

        return cell
    }
}

// MARK: - Loading State Extension
extension RepositoriesViewController {
    // Show alert with a message and action to proceed.
    func showLoadingStatusError(message: String, action: UIAlertAction) {
        let loadingAlert = UIAlertController(
            title: message,
            message: nil,
            preferredStyle: .alert
        )

        loadingAlert.addAction(action)
        present(loadingAlert, animated: true, completion: nil)
    }
}
