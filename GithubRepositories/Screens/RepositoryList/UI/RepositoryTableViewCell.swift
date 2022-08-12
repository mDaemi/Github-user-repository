//
//  RepositoryTableViewCell.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 03/08/2022.
//

import UIKit

class RepositoryTableViewCell : UITableViewCell, ReuseIdentifierProtocol {
    // MARK: - PROPERTIES
    var task: URLSessionDataTask?
    var viewModel : RepositoryViewModel? {
        didSet {
            nameLabel.text = viewModel?.name
            fullNameLabel.text = viewModel?.fullName
            languageLabel.text = viewModel?.language
            watchersCountLabel.text = "-"
            if let num = viewModel?.watchersCount {
                watchersCountLabel.text = (num == -1 ? "-" : String(num))
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
        task?.cancel()
        nameLabel.text = nil
        fullNameLabel.text = nil
        languageLabel.text = nil
        watchersCountLabel.text = nil
        self.backgroundColor = .white
    }

    private let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: font14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private let fullNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: font14)
        lbl.textAlignment = .right
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private let languageLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: font12)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let redDot : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = dotSize * 0.5
        view.layer.masksToBounds = true
        return view
    }()

    private let watchersCountLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: font12)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

    private let watchersCountIcon : UIImageView = {
        let imgView = UIImageView(image: UIImage(named:"eye_icon"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = cornerSize
        return imgView
    }()

    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.layer.cornerRadius = cornerSize
        self.backgroundColor = .white
        addSubview(nameLabel)
        addSubview(fullNameLabel)
        addSubview(languageLabel)
        addSubview(watchersCountLabel)
        addSubview(watchersCountIcon)
        addSubview(redDot)

        nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: watchersCountIcon.topAnchor, right: fullNameLabel.leftAnchor, paddingTop:paddingSize, paddingLeft: paddingSize, paddingBottom: paddingSize*1.5, paddingRight: marginSize, width: fullSize*0.5, height: 0, enableInsets: true)
        watchersCountIcon.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: paddingSize, paddingLeft:paddingSize, paddingBottom: paddingSize, paddingRight: 0, width: fullSize/13, height: fullSize/28, enableInsets: true)
        watchersCountLabel.anchor(top: nil, left: watchersCountIcon.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft:5, paddingBottom: paddingSize, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        fullNameLabel.anchor(top: topAnchor, left: nameLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: paddingSize, paddingLeft: paddingSize, paddingBottom: 0, paddingRight: paddingSize, width: 0, height: 0, enableInsets: true)
        languageLabel.anchor(top: nil, left: redDot.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: paddingSize, paddingLeft: marginSize, paddingBottom: paddingSize, paddingRight: paddingSize, width: screenWidth/5 , height: 0, enableInsets: true)
        redDot.anchor(top: nil, left: nil, bottom: bottomAnchor, right: languageLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: paddingSize*1.2, paddingRight: marginSize*0.5, width: dotSize , height: dotSize, enableInsets: true)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

