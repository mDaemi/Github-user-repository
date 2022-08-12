//
//  Dynamic.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 04/08/2022.
//

import Foundation

class Bindable<T> {
   
    typealias Listener = (T) -> Void
    var listener: Listener?

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }
    
}


