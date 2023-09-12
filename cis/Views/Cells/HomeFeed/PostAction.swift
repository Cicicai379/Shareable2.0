//
//  PostAction.swift
//  cis
//
//  Created by cici on 11/6/2023.
//

import UIKit

protocol PostActionDelegate: AnyObject{
    func didTapLikeButton()
    func didTapCommentButton()

}

class PostAction: UITableViewCell {

    static let identifier  = "PostAction"
    
    public weak var delgate: PostHeaderDelegate?

    private let likeButton: UIButton = {
        let button =  UIButton()
        let config = UIImage.SymbolConfiguration(pointSize:20,weight:.regular) // change size of image
        let image = UIImage(systemName: "heart",withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    private let commentButton: UIButton = {
        let button =  UIButton()
        let config = UIImage.SymbolConfiguration(pointSize:20,weight:.regular) // change size of image
        let image = UIImage(systemName: "message",withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)

    }
    
    @objc func didTapLikeButton(){
        delgate?.didTapMoreButton()
    }
    @objc func didTapCommentButton(){
        delgate?.didTapMoreButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost){
        //configure cell
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 2
        likeButton.frame = CGRect(x: 10, y: 2, width: size, height: size)
        commentButton.frame = CGRect(x: size+20, y: 2, width: size, height: size)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
      
    }
}
