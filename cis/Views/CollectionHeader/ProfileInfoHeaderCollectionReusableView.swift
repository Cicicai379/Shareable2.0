//
//  ProfileInfoHeaderCollectionReusableView.swift
//  cis
//
//  Created by cici on 12/6/2023.
//

import UIKit


protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject{
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)

}
final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier  = "ProfileInfoHeaderCollectionReusableView"
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button =  UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let followingButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Followers", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let followersButton: UIButton = {
        let button =  UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    private let nameLabel: UILabel = {
        let label =  UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "cis"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label =  UILabel()
        label.text = "Hello world"
        label.textColor = .label
        label.numberOfLines = 0 //line wrap
        return label
    }()
    
    // MARK: - INIT
    
    override init(frame:CGRect){
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubviews()
        addButtonActions()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        let buttonHeight = profilePhotoSize/2
        let buttonWidth = (width - 30 - profilePhotoSize)/3

        profilePhotoImageView.frame = CGRect(x: 15, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2
        postsButton.frame = CGRect(x: profilePhotoImageView.right, y: 25, width: buttonWidth, height: buttonHeight).integral
        followersButton.frame = CGRect(x: postsButton.right, y: 25, width: buttonWidth, height: buttonHeight).integral
        followingButton.frame = CGRect(x: followersButton.right, y: 25, width: buttonWidth, height: buttonHeight).integral
       
       
        nameLabel.frame = CGRect(x:15, y: 10+profilePhotoSize, width: width-10, height: 40).integral
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x:15, y: 50+profilePhotoSize, width: width-10, height: bioLabelSize.height).integral
    }
    
    private func addSubviews(){
        addSubview(profilePhotoImageView)
        addSubview(followersButton)
        addSubview(postsButton)
        addSubview(followingButton)
        addSubview(bioLabel)
        addSubview(nameLabel)

    }
    private func addButtonActions(){
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
    }
    
    @objc private func didTapFollowersButton(){
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    @objc private func didTapFollowingButton(){
        delegate?.profileHeaderDidTapFollowingButton(self)

    }
    @objc private func didTapPostsButton(){
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
