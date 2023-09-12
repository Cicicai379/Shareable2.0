//
//  UserFollowTableViewCell.swift
//  cis
//
//  Created by cici on 14/6/2023.
//

import UIKit


protocol UserFollowTableViewCellDelegate: AnyObject{
    func didTapFollowButton(model:UserRelationship)
}

enum FollowState{
    case following, not_following
}
struct UserRelationship{
    let username: String
    let name: String
    let type: FollowState
}
class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFollowTableViewCell"
    public weak var delegate:UserFollowTableViewCellDelegate?
    private var model:UserRelationship?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label =  UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "name"
        label.font = .systemFont(ofSize: 14, weight:.semibold)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label =  UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "username"
        label.font = .systemFont(ofSize: 13, weight:.regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    override init(style:UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubviews()
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    @objc func didTapFollowButton(){
        guard let model = model else {
            return
        }

        delegate?.didTapFollowButton(model: model)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 10, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let labelHeight = contentView.height/2
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/5
        
        nameLabel.frame = CGRect(x: profileImageView.right+8, y: 4, width: contentView.width-8-profileImageView.width-buttonWidth, height: labelHeight)
       
        usernameLabel.frame = CGRect(x: profileImageView.right+8, y: labelHeight-5, width: contentView.width-8-profileImageView.width-buttonWidth, height: labelHeight)
       
        followButton.frame = CGRect(x: contentView.width-10-buttonWidth, y: 15, width: buttonWidth, height: contentView.height-30)
        followButton.layer.cornerRadius = profileImageView.height/10
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
    
    public func configure(with model: UserRelationship){
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.type{
        case.following:
            //show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .secondarySystemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.secondaryLabel.cgColor

        case.not_following:
            //show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .systemBlue
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0

        }
    }
    private func addSubviews(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
