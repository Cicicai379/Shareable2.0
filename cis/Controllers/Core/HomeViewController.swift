//
//  HomeViewController.swift
//  share
//
//  Created by cici on 5/6/2023.
//

import FirebaseAuth
import UIKit

struct HomeFeedRenderViewModel{
    let header:PostRenderViewModel
    let action:PostRenderViewModel
    let post:PostRenderViewModel
    let comments:PostRenderViewModel
}
class HomeViewController: UIViewController {
    
    public var renderModels = [HomeFeedRenderViewModel]()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(Post.self, forCellReuseIdentifier: Post.identifier)
        tableView.register(PostHeader.self, forCellReuseIdentifier: PostHeader.identifier)
        tableView.register(PostAction.self, forCellReuseIdentifier: PostAction.identifier)
        tableView.register(PostGeneral.self, forCellReuseIdentifier: PostGeneral.identifier)
        tableView.clipsToBounds = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemRed
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        createMockModels()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func createMockModels(){
        let user = User(username: "username", bio: "bio", name: (first:"first", last: "last"), gender: .other, counts: UserCount(follower: 1, following: 1, posts: 1), profilePicture: URL(string: "https://www.google.com")!)
        let userPost = UserPost(postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likes: [], comments: [], createdDate: Date(), owner:user, tags: [])
        var comments = [PostComment]()
        for _  in 0 ..< 4{
            comments.append(PostComment(username: "username", postIdentifier: "1", likes: [], createdDate: Date(), text: "text"))
        }

        for _ in 0..<5{
            
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    action:  PostRenderViewModel(renderType: .action(provider: "")),
                                                    post:  PostRenderViewModel(renderType: .primaryContent(provider: userPost)),
                                                    comments: PostRenderViewModel(renderType: .comments(provider: comments)))
            renderModels.append(viewModel)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAutheticated()
    }
    private func handleNotAutheticated(){
        // check auth status
        if Auth.auth().currentUser == nil {
            //show log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }

}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let x = section
        let  model: HomeFeedRenderViewModel
        let position = x % 4 == 0 ? x/4 : (x-(x%4))/4
        let subSection = x%4
       
        if section ==  0 {
             model = renderModels[0]
        }else{
            model = renderModels[position]
        }
        
        if subSection == 1{
            //post
            return 1
        } else if subSection == 2{
            //action
            return 1
        } else if subSection == 3{
            //comment
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):  return comments.count > 2 ?  2 :  comments.count
            case .action, .header, .primaryContent: return 0
            }
        } else if subSection == 0{
            //header
            return 1
        }
        return 0
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let x = indexPath.section
        let position = x % 4 == 0 ? x/4 : (x-(x%4))/4
        let subSection = x%4
        let  model: HomeFeedRenderViewModel
        if indexPath.section ==  0 {
             model = renderModels[0]
        }else{
            model = renderModels[position]
        }
       
       
        if subSection == 1{
            //post
            let postModel = model.post
            switch postModel.renderType {
                case .primaryContent(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: Post.identifier, for: indexPath) as! Post
                    cell.configure(with:post)
                    return cell
                case .action, .header, .comments: return UITableViewCell()
            }
        } else if subSection == 2{
            //action
            let actionModel = model.action
            switch actionModel.renderType {
                case .action(let action):
                    let cell = tableView.dequeueReusableCell(withIdentifier: PostAction.identifier, for: indexPath) as! PostAction
                    cell.delgate = self
                    return cell
                case .primaryContent, .header, .comments: return UITableViewCell()

            }
        } else if subSection == 3{
            //comment
            let commentsModel = model.comments
            switch commentsModel.renderType {
                case .comments(let comments):
                    let cell = tableView.dequeueReusableCell(withIdentifier: PostGeneral.identifier, for: indexPath) as! PostGeneral
                    return cell
                case .primaryContent, .header, .action: return UITableViewCell()

            }

        } else if subSection == 0{
            //header
            let headerModel = model.header
            switch headerModel.renderType {
                case .header(let user):
                    let cell = tableView.dequeueReusableCell(withIdentifier: PostHeader.identifier, for: indexPath) as! PostHeader
                cell.configure(with: user)
                cell.delgate = self
                return cell
            case .primaryContent, .action, .comments: return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:indexPath, animated:true)
        //handle cell selection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section%4
        if subSection == 0 {
            return 50
        } else if subSection == 1 {
            return tableView.width
        } else if subSection == 2 {
            return 40
        } else if subSection == 3 {
            return 40
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section%4
        if subSection == 3 {
            return 70
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
        return UIView()
    }
}

extension HomeViewController:PostHeaderDelegate{
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler:{ [weak self]_ in
            self?.reportPost()
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(actionSheet, animated: true, completion: nil)
    }
    
    func reportPost(){
        print("did tap report post")
    }
}

extension HomeViewController:PostActionDelegate{
    func didTapLikeButton() {
        //update database
    }
    func didTapCommentButton() {
        //update database
    }
}

