//
//  NotificationlikeeventTableViewCell.swift
//  instagram
//
//  Created by yousef Elaidy on 06/01/2024.
//

import UIKit

protocol NotificationfolloweventTableViewCellDelegate:AnyObject {
    func didtabfollowunfollowbutton(model: UserNotification)
}

class NotificationfolloweventTableViewCell: UITableViewCell {

    static let identifier = "NotificationfolloweventTableViewCell"
    
    weak var delegate:NotificationfolloweventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileimageview: UIImageView = {
        let profileimageview = UIImageView()
        profileimageview.layer.masksToBounds = true
        profileimageview.contentMode = .scaleAspectFill
        profileimageview.backgroundColor = .tertiarySystemBackground
        return profileimageview
    }()
    private let label: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@3bdo started followed you."
        return label
    }()
    private let button: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileimageview.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileimageview.layer.cornerRadius = profileimageview.height/2
        
        let size: CGFloat = 100
        let buttonheight: CGFloat = 40
        button.frame = CGRect(x: contentView.width-5-size, y: (contentView.height-44)/2, width: size, height: buttonheight)
        label.frame = CGRect(x: profileimageview.right+5, y: 0, width: contentView.width-size-profileimageview.width-16, height: contentView.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        button.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileimageview.image = nil
    }
    
    public func configure(with model: UserNotification){
        self.model = model
        switch model.type{
        case .Like(_):
           break
        case .Follow(let state):
            switch state{
            case .following:
                print("following")
                configurefollowbutton()
            case .notfollowing:
                print("not following")
                button.setTitle("follow", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.layer.borderWidth = 0
                button.backgroundColor = .link
            }
            
            break
        }
        label.text = model.text
        profileimageview.sd_setImage(with: model.user.profilephoto,completed: nil)
    }
    
    private func configurefollowbutton(){
        button.setTitle("unfollow", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(button)
        contentView.addSubview(label)
        contentView.addSubview(profileimageview)
        button.addTarget(self, action: #selector(didtapfollowerbutton), for: .touchUpInside)
        configurefollowbutton()
        selectionStyle = .none
    }
    
  @objc private func didtapfollowerbutton(){
        guard let model = model else{
            return
        }
      delegate?.didtabfollowunfollowbutton(model: model)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
