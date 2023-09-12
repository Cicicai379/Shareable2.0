//
//  PhotoCollectionViewCell.swift
//  cis
//
//  Created by cici on 12/6/2023.
//
import SDWebImage
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    static let identifier  = "PhotoCollectionViewCell"
   
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground
        accessibilityHint = "User post image" // for read out the visuals
        accessibilityLabel = "Double-tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost){
        let url = model.thumbnailImage
//        let task = URLSession.shared.dataTask(with: url, completionHandler{data, _,_ in
//            photoImageView.image = UIImage(data:data!)
//        })
        photoImageView.sd_setImage(with: url, completed: nil)
    }
    
    public func configure(debug imageName: String){
        photoImageView.image = UIImage(named:imageName)
    }

}
