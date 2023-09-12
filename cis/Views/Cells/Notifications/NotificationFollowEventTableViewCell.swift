//
//  NotificationFollowEventTableViewCell.swift
//  cis
//
//  Created by cici on 14/6/2023.
//

import UIKit


protocol NotificationFollowEventTableViewCellDelegate: AnyObject{
    func didTapFollowButton(model:UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationFollowEventTableViewCell"
    public weak var delegate:NotificationFollowEventTableViewCellDelegate?
    private var model: UserNotification?
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .tertiaryLabel
        return imageView
    }()
    private let label: UILabel = {
        let label =  UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "cis followed you"
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    @objc private func didTapFollowButton(){
        guard let model = model else{
            return
        }
        delegate?.didTapFollowButton(model: model)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 10, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let labelHeight = contentView.height/2
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/6
        
        label.frame = CGRect(x: profileImageView.right+8, y: 12, width: contentView.width-8-profileImageView.width-buttonWidth, height: labelHeight)
       
        followButton.frame = CGRect(x: contentView.width-10-buttonWidth, y: 10, width: buttonWidth, height: contentView.height-20)
        followButton.layer.cornerRadius = profileImageView.height/10
        
    }
    
    public func configure(with model: UserNotification){
        self.model = model
        
        switch model.type{
        case .like(_):
            break
        case .follow(let state):
            //configure button
            switch state{
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
                followButton.layer.borderColor = UIColor.label.cgColor
            }
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with:model.user.profilePicture, completed: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        label.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
