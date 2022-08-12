//
//  Coordinators.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 03/08/2022.
//

import UIKit
protocol Coordinator {

    var context: UIViewController? { get set }
    var navigationController: UINavigationController? { get set }
    func push(_ viewController: UIViewController?)
    func present(_ viewController: UIViewController?)
    init()
    init(from: UIViewController?, screen: UIViewController?)
    func start()
}

extension Coordinator {

    func push(_ viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }

    func present(_ viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }
        navigationController?.present(viewController, animated: true, completion: nil)
    }

     init(from: UIViewController?, screen: UIViewController?) {
        self.init()
        context = screen
        if let from = from as? UINavigationController {
            navigationController = from
        } else {
        navigationController = from?.navigationController ?? MyNavigationController()
        }
    }
}

