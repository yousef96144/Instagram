//
//  UserFollowTableViewCell.swift
//  instagram
//
//  Created by yousef Elaidy on 01/01/2024.
//

import UIKit

protocol UserFollowTableViewCellDelegate:AnyObject {
    func didtapfollowunfollowbutton(model: userrelationship)
}

enum followstate{
    case following,notfollowing
}

struct userrelationship {
    let username: String
    let name: String
    let type: followstate
}
class UserFollowTableViewCell: UITableViewCell {
    
    
    static let identifier = "UserFollowTableViewCell"
    
    private var model: userrelationship?
    
    public weak var delegate: UserFollowTableViewCellDelegate?
    
    private let profileimageview: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleToFill
        imageview.layer.masksToBounds = true
        imageview.backgroundColor = .secondarySystemBackground
        return imageview
    }()
    private let namelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17,weight: .semibold)
        label.text = "joe"
        return label
    }()
    private let usernamelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16,weight: .regular )
        label.text = "@joe"
        label.textColor = .secondaryLabel
        return label
    }()
    private let followbutton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        selectionStyle = .none
        contentView.addSubview(profileimageview)
        contentView.addSubview(namelabel)
        contentView.addSubview(usernamelabel)
        contentView.addSubview(followbutton)
        
        followbutton.addTarget(self, action: #selector(didtapfollowerbutton), for: .touchUpInside)
        
    }
    
  
    override func prepareForReuse() {
        super.prepareForReuse()
        profileimageview.image = nil
        namelabel.text=nil
        usernamelabel.text = nil
        followbutton.setTitle(nil, for: .normal)
        followbutton.layer.borderWidth = 0
        followbutton.backgroundColor = nil
    }
    
    public func configure(with model: userrelationship){
        
        self.model = model
        namelabel.text = model.name
        usernamelabel.text = model.username
        switch model.type {
        case .following:
            followbutton.setTitle("Unfollow", for: .normal)
            followbutton.setTitleColor(.label, for: .normal)
            followbutton.backgroundColor = .systemBackground
            followbutton.layer.borderWidth = 1
            followbutton.layer.borderColor = UIColor.label.cgColor
        case .notfollowing:
            followbutton.setTitle("Follow", for: .normal)
            followbutton.setTitleColor(.white, for: .normal)
            followbutton.backgroundColor = .systemBlue
            followbutton.layer.borderWidth = 0
        }
    }
    
    @objc private func didtapfollowerbutton(){
        guard let model = model else{
            return
        }
       delegate?.didtapfollowunfollowbutton(model: model)
    }
    override func layoutSubviews() {
        profileimageview.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileimageview.layer.cornerRadius = profileimageview.height/2.0
        
        let buttonwidth = contentView.width > 500 ? 220.0 : contentView.width/3
        followbutton.frame = CGRect(x: contentView.width-5-buttonwidth, y: (contentView.height-40)/2, width: buttonwidth, height:40)
        let labelheight = contentView.height/2
        namelabel.frame = CGRect(x: profileimageview.right+5, y: 0, width: contentView.width-8-profileimageview.width-buttonwidth, height: labelheight)
        usernamelabel.frame = CGRect(x: profileimageview.right+5, y: namelabel.bottom, width: contentView.width-8-profileimageview.width-buttonwidth, height: labelheight)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
