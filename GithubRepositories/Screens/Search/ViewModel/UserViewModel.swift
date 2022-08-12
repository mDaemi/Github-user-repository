//
//  UserViewModel.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 09/08/2022.
//

import Foundation

class UserViewModel {
     var name: String?
     var location: String?
     var bio: String?
     var publicRepos: Int?
     var follower: Int?
     var following: Int?
     var avatarURL: String?
    
    init(_ user:UserProtocol) {
        self.name = user.getName()
        self.location = user.getLocation()
        self.bio = user.getBio()
        self.publicRepos = user.getPublicReposCount()
        self.follower = user.getFollower()
        self.following = user.getFollowing()
        self.avatarURL = user.getAvatarURL()
    }
}
