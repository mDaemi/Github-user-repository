//
//  RepositoryListTableViewViewModel.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 03/08/2022.
//

import Foundation

class RepositoryListTableViewViewModel<I:RepositoryProtocol>: SynchroProtocol {

    var repositories: Bindable<[RepositoryViewModel]> = Bindable([RepositoryViewModel]())
    internal var netWorkManager: NetWorkManagerProtocol?
    
    func getData(_ username: String) {
        netWorkManager?.getRepositoriesData(username) { [weak self]  repositories, error in
            if error == nil {
                var repositories_ = [RepositoryViewModel]()
                for repository in repositories {
                    let repositoryViewModel = RepositoryViewModel(repository)
                    repositories_.append(repositoryViewModel)
                }
                self?.repositories.value = repositories_
            }
        }
    }
    
    func getRepositoryViewModel( atIndexPath: IndexPath) -> RepositoryViewModel? {
        let index  = atIndexPath.row
        let repositories = repositories.value
        if repositories.count > index {
            return repositories[index]
        }
        return nil
    }
    
    func register(networkManager_: NetWorkManagerProtocol) {
        self.netWorkManager = networkManager_
    }
}

