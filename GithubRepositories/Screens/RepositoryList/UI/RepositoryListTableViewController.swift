//
//  RepositoryListTableViewController.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 03/08/2022.
//

import UIKit

protocol ListCoordinatorScreen {
    func registerCoordinator(coordinator: ListCoordinator)
}

class RepositoryListTableViewController: UITableViewController, ListCoordinatorScreen {
    
    func registerCoordinator(coordinator: ListCoordinator) {
        self.coordinator = coordinator
    }

    // MARK: - PROPERTIES
    var viewModel = RepositoryListTableViewViewModel<Repository>()
    var username: String = ""
    var coordinator: ListCoordinator?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 14, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    // MARK: - INIT
    init(_ username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.getData(username)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
    }

    func setupUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        tableView.accessibilityIdentifier = "tableView"
        viewModel.register(networkManager_: NetWorkManager<Repository, User>())
        
        // table View setup
        self.tableView.register(RepositoryTableViewCell.self,forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 70
        self.tableView.separatorStyle = .singleLine
    }

    func bindViewModel() {
        viewModel.repositories.bind({ [weak self] (repositories) in
            DispatchQueue.main.async {
                self?.tableView.setContentOffset(.zero, animated: false)
                self?.tableView.reloadData()
            }
        })
    }

    // MARK: - TableView delegation

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.reuseIdentifier, for: indexPath)

        if let repositoryCell = cell as? RepositoryTableViewCell {
            if let repositoryViewModel = viewModel.getRepositoryViewModel(atIndexPath: indexPath) {
                repositoryCell.viewModel = repositoryViewModel
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let repositoryViewModel = viewModel.getRepositoryViewModel(atIndexPath: indexPath) {
            self.coordinator?.goToDetail(withModel: repositoryViewModel)
        }
    }
}


