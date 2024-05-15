//
//  NotificationlikeeventTableViewCell.swift
//  instagram
//
//  Created by yousef Elaidy on 06/01/2024.
//

import UIKit
import SDWebImage

protocol NotificationlikeeventTableViewCellDelegate:AnyObject {
    func didtapdelegatepostbutton(model: UserNotification)
}

 class NotificationlikeeventTableViewCell: UITableViewCell {

    static let identifier = "NotificationlikeeventTableViewCell"
    
    weak var delegate:NotificationlikeeventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    
    private let profileimageview: UIImageView = {
        let profileimageview = UIImageView()
        profileimageview.backgroundColor = .tertiarySystemBackground
        profileimageview.image = UIImage(named: "test")
        profileimageview.layer.masksToBounds = true
        profileimageview.contentMode = .scaleAspectFill
        return profileimageview
    }()
    private let label: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@joe liked your photo"
        return label
    }()
    private let button: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    public func configure(with model: UserNotification){
        self.model = model
        switch model.type{
        case .Like(let post):
            let thumbnil = post.thumbnailimage
            guard !thumbnil.absoluteString.contains("google.com")else{
                return
            }
            button.sd_setBackgroundImage(with: thumbnil, for: .normal,completed: nil)
        case .Follow:
            break
        }
        label.text = model.text
        profileimageview.sd_setImage(with: model.user.profilephoto,completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileimageview.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileimageview.layer.cornerRadius = profileimageview.height/2
        
        let size = contentView.height-4
        button.frame = CGRect(x: contentView.width-5-size, y: 2, width: size, height: size)
        label.frame = CGRect(x: profileimageview.right+5, y: 0, width: contentView.width-size-profileimageview.width-16, height: contentView.height)
    }
     
    override func prepareForReuse() {
        super.prepareForReuse()
//        button.setBackgroundImage(nil, for: .normal)
//        label.text = nil
//        profileimageview.image = nil
    }
      
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(button)
        contentView.addSubview(label)
        contentView.addSubview(profileimageview)
        button.addTarget(self, action: #selector(didtabpostbutton), for: .touchUpInside)
        selectionStyle = .none

    }
    
     @objc private func didtabpostbutton(){
         guard let model = model else{
             return
         }
         delegate?.didtapdelegatepostbutton(model: model)
      }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
