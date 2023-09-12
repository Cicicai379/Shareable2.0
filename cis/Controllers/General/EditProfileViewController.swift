//
//  EditProfileViewController.swift
//  share
//
//  Created by cici on 6/6/2023.
//

import UIKit

struct EditProfileFormModel{
    let label: String
    let placeholder: String
    var value: String?
}

final class EditProfileViewController: UIViewController,UITableViewDataSource {
    
    private var models = [[EditProfileFormModel]]()
    
    private func configureModels () {
        //name, username, website, bio
        let sectionLabels = ["Name", "Username", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in sectionLabels{
            let model =  EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        //email, phone, gender
        let section2Labels = ["Email", "Phone", "Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels{
            let model =  EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    private let tableView:UITableView = {
        let tableView = UITableView(frame:.zero,
                                    style: .grouped)
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.tableHeaderView = createTableHeaderView()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem (title:"Save",
                                          style:.done,
                                          target:self,
                                          action:#selector(didTapSave)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem (title:"Cancel",
                                          style:.plain,
                                          target:self,
                                          action:#selector(didTapCancel)
        )
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: TABLE VIEW
    
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = header.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - size)/2, y: (header.height - size)/2, width: size, height: size))
        
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName:"person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profilePhotoButton.tintColor = .label
    
        
        return header
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
//        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else{
            return nil
        }
        return "Private Information"
    }
    
    
    
    //MARK: ACTION
    
    @objc private func didTapProfilePhotoButton(){
        
    }
    @objc private func didTapSave(){
        //todo: save to database
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
        
    }
    @objc private func didTapChangeProfilePicture(){
        let actionSheet = UIAlertController(title:"Profile Picture",
                                            message:"Chaneg Profile Picture",
                                            preferredStyle:.actionSheet)
        actionSheet.addAction(UIAlertAction(title:"Take Photo", style:.default,handler:{_ in}))
        actionSheet.addAction(UIAlertAction(title:"Choose From library", style:.default,handler:{_ in}))
        actionSheet.addAction(UIAlertAction(title:"Cancel", style:.cancel,handler:nil))
            

        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds

        present(actionSheet, animated:true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EditProfileViewController: FormTableViewCellDelegate{
    
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileFormModel) {
        //update model
        print (updateModel.value ?? "nil")
    }
    
}
