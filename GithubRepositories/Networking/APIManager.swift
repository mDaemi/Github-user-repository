//
//  APIManager.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 04/08/2022.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidStatusCode
    case invalidResponse
    case noData
    case serialization
}

protocol NetWorkManagerProtocol {
    func getUserData(_ username: String, completion: @escaping UserCompletionBlock)
    func getRepositoriesData(_ username: String, completion: @escaping RepositoryCompletionBlock)
}

typealias UserCompletionBlock = (UserProtocol?, NetworkError?) -> ()
typealias RepositoryCompletionBlock = ([RepositoryProtocol], NetworkError?) -> ()

class NetWorkManager<I:RepositoryProtocol, U:UserProtocol>: NetWorkManagerProtocol {
    
    var session: URLSession
    var sessionCfg: URLSessionConfiguration
    private var _currentTask: URLSessionDataTask?

    private let BASE_URL =
        "https://api.github.com/users/"
    
    init() {
        sessionCfg = URLSessionConfiguration.default
        sessionCfg.timeoutIntervalForRequest = 10.0
        session = URLSession(configuration: sessionCfg)
    }

    internal  func get<T>(_ type: T.Type, route: String, callback: ((Result<T, Error>) -> Void)?) where T: Decodable {
        if let task = _currentTask { task.cancel() }
        if let url = URL(string: route) {
            _currentTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let e = error {
                    callback?(Result.failure(e))
                }else {
                    if let r = response as? HTTPURLResponse {
                        if  r.statusCode == 200{
                            if let data = data {
                                do {
                                    let decoder = JSONDecoder()
                                    let model = try decoder.decode(type, from: data)
                                    callback?(Result.success(model))
                                } catch {
                                    print(error)
                                    callback?(Result.failure(NetworkError.serialization))
                                }
                            } else {
                                callback?(Result.failure(NetworkError.noData))
                            }
                        }else {
                            callback?(Result.failure(NetworkError.invalidStatusCode))
                        }
                    }else {
                        callback?(Result.failure(NetworkError.invalidResponse))
                    }
                }
            })

            _currentTask?.resume()

        }else {
            callback?(Result.failure(NetworkError.badUrl))
        }
    }
    
    /*
     ** GET REPOSITORIES DATA
     */

    public func getRepositories(_ username: String, callback: ((Result<[I], Error>) -> Void)?) {
        self.get([I].self, route: BASE_URL+username+"/repos", callback: callback )
    }

    public func getRepositoriesData(_ username: String, completion: @escaping RepositoryCompletionBlock){
        var repositories = [RepositoryProtocol]()
        var netWorkError: NetworkError? = nil
        
        self.getRepositories(username) { (RepositoriesResult) in
            switch RepositoriesResult {
            case .success(let response):
                repositories = response
            case .failure(let error):
                netWorkError = error as? NetworkError
                print("fetch repositories fail from intenet")
            }
            completion(repositories, netWorkError)
        }
    }
    
    /*
     ** GET USER DATA
     */
    
    public func getUser(_ username: String, callback: ((Result<U, Error>) -> Void)?) {
        self.get(U.self, route: BASE_URL+username, callback: callback )
    }
    
    public func getUserData(_ username: String ,completion: @escaping UserCompletionBlock){
        var user: UserProtocol?
        var netWorkError: NetworkError? = nil
        
        self.getUser(username) { (UserResult) in
            switch UserResult {
            case .success(let response):
                user = response
            case .failure(let error):
                netWorkError = error as? NetworkError
                print("fetch user fail from intenet")
            }
            completion(user, netWorkError)
        }
    }
}
