//
//  PostGeneral.swift
//  cis
//
//  Created by cici on 11/6/2023.
//

import UIKit

class PostGeneral: UITableViewCell {


    //MARK: this is not started yet, the view cell should show: username + comment (two labels?) + profile pic(?)
    
    static let identifier  = "PostGeneral"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemOrange

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(){
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
