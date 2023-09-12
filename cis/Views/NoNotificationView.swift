//
//  NoNotificationView.swift
//  cis
//
//  Created by cici on 14/6/2023.
//

import UIKit

class NoNotificationView: UIView {

    private let label:UILabel = {
        let label = UILabel()
        label.text = "No Notifications Yet"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "bell")
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(label)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: (width-50)/2, y: 0, width: 50, height: 50).integral
        label.frame = CGRect(x: 0, y: 60, width: width, height:height-50).integral
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
