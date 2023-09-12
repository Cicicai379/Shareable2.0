//
//  PostHeader.swift
//  cis
//
//  Created by cici on 11/6/2023.
//

import UIKit

protocol PostHeaderDelegate: AnyObject{
    func didTapMoreButton()
}

class PostHeader: UITableViewCell {

    static let identifier  = "PostHeader"
    public weak var delgate: PostHeaderDelegate?
    
    private  let profilePhotoImageView :UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = nil
        return imageView
    }()
    private let usernameLabel: UILabel = {
        let label =  UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "username" // for testing
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    private let moreButton: UIButton = {
        let button =  UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    @objc func didTapMoreButton(){
        delgate?.didTapMoreButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: User){
        usernameLabel.text = model.username
        profilePhotoImageView.image = UIImage(systemName: "person.circle")
//        profilePhotoImageView.sd_setImage(with: model.profilePicture, completed: nil)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 8
        profilePhotoImageView.frame = CGRect(x: 5, y: 2, width: size, height: size)
        profilePhotoImageView.layer.cornerRadius = size/2
        moreButton.frame = CGRect(x:  contentView.width - size - 3, y: 2, width: size, height: size)
        usernameLabel.frame = CGRect(x: profilePhotoImageView.right + 8, y: 2, width: contentView.width-(size*2)-15, height: contentView.height-4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profilePhotoImageView.image = nil
        usernameLabel.text = nil
    }
}
