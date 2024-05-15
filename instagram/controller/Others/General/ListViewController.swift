

import UIKit

class ListViewController: UIViewController {
    
    
    private let data: [userrelationship]
    private let tableview: UITableView = {
        let tableview = UITableView()
        tableview.register(UserFollowTableViewCell.self, forCellReuseIdentifier: UserFollowTableViewCell.identifier)
        return tableview
    }()
    init(data: [userrelationship]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
       
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        tableview.frame = view.bounds
    }

}


extension ListViewController: UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(data.count)
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier, for: indexPath) as! UserFollowTableViewCell
        let model = data[indexPath.row]
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // goto profile of followers  & following
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  75
    }
    
  
    
}

extension ListViewController: UserFollowTableViewCellDelegate{
    func didtapfollowunfollowbutton(model: userrelationship) {
        switch model.type{
        case .following:
            //unfolloe
            break
        case .notfollowing:
            //follow
            break
        }
    }
    
    
}
