//
//  RepositoriesTableViewCell.swift
//  AppleRepositories
//
//  Created by Michał on 09/02/2022.
//

import UIKit

class RepositoriesTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var repositoryDate: UILabel!
    @IBOutlet weak var repositoryStars: UILabel!

    // MARK: Methods
    static func nib() -> UINib {
        return UINib(nibName: "RepositoriesTableViewCell", bundle: nil)
    }
}
