//
//  NotificationViewController.swift
//  share
//
//  Created by cici on 6/6/2023.
//

import UIKit

enum UsernotificationType{
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification{
    let type: UsernotificationType
    let text: String
    let user: User
}

final class NotificationViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
  
    private lazy var noNotificationView = NoNotificationView()
    private var models = [UserNotification]()
    private let tableView: UITableView = {
        let tableView = UITableView(frame:.zero,
                                    style: .grouped)
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)

        tableView.isHidden = false
        tableView.clipsToBounds = true
        return tableView
    }()
   
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
//        spinner.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width:100, height: 100)
        spinner.center = view.center
    }
    
    private func fetchNotifications(){
        let user = User(username: "username", bio: "bio", name: (first:"first", last: "last"), gender: .other, counts: UserCount(follower: 1, following: 1, posts: 1), profilePicture: URL(string: "https://www.google.com")!)
        let userPost = UserPost(postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likes: [], comments: [], createdDate: Date(), owner:user, tags: [])
        for x in 1...20{
            let model = UserNotification(type: x%2==0 ?.like(post: userPost) : .follow(state:x%4==1 ?.not_following:.following) , text: "Hello World", user: User(username: "username", bio: "bio", name: (first:"first", last: "last"), gender: .other, counts: UserCount(follower: 1, following: 1, posts: 1), profilePicture: URL(string: "https://www.google.com")!))
            models.append(model)
        }
    }
    private func addNoNotificationView(){
        tableView.isHidden = true
        view.addSubview(noNotificationView)
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/3)
        noNotificationView.center = view.center
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type{
        case .like(_):
            //like cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case  .follow:
            //follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self

            return cell
        }
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int{
        return models.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension NotificationViewController:  NotificationLikeEventTableViewCellDelegate{
    func didTapRelatedPostButton(model: UserNotification) {
        print("tapped post")
        //post postview
        
        switch model.type{
        case .like(let post):
            let vc = PostViewController(model:post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("should never get called")
        }
    }
}

extension NotificationViewController:  NotificationFollowEventTableViewCellDelegate{
    func didTapFollowButton(model: UserNotification) {
        print("tapped follow")
        //perform database update
        
    }
}
