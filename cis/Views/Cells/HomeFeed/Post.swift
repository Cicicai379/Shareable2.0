//
//  Post.swift
//  cis
//
//  Created by cici on 11/6/2023.
//

import UIKit
import SDWebImage
import AVFoundation

final class Post: UITableViewCell {
    
    static let identifier  = "Post"
    private var player: AVPlayer?
    private var playerLayer =  AVPlayerLayer()

    private  let postImageView :UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = nil
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(postImageView)
        contentView.layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost){
        postImageView.image = UIImage(named: "test") // for testing
        return
        switch post.postType{
        case .photo:
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            //load video
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
}
