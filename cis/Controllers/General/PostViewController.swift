//
//  PostViewController.swift
//  share
//
//  Created by cici on 6/6/2023.
//

import UIKit

//states of a rendered cell
enum PostRenderType{
    case primaryContent(provider: UserPost) //post
    case header (provider: User)
    case action(provider: String) //buttons
    case comments (provider: [PostComment])
}
struct PostRenderViewModel{
    let renderType: PostRenderType
}
class PostViewController: UIViewController {
    
    private let model: UserPost?
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        //register cells
        
        tableView.register(Post.self, forCellReuseIdentifier: Post.identifier)
        tableView.register(PostHeader.self, forCellReuseIdentifier: PostHeader.identifier)
        tableView.register(PostAction.self, forCellReuseIdentifier: PostAction.identifier)
        tableView.register(PostGeneral.self, forCellReuseIdentifier: PostGeneral.identifier)

        return tableView
    }()
    
    init(model:UserPost?){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        setUpModels()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setUpModels(){
        guard let userPostModel = self.model else{
            return
        }
        //header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        //content
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider:userPostModel)))

        //action
        renderModels.append(PostRenderViewModel(renderType: .action(provider:"")))

        var comments = [PostComment]()
        for _  in 0 ..< 4{
            comments.append(PostComment(username: "username", postIdentifier: "1", likes: [], createdDate: Date(), text: "text"))
        }
        //comment
        renderModels.append(PostRenderViewModel(renderType: .comments(provider:comments)))
        print(comments.count)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}


extension PostViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch renderModels[section].renderType{
        case .action(_):return 1
        case .header(_):return 1
        case .primaryContent(_):return 1
        case .comments(let comments):
            return comments.count > 4 ?  4 :  comments.count
           
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let model = renderModels[indexPath.section]
        switch model.renderType{
        case .action(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: PostAction.identifier, for: indexPath) as! PostAction
            cell.delgate = self
            return cell
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: PostHeader.identifier, for: indexPath) as! PostHeader
            cell.delgate = self
            cell.configure(with: user)
            return cell
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: Post.identifier, for: indexPath) as! Post
            cell.configure(with: post)
            return cell
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: PostGeneral.identifier, for: indexPath) as! PostGeneral
            return cell
          
        }
    }
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:indexPath, animated:true)
        //handle cell selection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType{
        case .action(_):return 40
        case .header(_):return 50
        case .primaryContent(_):return tableView.width
        case .comments(_):
            return 40
        }
    }
}



extension PostViewController:PostHeaderDelegate{
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

extension PostViewController:PostActionDelegate{
    func didTapLikeButton() {
        //update database
    }
    func didTapCommentButton() {
        //update database
    }
}

