//
//  RepositoryViewModel.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 04/08/2022.
//

import Foundation

class RepositoryViewModel {
    var id: Int?
    var name: String?
    var fullName: String?
    var watchersCount: Int?
    var language: String?
    var description: String?
    var avatarURL: String?
    
    init(_ repo:RepositoryProtocol) {
        self.id = repo.getId()
        self.name = repo.getName()
        self.fullName = repo.getFullName()
        self.watchersCount = repo.getWatchersCount()
        self.language = repo.getLanguage()
        self.fullName = repo.getFullName()
        self.description = repo.getDescription()
        self.avatarURL = repo.getAvatarURL()
    }
}
