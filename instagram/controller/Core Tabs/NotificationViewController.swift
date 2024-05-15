//
//  NotificationViewController.swift
//  instagram
//
//  Created by yousef Elaidy on 09/12/2023.
//

import UIKit
enum UserNotificationType{
    case Like(post: UserPost)
    case Follow(followstate: followstate)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: user
}
final class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    private let tableview: UITableView = {
        let tableview = UITableView()
      //  tableview.isHidden = true
        tableview.register(NotificationlikeeventTableViewCell.self, forCellReuseIdentifier: NotificationlikeeventTableViewCell.identifier)
        tableview.register(NotificationfolloweventTableViewCell.self, forCellReuseIdentifier: NotificationfolloweventTableViewCell.identifier)
        return tableview
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let model = models[indexPath.row]
        switch model.type{
        case .Like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationlikeeventTableViewCell.identifier, for: indexPath) as! NotificationlikeeventTableViewCell
            cell.delegate = self
            cell.configure(with: model)
            return cell

        case .Follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationfolloweventTableViewCell.identifier, for: indexPath) as! NotificationfolloweventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell

        }
     
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }

   
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var notificationview = NotificationView()
    
    private var models = [UserNotification]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchnotification()
        navigationItem.title = "Notification"
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
       // spinner.startAnimating()
        view.addSubview(tableview)
        tableview.delegate=self
        tableview.dataSource=self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
      
    }
  
    func addnonotification() {
        tableview.isHidden = true
        view.addSubview(tableview)
        notificationview.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        notificationview.center = view.center
    }
    
    private func fetchnotification(){
        for x in 0...100 {
            let user = user(username: "joe", bio: "", name: (first:"",last:""), birthdate: Date(), gender: .male, counts: usercount(followers: 1, following: 1, posts: 1), profilephoto: URL(string: "https://www.google.com")!)
            let post = UserPost(posttype: .photo, thumbnailimage: URL(string: "https://www.google.com")!, posturl: URL(string: "https://www.google.com")!, caption: nil, likecount: [], comments: [], postDate: Date(), tagpost: [], owner: user)
            let model = UserNotification(type: x % 2 == 0 ? .Like(post: post) : .Follow(followstate: .notfollowing), text: "Hello World", user: user )
            models.append(model)
        }
    }

}

extension NotificationViewController: NotificationlikeeventTableViewCellDelegate{
    func didtapdelegatepostbutton(model: UserNotification) {
        
        switch model.type{
            
        case .Like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.posttype.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            
            navigationController?.pushViewController(vc, animated: true)
            
        case .Follow(_):
            fatalError("dev issue: should never get called")
         
            
        }
        
        
    }
}
extension NotificationViewController: NotificationfolloweventTableViewCellDelegate{
    func didtabfollowunfollowbutton(model: UserNotification) {
        print("button pressed")

    }
    
}
