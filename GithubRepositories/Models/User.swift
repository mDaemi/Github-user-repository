//
//  User.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 09/08/2022.
//

import Foundation

fileprivate enum UserCodingKeys: String, CodingKey {
    
    case name
    case location
    case bio
    case publicRepos = "public_repos"
    case followers
    case following
    case avatarURL = "avatar_url"
}

public protocol UserProtocol: Codable {
    func getName() -> String
    func getLocation() -> String
    func getBio() -> String
    func getPublicReposCount() -> Int
    func getFollower() -> Int
    func getFollowing() -> Int
    func getAvatarURL() -> String?
    
    init(name: String,
         location: String,
         bio: String,
         publicRepos: Int,
         follower: Int,
         following: Int,
         avatarURL: String)
}

class User: UserProtocol {
    
    private var name: String?
    private var location: String?
    private var bio: String?
    private var publicRepos: Int?
    private var follower: Int?
    private var following: Int?
    private var avatarURL: String?

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.publicRepos = try container.decodeIfPresent(Int.self, forKey: .publicRepos)
        self.follower = try container.decodeIfPresent(Int.self, forKey: .followers)
        self.following = try container.decodeIfPresent(Int.self, forKey: .following)
        self.avatarURL = try container.decodeIfPresent(String.self, forKey: .avatarURL)
    }

    required init(name: String,
                  location: String,
                  bio: String,
                  publicRepos: Int,
                  follower: Int,
                  following: Int,
                  avatarURL: String) {

        self.name = name
        self.location = location
        self.bio = bio
        self.publicRepos = publicRepos
        self.follower = follower
        self.following = following
        self.avatarURL = avatarURL
    }
   
    func getName() -> String {
        return name ?? ""
    }
    
    func getLocation() -> String {
        return location ?? "-"
    }
    
    func getBio() -> String {
        return bio ?? "-"
    }
    
    func getPublicReposCount() -> Int {
        return publicRepos ?? -1
    }
    
    func getFollower() -> Int {
        return follower ?? -1
    }
    
    func getFollowing() -> Int {
        return following ?? -1
    }
    func getAvatarURL() -> String? {
        return avatarURL
    }
}


