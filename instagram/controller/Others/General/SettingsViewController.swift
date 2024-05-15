//
//  SettingsViewController.swift
//  instagram
//
//  Created by yousef Elaidy on 09/12/2023.
//

import UIKit
import SafariServices
struct SettingCellModel{
    let title: String
    let handler:(() -> Void)
}

final class SettingsViewController: UIViewController {
    
    private var tableview: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableview
    }()

    private var data = [[SettingCellModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureModels()
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    private func configureModels(){
        self.data.append([
            SettingCellModel(title: "Edit Profile") {[weak self] in
                self?.DidTabEditProfile()
            },
            SettingCellModel(title: "Invite Friends") {[weak self] in
                self?.DidTabInviteFriends()

            },
            SettingCellModel(title: "Save Original Post") {[weak self] in
                self?.DidTabSaveOriginPost()

            }
        ])
        self.data.append([
            SettingCellModel(title: "Terms Of Service") {[weak self] in
                self?.openurl(type: .terms )

            },
            SettingCellModel(title: "Privacy Policy") {[weak self] in
                self?.openurl(type: .privacy)

            },
            SettingCellModel(title: "Help / Feedback") {[weak self] in
                self?.openurl(type: .help )

            }


        ])
        
        self.data.append([
            SettingCellModel(title: "log out") {[weak self] in self?.tablogout()},
                         ])
        
       
       
       // tableview.reloadData()
    }
    
    enum settingurltype{
        case terms,privacy,help
    }
    
    private func openurl(type: settingurltype){
        let urlstring: String
        switch type{
        case .terms: urlstring = "https://help.instagram.com/581066165581870"
        case .privacy: urlstring = "https://help.instagram.com/contact/1676704782672605"
        case .help: urlstring = "https://help.instagram.com/"
        }
        guard let url = URL(string: urlstring) else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    private func DidTabEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navc = UINavigationController(rootViewController: vc)
        navc.modalPresentationStyle = .fullScreen
        present(navc, animated: true)
    }
    private func DidTabInviteFriends(){
        
    }
    private func DidTabSaveOriginPost(){
        
    }
  
    
    private func tablogout(){
        let actionsheet = UIAlertController(title: "Log Out", message: "Are You Sure You Want To Log Out",preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
        actionsheet.addAction(UIAlertAction(title: "Log out", style: .destructive , handler: { _ in
            AuthManager.shared.logOut { success in
                DispatchQueue.main.async {
                    if success{
                        let loginvc = LoginViewController()
                        loginvc.modalPresentationStyle = .fullScreen
                        self.present(loginvc,animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }else{
                        
                    }
                }
               
            }
        }))
        actionsheet.popoverPresentationController?.sourceView = tableview
        actionsheet.popoverPresentationController?.sourceRect = tableview.bounds
        present(actionsheet,animated: true)
        
    }
}


extension SettingsViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
    
}
