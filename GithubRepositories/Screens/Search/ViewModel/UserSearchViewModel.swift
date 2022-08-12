//
//  UserSearchViewModel.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 09/08/2022.
//

import Foundation

protocol SynchroProtocol {
    var netWorkManager: NetWorkManagerProtocol? { get set }
    func register(networkManager_: NetWorkManagerProtocol)
}

class UserSearchViewModel<I:UserProtocol>: SynchroProtocol {
    var username : String!
    private var viewModel : UserViewModel?
    var user: Bindable<UserViewModel?> = Bindable(nil)
    internal var netWorkManager: NetWorkManagerProtocol?
    
    func getData() {
        netWorkManager?.getUserData(username) { [weak self]  user, error in
            if error == nil {
                var user_: UserViewModel?
                let userViewModel = UserViewModel(user!)
                user_ = userViewModel
                self?.user.value = user_
            }
        }
    }
    
    func getUser() -> UserViewModel? {
        return user.value
    }
    
    func register(networkManager_: NetWorkManagerProtocol) {
        self.netWorkManager = networkManager_
    }
}


