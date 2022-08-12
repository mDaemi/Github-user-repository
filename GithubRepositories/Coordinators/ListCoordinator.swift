//
//  ListCoordinator.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 03/08/2022.
//

import Foundation
import UIKit

protocol ListCoordinatorProtocol {
    func goToDetail(withModel: RepositoryViewModel)
}
class ListCoordinator: Coordinator, ListCoordinatorProtocol {

    var context: UIViewController?
    var navigationController: UINavigationController?
    
    required init() {
    }

    func start() {
        self.push(self.context)
    }

    func goToDetail(withModel: RepositoryViewModel) {
        let detailCoordinator = DetailCoordinator(from: context, screen: RepositoryDetailsViewController(withModel))
        detailCoordinator.start()
    }
}

