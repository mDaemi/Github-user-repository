//
//  UserCoordinator.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 09/08/2022.
//

import Foundation
import UIKit

protocol UserCoordinatorProtocol {
    func goToRepositories(withUsername: String)
}
class UserCoordinator: Coordinator, UserCoordinatorProtocol {

    var context: UIViewController?
    var navigationController: UINavigationController?
    
    required init() {
    }

    func start() {
        self.push(self.context)
    }

    func goToRepositories(withUsername: String) {
        let screen = RepositoryListTableViewController(withUsername)
        let listCoordinator = ListCoordinator(from: context, screen: screen)
        screen.registerCoordinator(coordinator: listCoordinator)
        listCoordinator.start()
    }
}
