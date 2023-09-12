//
//  NotificationLikeEventTableViewCell.swift
//  cis
//
//  Created by cici on 14/6/2023.
//

import UIKit
import SDWebImage
protocol NotificationLikeEventTableViewCellDelegate: AnyObject{
    func didTapRelatedPostButton(model:UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"
    public weak var delegate:NotificationLikeEventTableViewCellDelegate?

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
        label.text = "Cis liked your photo"
        return label
    }()
    
    private let postButton: UIButton = {
        let button =  UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(UIImage(named: "test"), for:.normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(profileImageView)
        contentView.addSubview(postButton)
        selectionStyle = .none

        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
    }
    
    @objc private func didTapPostButton(){
        guard let model = model else{
            return
        }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 10, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        let labelHeight = contentView.height/2
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/6
        let size = contentView.height - 4

        label.frame = CGRect(x: profileImageView.right+8, y: 12, width: contentView.width-8-profileImageView.width-buttonWidth, height: labelHeight)
        postButton.frame = CGRect(x: contentView.width-size-10, y: 2, width: size, height: size)
       
    }
    
    public func configure(with model: UserNotification){
        self.model = model
        
        switch model.type{
        case .like(let post):
            
            let thumbnail = post.thumbnailImage
           
            //for debug purpose
            guard !thumbnail.absoluteString.contains("google") else{
                return
            }
            postButton.sd_setImage(with: thumbnail, for: .normal, completed: nil)
        case .follow:
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with:model.user.profilePicture, completed: nil)
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        profileImageView.image = nil
//        label.text = nil
//        postButton.setTitle(nil, for: .normal)
//        postButton.backgroundColor = nil
//        postButton.layer.borderWidth = 0
//        postButton.setBackgroundImage(nil, for: .normal)
//
//    }
//
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
