//
//  ExplorerViewController.swift
//  share
//
//  Created by cici on 5/6/2023.
//

import UIKit

class ExplorerViewController: UIViewController {
    
    private var models = [UserPost]()
    
    private var tabbedSearchCollectionView: UICollectionView?
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        return view
    }()
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundColor = .secondarySystemBackground
        bar.placeholder = "Search"
        return bar
    }()
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        title = "Explore"
        
        configureExploreCollection()
        configureSearchBar()
        configureTabbedSearch()

    }
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
        dimmedView.frame = view.bounds
        tabbedSearchCollectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 52)

    }
    @objc func didTapDimmedView(){
        didCancelSearch()
    }
   
    private func configureTabbedSearch(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (view.width-4)/3, height: 52)
        tabbedSearchCollectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        tabbedSearchCollectionView?.delegate=self
        tabbedSearchCollectionView?.dataSource=self
        tabbedSearchCollectionView?.isHidden = true
        tabbedSearchCollectionView?.backgroundColor = .yellow
       
//        collectionView?.register(UITraitCollection.self, forCellWithReuseIdentifier: "cell")
        // the cell model is not created yet, the cells should be configured by getting different tags from database

        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else {
            return
        }
        view.addSubview(tabbedSearchCollectionView)
    }
    private func configureSearchBar(){
        navigationItem.titleView = searchBar
        view.addSubview(dimmedView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDimmedView))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        dimmedView.addGestureRecognizer(gesture)
    }
    private func configureExploreCollection(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width-4)/3, height: (view.width-4)/3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView?.delegate=self
        collectionView?.dataSource=self
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        searchBar.delegate = self
        guard collectionView != nil else{
            return
        }
        
        if let collectionView = collectionView {
            view.addSubview(collectionView)
        }
    }

}

extension ExplorerViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabbedSearchCollectionView {
            return UICollectionViewCell()
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.configure(debug:"test")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int)->Int {
        if collectionView == tabbedSearchCollectionView {
            return 0
        }
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if collectionView == tabbedSearchCollectionView {
            //change search content
            return
        }
        
        // let model = userPosts[indexPath.row]
        // get the model open and open post controller
        let user = User(username: "username", bio: "bio", name: (first:"first", last: "last"), gender: .other, counts: UserCount(follower: 1, following: 1, posts: 1), profilePicture: URL(string: "https://www.google.com")!)
        let userPost = UserPost(postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likes: [], comments: [], createdDate: Date(), owner:user, tags: [])
        
        let vc = PostViewController(model: userPost)
        vc.title = userPost.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ExplorerViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didCancelSearch()
        guard let text = searchBar.text, !text.isEmpty else{
            return
        }
        query(text)
    }
    func query(_ text: String){
        //perform search in backend
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSearch))
        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0.4
        }){done in
            if done{
                self.tabbedSearchCollectionView?.isHidden = false
            }
        }
    }
    @objc func didCancelSearch(){
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        self.tabbedSearchCollectionView?.isHidden = true
        UIView.animate(withDuration: 0.2, animations:{
            self.dimmedView.alpha = 0
        }) { done in
            if done {
                self.dimmedView.isHidden = true

            }

        }
    }
}
