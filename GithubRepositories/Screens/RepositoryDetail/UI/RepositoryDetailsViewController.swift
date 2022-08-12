//
//  RepositoryDetailsViewController.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 08/08/2022.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    // MARK: - PROPERTIES
    private var viewModel : RepositoryViewModel
    private var scrollView = UIScrollView()
    
    private let repositoryImage : UIImageView = {
        let imgView = UIImageView(image: UIImage(named:"image_not_found"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = avatarSize * 0.5
        imgView.layer.masksToBounds = true
        return imgView
    }()

    private let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.boldSystemFont(ofSize: font18)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.clipsToBounds = true
        return lbl
    }()

    private let descriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: font14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

    // MARK: - INIT
    init(_ viewModel: RepositoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UI CREATION

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(repositoryImage)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(descriptionLabel)

        scrollView.backgroundColor = .white
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        repositoryImage.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop:paddingSize, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: 0, width: avatarSize, height: avatarSize, enableInsets: true)
        nameLabel.anchor(top: repositoryImage.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop:marginSize*2, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: paddingSize, width: 0, height: 0, enableInsets: true)
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop:marginSize, paddingLeft: paddingSize, paddingBottom: paddingSize, paddingRight: paddingSize, width: fullSize, height: 0, enableInsets: true)
        
    }
    // MARK: - UI SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
   }

    private func setupUI() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.navigationBar.tintColor = .black
        self.title = viewModel.name
        
        nameLabel.text = viewModel.fullName
        descriptionLabel.text = viewModel.description
        guard let str = viewModel.avatarURL, let url = URL(string: str) else {
            print("The repository image was not found!")
            return
        }
        repositoryImage.load(url: url)
    }
}


