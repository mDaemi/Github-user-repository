//
//  UIview+reuseIdentifier.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 03/08/2022.
//

import Foundation

protocol ReuseIdentifierProtocol {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifierProtocol {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
        }
}

