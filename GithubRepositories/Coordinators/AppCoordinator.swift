//
//  AppCoordinator.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 03/08/2022.
//

import Foundation
import UIKit
class AppCoordinator: Coordinator {

    var context: UIViewController?
    var navigationController: UINavigationController?

    required init() {
    }

//    func start() {
//        let listCoordinator = ListCoordinator(from: navigationController, screen: context)
//        if let context = context as? ListCoordinatorScreen {
//            context.registerCoordinator(coordinator: listCoordinator)
//        }
//        listCoordinator.start()
//    }
    
    func start() {
        let userCoordinator = UserCoordinator(from: navigationController, screen: context)
        if let context = context as? UserCoordinatorScreen {
            context.registerCoordinator(coordinator: userCoordinator)
        }
        userCoordinator.start()
    }

    func configureAndStartFromWindow( _ window: UIWindow) {
        window.setup(navigationController)
        start()
    }
}

