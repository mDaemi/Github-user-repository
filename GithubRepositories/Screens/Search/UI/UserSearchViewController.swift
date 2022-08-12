//
//  UserSearchViewController.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 09/08/2022.
//

import UIKit

protocol UserCoordinatorScreen {
    func registerCoordinator(coordinator: UserCoordinator)
}

class UserSearchViewController: UIViewController, UserCoordinatorScreen {
    
    func registerCoordinator(coordinator: UserCoordinator) {
        self.coordinator = coordinator
    }

    // MARK: - PROPERTIES
    var viewModel = UserSearchViewModel<User>()
    var username: String?
    var coordinator: UserCoordinator?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 14, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    private var scrollView = UIScrollView()
    
    private var txtField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Enter username here ..."
        return txtField
    }()
    
    private var textFieldView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = cornerSize
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor(red: 0.3, green: 0.8, blue: 0, alpha: 1.0).cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    private let searchButton : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = cornerSize
        btn.backgroundColor = UIColor(red: 0.5, green: 0.8, blue: 0, alpha: 1.0)
        btn.setTitle("Search", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: font14)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private var parentView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = cornerSize
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor(red: 0.3, green: 0.8, blue: 0, alpha: 1.0).cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    private let avatarImage : UIImageView = {
        let imgView = UIImageView(image: UIImage(named:"image_not_found"))
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = profileImageSize * 0.5
        imgView.layer.masksToBounds = true
        imgView.layer.borderColor = UIColor.darkGray.cgColor
        imgView.layer.borderWidth = 1
        return imgView
    }()

    private var nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: font16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.clipsToBounds = true
        return lbl
    }()
    
    private let locationLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: font14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let locationIcon : UIImageView = {
        let imgView = UIImageView(image: UIImage(named:"location"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = cornerSize
        return imgView
    }()
    
    private let followLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: font14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let followIcon : UIImageView = {
        let imgView = UIImageView(image: UIImage(named:"Follow"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = cornerSize
        return imgView
    }()
    
    private let repositoryButton : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = cornerSize
        btn.backgroundColor = UIColor(red: 0.5, green: 0.8, blue: 0, alpha: 1.0)
        btn.setTitle("Repositories", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: font14)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(repositoryButtonTapped(sender:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - UI SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        textFieldView.addSubview(txtField)
        scrollView.addSubview(parentView)
        scrollView.addSubview(textFieldView)
        scrollView.addSubview(searchButton)
        parentView.addSubview(avatarImage)
        parentView.addSubview(nameLabel)
        parentView.addSubview(locationLabel)
        parentView.addSubview(locationIcon)
        parentView.addSubview(followLabel)
        parentView.addSubview(followIcon)
        parentView.addSubview(repositoryButton)

        scrollView.backgroundColor = .white
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        txtField.anchor(top: textFieldView.topAnchor, left: textFieldView.leftAnchor, bottom: textFieldView.topAnchor, right: textFieldView.rightAnchor, paddingTop: paddingSize*0.7, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: paddingSize, width: fullSize*0.75 - (paddingSize*2), height: 40, enableInsets: true)
        textFieldView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: parentView.topAnchor, right: searchButton.leftAnchor, paddingTop: paddingSize, paddingLeft: paddingSize, paddingBottom: paddingSize, paddingRight: paddingSize*0.5, width: fullSize*0.75, height: buttonHeight, enableInsets: true)
        searchButton.anchor(top: scrollView.topAnchor, left: textFieldView.rightAnchor, bottom: parentView.topAnchor, right: scrollView.rightAnchor, paddingTop: paddingSize, paddingLeft: paddingSize, paddingBottom: paddingSize, paddingRight: paddingSize, width: fullSize*0.2, height: buttonHeight, enableInsets: true)
        parentView.anchor(top: textFieldView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: paddingSize, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: paddingSize, width: fullSize, height: sizeWithRatio(200), enableInsets: true)
        avatarImage.anchor(top: parentView.topAnchor, left: parentView.leftAnchor, bottom: nil, right: nil, paddingTop:paddingSize, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: 0, width: profileImageSize, height: profileImageSize, enableInsets: true)
        nameLabel.anchor(top: avatarImage.topAnchor, left: avatarImage.rightAnchor, bottom: nil, right: nil, paddingTop:paddingSize, paddingLeft: marginSize, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        locationIcon.anchor(top: avatarImage.bottomAnchor, left: parentView.leftAnchor, bottom: nil, right: locationLabel.leftAnchor, paddingTop:marginSize, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: paddingSize*0.3, width: fullSize/16, height: fullSize/16, enableInsets: true)
        locationLabel.anchor(top: avatarImage.bottomAnchor, left: locationIcon.rightAnchor, bottom: nil, right: parentView.rightAnchor, paddingTop:marginSize, paddingLeft: 0, paddingBottom: 0, paddingRight: paddingSize, width: 0, height: 0, enableInsets: true)
        followIcon.anchor(top: locationIcon.bottomAnchor, left: parentView.leftAnchor, bottom: nil, right: followLabel.leftAnchor, paddingTop:marginSize, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: paddingSize*0.3, width: fullSize/16, height: fullSize/16, enableInsets: true)
        followLabel.anchor(top: locationIcon.bottomAnchor, left: followIcon.rightAnchor, bottom: nil, right: parentView.rightAnchor, paddingTop:marginSize, paddingLeft: 0, paddingBottom: 0, paddingRight: paddingSize, width: 0, height: 0, enableInsets: true)
        repositoryButton.anchor(top: followLabel.bottomAnchor, left: parentView.leftAnchor, bottom: nil, right: parentView.rightAnchor, paddingTop:marginSize, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: paddingSize, width: fullSize-(paddingSize*2) , height: buttonHeight, enableInsets: true)
        parentView.isHidden = true
    }

    func setupUI() {
        self.view.backgroundColor = .black
        viewModel.register(networkManager_: NetWorkManager<Repository, User>())
    }

    func bindViewModel() {
        viewModel.user.bind({ [weak self] (user) in
            DispatchQueue.main.async {
                self?.parentView.isHidden = false
                self?.nameLabel.text = user?.name
                self?.locationLabel.text = user?.location
                guard let str = user?.avatarURL, let url = URL(string: str) else {
                    print("The repository image was not found!")
                    return
                }
                self?.avatarImage.load(url: url)
                var text = ""
                if let follower = user?.follower {
                    text = String(follower) + " follower"
                }
                if let following = user?.following {
                    text = text + " - " + String(following) + " following"
                }
                self?.followLabel.text = text
            }
        })
    }
    
    // MARK: - Actions
    @objc func searchButtonTapped(sender: UIButton) {
        parentView.isHidden = true
        username = txtField.text
        if (username == "") {
            print("USERNAME NOT FOUND")
            return
        }
        viewModel.username = username
        viewModel.getData()
    }
    
    @objc func repositoryButtonTapped(sender: UIButton) {
        self.coordinator?.goToRepositories(withUsername: username!)
    }
}

