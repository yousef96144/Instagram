//
//  EditProfileViewController.swift
//  instagram
//
//  Created by yousef Elaidy on 09/12/2023.
//

import UIKit

struct EditProfileModel{
    var label: String
    var placeholder: String
    var value: String?
}

class EditProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    private var models = [[EditProfileModel]]()
    
    // MARK: -TableView
    
    private let tableview:UITableView = {
       let tableview = UITableView()
        tableview.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
      
        return tableview
    }()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    //override func with same name , smae paramater from super class
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
    //    cell.textLabel?.text = models[indexPath.section][indexPath.row].label
        cell.configure(with: models[indexPath.section][indexPath.row])
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "private information"
    
    }
    
   private func createTableHeaderView()->UIView{
       let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
       let size = header.height/1.5
       let profilephotobutton = UIButton(frame: CGRect(x: (view.width-size)/2,
                                                       y:
                                                        (header.height-size)/2,
                                                       width: size,
                                                       height: size))
       header.addSubview(profilephotobutton)
       profilephotobutton.layer.masksToBounds = true
       profilephotobutton.layer.cornerRadius = size/2.0
       profilephotobutton.addTarget(self, action: #selector(didtapprofilephotobutton), for: .touchUpInside)
       profilephotobutton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
       profilephotobutton.tintColor = .label
       profilephotobutton.layer.borderWidth = 1
       profilephotobutton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
       return header
    }
    
    @objc private func didtapprofilephotobutton(){
        
    }
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        
        configuremodel()
        view.backgroundColor = .systemBackground
        tableview.tableHeaderView = createTableHeaderView()
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self

        }
    
    override func viewDidLayoutSubviews() {
        tableview.frame = view.bounds
    }
    
    private func configuremodel(){
        
        let section1labels = ["Name","UserName","Bio"]
        var section1 = [EditProfileModel]()
        for label in section1labels{
            let model = EditProfileModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        
        let section2labels = ["Email","Phone","Gender"]
        var section2 = [EditProfileModel]()
        for label in section2labels{
            let model = EditProfileModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
   
   @objc   private func didTapSave(){
        

    }
  @objc  private func didTapCancel(){
      
      dismiss(animated: true)
      
    }
    @objc  private func DidTapChangeProfilePicture(){
        let actionsheet = UIAlertController(title: "Profile Picture", message: "change profile picture", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "take photo", style: .default,handler: { _ in
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Choose From Library", style: .default,handler: { _ in
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .default,handler: nil))

        actionsheet.popoverPresentationController?.sourceView = view
        actionsheet.popoverPresentationController?.sourceRect = view.bounds
    present(actionsheet, animated: true)

      }
   
    
}

extension EditProfileViewController: formtableviewcelldelegate{
    func formtableviewcell(_ cell: FormTableViewCell, didupdatefield: EditProfileModel ) {
       
    }
    
    
}
