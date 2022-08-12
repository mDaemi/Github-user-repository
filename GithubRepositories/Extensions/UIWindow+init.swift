//
//  UIWindow+init.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 03/08/2022.
//

import Foundation
import UIKit

public extension UIWindow {

    func setup(_ rootVC: UIViewController?) {
        self.rootViewController = rootVC
        self.makeKeyAndVisible()
    }
}
