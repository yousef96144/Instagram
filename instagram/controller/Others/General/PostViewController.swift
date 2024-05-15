//
//  PostViewController.swift
//  instagram
//
//  Created by yousef Elaidy on 09/12/2023.
//

import UIKit

enum postrendertype{
    case header(provider: user)
    case primarycontent(provider: UserPost)
    case action(provider: String)
    case comments(comments: [postcomment])
}
struct postrenderviewmodel {
  let rendertype: postrendertype
}
class PostViewController: UIViewController {
    private let model: UserPost?
    private var rendermodels = [postrenderviewmodel]()
    init(model: UserPost?){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        configuremodel()
      //  view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    private func configuremodel(){
        guard let userpostmodel = self.model else{
            return
        }
        rendermodels.append(postrenderviewmodel(rendertype: .header(provider: userpostmodel.owner)))
        rendermodels.append(postrenderviewmodel(rendertype: .primarycontent(provider: userpostmodel)))
        rendermodels.append(postrenderviewmodel(rendertype: .action(provider: "")))
        var comment = [postcomment]()
        for x in 0..<4{
            comment.append(postcomment(identifier: "123\(x)", username: "@dave", text: "great post!", createddate: Date(), likes: []))
        }
        rendermodels.append(postrenderviewmodel(rendertype: .comments(comments: comment)))

    }
    

}

extension PostViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return rendermodels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch rendermodels[section].rendertype{
        case .action(_): return 1
        case .comments(let comment): return comment.count > 4 ? 4:comment.count
        case .primarycontent(_): return 1
        case .header(_): return 1

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = rendermodels[indexPath.section]
        
        switch model.rendertype{
            
        case .action(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.idenefier, for: indexPath) as! IGFeedPostActionsTableViewCell
            return cell
            
        case .comments(let comment):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.idenefier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
        case .primarycontent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.idenefier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
        }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = rendermodels[indexPath.section]

        switch model.rendertype{
        case .action(_):
            return 60
            
        case .comments(_):
            return 50
        case .primarycontent(_):
            return tableView.width

        case .header(_):
            return 70
        }
    }
    
    
    
}
