//
//  SettingViewController.swift
//  share
//
//  Created by cici on 6/6/2023.
//

import UIKit
import SafariServices


struct SettingCellModel{
    let title:String
    let handler:(()->Void)
}

// view controller to show user settings
class SettingViewController: UIViewController {
    
    private let tableView:UITableView = {
        let tableView = UITableView(frame:.zero,
                                    style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    private func configureModels(){
        data.append( [
            SettingCellModel(title: "Edit Profile"){[weak self] in
                self?.didTapEditProfile()
            },
            SettingCellModel(title: "Invite Friends"){[weak self] in
                self?.didTapInviteFriends()
            },
            SettingCellModel(title: "Save Original Posts"){[weak self] in
                self?.didSaveOriginalPosts()
            }
        ])
        data.append( [
            SettingCellModel(title: "Terms Of Service"){[weak self] in
                self?.openURL(type: .terms)
            },
            SettingCellModel(title: "Privacy Policy"){[weak self] in
                self?.openURL(type: .privacy)
            },
            SettingCellModel(title: "Help / Feedback"){[weak self] in
                self?.openURL(type: .help)
            }
        
        ])
      
        data.append( [
            SettingCellModel(title: "Log Out"){[weak self] in
                self?.didTapLogOut()
            }])
    }
    
    enum SettingURLType{
        case terms, privacy, help
    }
    private func openURL(type: SettingURLType){
        let urlString: String
        switch type {
        case .terms: urlString = "https://google.com"
            
        case .privacy:urlString = "https://google.com"
            
        case .help:urlString = "https://google.com"
            
        }
        guard let url = URL(string: urlString)else{
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)

        return

    }
    
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true)
        return
    }
    private func didTapInviteFriends(){
        return
    }
    private func didSaveOriginalPosts(){
        return
    }
  
    
    private func didTapLogOut(){
        let actionSheet = UIAlertController(title:"Log Out",
                                            message:"Are you sure you want to log out?",
                                            preferredStyle:.actionSheet)
        actionSheet.addAction(UIAlertAction(title:"Cancel", style:.cancel,handler:nil))
        actionSheet.addAction(UIAlertAction(title:"Log Out", style:.destructive,handler:{_ in
            
            AuthManager.shared.logOut(completion:{success in
                DispatchQueue.main.async{
                    if success{
                        //present log in
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }else{
                        //eorr
                        fatalError("Could not log out")
                    }
                }
                
            })
            
        }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds

        present(actionSheet, animated:true)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        title = "Setting"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

   

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:indexPath, animated:true)
        //handle cell selection
        data[indexPath.section][indexPath.row].handler()
    }
}
