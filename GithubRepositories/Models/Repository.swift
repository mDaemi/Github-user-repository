//
//  Repository.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 05/08/2022.
//

import Foundation

fileprivate enum RepositoryCodingKeys: String, CodingKey {
    case id
    case name
    case fullName = "full_name"
    case owner
    case description
    case watchersCount = "watchers_count"
    case language
}

public protocol RepositoryProtocol: Codable {
    func getId() -> Int
    func getName() -> String
    func getFullName() -> String
    func getWatchersCount() -> Int
    func getLanguage() -> String
    func getDescription() -> String
    func getAvatarURL() -> String?
    
    init(id: Int,
         name: String,
         fullName: String,
         watchersCount: Int,
         language: String,
         description: String,
         avatarURL: String)
}

class Repository: RepositoryProtocol {
    
    private var id: Int?
    private var name: String?
    private var fullName: String?
    private var watchersCount: Int?
    private var language: String?
    private var description: String?
    private var owner: Owner?
    private var avatarURL: String?

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepositoryCodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
        self.watchersCount = try container.decodeIfPresent(Int.self, forKey: .watchersCount)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.owner = try container.decodeIfPresent(Owner.self, forKey: .owner)
        if let url = self.owner?.avatar_url {
            self.avatarURL = url
        }
    }

    required init(id: Int,
                  name: String,
                  fullName: String,
                  watchersCount: Int,
                  language: String,
                  description: String,
                  avatarURL: String) {

        self.id = id
        self.name = name
        self.fullName = fullName
        self.watchersCount = watchersCount
        self.language = language
        self.description = description
        self.avatarURL = avatarURL
    }
    
    func getId() -> Int {
        return id ?? -1
    }
    
    func getName() -> String {
        return name ?? ""
    }
    
    func getFullName() -> String {
        return fullName ?? ""
    }
    
    func getWatchersCount() -> Int {
        return watchersCount ?? -1
    }
    
    func getLanguage() -> String {
        return language ?? "-"
    }
    
    func getDescription() -> String {
        return description ?? ""
    }
    
    func getAvatarURL() -> String? {
        return avatarURL
    }
}

struct Owner: Decodable, Encodable {
    var avatar_url: String?
}
