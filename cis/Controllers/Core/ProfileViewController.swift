//
//  ProfileViewController.swift
//  share
//
//  Created by cici on 6/6/2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var userPosts = [UserPost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile"
        configureNavigationBar()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let size = (view.width-4)/3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        layout.itemSize = CGSize(width: size, height: size)

        collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        

        //CELL
        collectionView?.register(PhotoCollectionViewCell.self,forCellWithReuseIdentifier:PhotoCollectionViewCell.identifier)


        //HEADERS
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:ProfileInfoHeaderCollectionReusableView.identifier)
        collectionView?.register(ProfileTabCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:ProfileTabCollectionReusableView.identifier)

        collectionView?.delegate=self
        collectionView?.dataSource=self
        guard let collectionView = collectionView else{
            return
        }

        view.addSubview(collectionView)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func configureNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(systemName:"gear"),
                                                            style:.done,
                                                            target:self,
                                                            action:#selector(didTapSettingsButton))
    }
    @objc private func didTapSettingsButton(){
        let vc = SettingViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension ProfileViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
//        cell.configure(with:model)
        cell.configure(debug: "test")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int)->Int {
        if (section == 0){
            return 0
        }
        return 30
//        return userPosts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        let model = userPosts[indexPath.row]
        // get the model open and open post controller
        let user = User(username: "username", bio: "bio", name: (first:"first", last: "last"), gender: .other, counts: UserCount(follower: 1, following: 1, posts: 1), profilePicture: URL(string: "https://www.google.com")!)
        let userPost = UserPost(postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likes: [], comments: [], createdDate: Date(), owner:user, tags: [])
        
        let vc = PostViewController(model: userPost)
        vc.title = userPost.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1{
            let header1 = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabCollectionReusableView.identifier, for: indexPath) as! ProfileTabCollectionReusableView
            header1.delegate = self
            return header1
        }
        guard kind == UICollectionView.elementKindSectionHeader else{
            return UICollectionReusableView()
        }
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
       
        profileHeader.delegate = self
        return profileHeader
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/3 - 80)
        }
        return CGSize(width: collectionView.width, height: 50)
    }

}


extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate{
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        //scroll to post section
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<10{
            mockData.append(UserRelationship(username: "username", name: "name", type: x%2 == 0 ? .following : .not_following))
        }
        let vc = ListViewController(data: mockData)
        print("tapped")
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<10{
            mockData.append(UserRelationship(username: "username", name: "name", type: x%2 == 0 ? .following : .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}




extension ProfileViewController: ProfileTabCollectionReusableViewDelegate{
    func didTapGridButtonTab() {
        //reload collection view data
    }
    
    func didTapTagButtonTab() {
        //reload collection view data
    }
    
    
    
    
}

