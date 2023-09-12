//
//  ProfileTabCollectionReusableView.swift
//  cis
//
//  Created by cici on 12/6/2023.
//

import UIKit

protocol ProfileTabCollectionReusableViewDelegate: AnyObject{
    func didTapGridButtonTab()
    func didTapTagButtonTab()
}
class ProfileTabCollectionReusableView: UICollectionReusableView {
    static let identifier  = "ProfileTabCollectionReusableView"
   
    struct Constants{
        static let padding:CGFloat = 10
    }
    public weak var delegate:ProfileTabCollectionReusableViewDelegate?
   
    //button for not sold items
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName:"square.grid.2x2"), for: .normal)
        return button
    }()
    
    //already shared items
    private let tagButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName:"tag"), for: .normal)
        return button
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
//        backgroundColor = .secondarySystemBackground
        clipsToBounds = true
        addSubviews()
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        tagButton.addTarget(self, action: #selector(didTapTagButton), for: .touchUpInside)

    }
    @objc private func didTapGridButton(){
        gridButton.tintColor = .systemBlue
        tagButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    @objc private func didTapTagButton(){
        gridButton.tintColor = .lightGray
        tagButton.tintColor = .systemBlue
        delegate?.didTapTagButtonTab()

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (Constants.padding*2)
        let halfWidth = ((width/2)-size)/2
        gridButton.frame = CGRect(x: halfWidth, y: Constants.padding, width: size, height: size-3)
        tagButton.frame = CGRect(x: halfWidth +  (width/2), y: Constants.padding, width: size, height: size-3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    private func addSubviews (){
        addSubview(gridButton)
        addSubview(tagButton)
    }

}
