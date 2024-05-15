//
//  ViewController.swift
//  instagram
//
//  Created by yousef Elaidy on 09/12/2023.
//

import UIKit
import FirebaseAuth

struct homefeedrenderviewmodel {
    let header: postrenderviewmodel
    let post: postrenderviewmodel
    let actions: postrenderviewmodel
    let comments: postrenderviewmodel
}
class HomeViewController: UIViewController {
    
    private var feedrendermodels = [homefeedrenderviewmodel]()
    private let tableview: UITableView = {
       let tableview = UITableView()
        tableview.register(IGFeedPostTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableview.register(IGFeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.idenefier)
        tableview.register(IGFeedPostActionsTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostActionsTableViewCell.idenefier)
        tableview.register(IGFeedPostGeneralTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.idenefier)
        return tableview
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        createmocksmodel()
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func createmocksmodel(){
        let user = user(username: "@joeaidy", bio: "", name: (first:"",last:""), birthdate: Date(), gender: .male, counts: usercount(followers: 1, following: 1, posts: 1), profilephoto: URL(string: "https://www.google.com")!)
        let post = UserPost(posttype: .photo, thumbnailimage: URL(string: "https://www.google.com")!, posturl: URL(string: "https://www.google.com")!, caption: nil, likecount: [], comments: [], postDate: Date(), tagpost: [], owner: user)
        
        var comments = [postcomment]()
        
        for x in 0..<2 {
            comments.append(postcomment(identifier: "\(x)", username: "@jenny", text: "this the best post i have seen", createddate: Date(), likes: []))
        }
        for x in 0..<5{
            let viewmodel = homefeedrenderviewmodel(header: postrenderviewmodel(rendertype: .header(provider: user)), post: postrenderviewmodel(rendertype: .primarycontent(provider: post)), actions: postrenderviewmodel(rendertype: .action(provider: "")), comments: postrenderviewmodel(rendertype: .comments(comments: comments)))
            feedrendermodels.append(viewmodel)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    private func handleNotAuthenticated(){
        if Auth.auth().currentUser == nil{
            let loginvc = LoginViewController()
            loginvc.modalPresentationStyle = .fullScreen
            present(loginvc,animated: true)
        }
    }


}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedrendermodels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: homefeedrenderviewmodel
        if x == 0{
            model = feedrendermodels[0]
        }else{
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedrendermodels[position]
        }
        
        let subsection = x % 4
        
        if subsection == 0 {
            //header
            return 1
        }
        else if subsection == 1 {
            //post
            return 1
        }
        else if subsection == 2 {
            //actions
            return 1
        }
        else if subsection == 3 {
            let commentsmodel = model.comments
            switch commentsmodel.rendertype{
            case .comments(let comment): return comment.count > 2 ? 2 : comment.count
            case .action , .primarycontent , .header: return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: homefeedrenderviewmodel
        if x == 0{
            model = feedrendermodels[0]
        }else{
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedrendermodels[position]
        }
        
        let subsection = x % 4
        
        if subsection == 0 {
            //header
            let headermodel = model.header
            switch headermodel.rendertype{
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.idenefier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .action , .primarycontent , .comments: return UITableViewCell()
                
                
            }
        }
        else if subsection == 1 {
            let posrmodel = model.post
            switch posrmodel.rendertype{
            case .primarycontent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case .action , .header , .comments: return UITableViewCell()
                
            }
        }
        else if subsection == 2 {
            let actionmodel = model.actions
            switch actionmodel.rendertype{
            case .action(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.idenefier, for: indexPath) as! IGFeedPostActionsTableViewCell
                cell.delegate = self
                return cell
            case .header , .primarycontent , .comments: return UITableViewCell()
                
            }
        }
        else if subsection == 3 {
            let commentmodel = model.comments
            switch commentmodel.rendertype{
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.idenefier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .action , .primarycontent , .header: return UITableViewCell()
                
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subsection = indexPath.section % 4
        if subsection == 0{
            return 70
        }
        else if subsection == 1 {
            return tableView.width
        }
        else if subsection == 2 {
            return 60
        }
        else if subsection == 3 {
            return 50
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subsection = section % 4
        return subsection == 3 ? 70 : 0
    }
    
}
extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate{
    func didtapmorebutton() {
        let actionsheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Report Post", style: .destructive,handler: {[weak self] _ in
            self?.reportpost()
        } ))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        present(actionsheet, animated: true)
    }
    
    func reportpost(){
        
    }
}
extension HomeViewController: IGFeedPostActionsTableViewCellDelegate{
    func didtablikebutton() {
        print("like")
    }
    
    func didtabcommentbutton() {
        print("comment")
    }
    
    func didtabsendbutton() {
        print("send")
    }
    
    
}
