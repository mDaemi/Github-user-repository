//
//  DetailCoordinator.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 08/08/2022.
//

import Foundation
import UIKit
class DetailCoordinator: Coordinator {

    var context: UIViewController?
    var navigationController: UINavigationController?
    required init() {
    }

    func start() {
        self.push(self.context)
    }

}
