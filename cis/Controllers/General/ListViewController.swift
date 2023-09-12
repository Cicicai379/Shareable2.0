//
//  ListViewController.swift
//  share
//
//  Created by cici on 6/6/2023.
//

import UIKit

class ListViewController: UIViewController {
    
//    private let data:[String] // should probably be an array of users...
    
    private var data = [UserRelationship]()
    
    private let tableView:UITableView = {
        let tableView = UITableView(frame:.zero,
                                    style: .grouped)
        tableView.register(UserFollowTableViewCell.self, forCellReuseIdentifier: "UserFollowTableViewCell")
        return tableView
    }()
    
    
    init(data: [UserRelationship]){ // used when you want to pass in data from another view controller
        self.data = data
        super.init(nibName:  nil, bundle: nil)
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
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}


extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier, for: indexPath) as! UserFollowTableViewCell
        cell.configure(with: data[indexPath.row])
        cell.delegate = self
        return cell
    }
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:indexPath, animated:true)
        //go to profile of selected user
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}


extension ListViewController: UserFollowTableViewCellDelegate{
    func didTapFollowButton(model: UserRelationship) {
        switch model.type{
        case .following:
            //firebase update to unfollow
            break
        case .not_following:
            //firebase upadte
            break
        }
    }
    
}
