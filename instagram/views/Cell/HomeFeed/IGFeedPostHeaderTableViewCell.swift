//
//  IGFeedPostHeaderTableViewCell.swift
//  instagram
//
//  Created by yousef Elaidy on 19/12/2023.
//

import UIKit
protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didtapmorebutton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {

    static let idenefier = "IGFeedPostHeaderTableViewCell"
     
    public weak var delegate:IGFeedPostHeaderTableViewCellDelegate?
    private let profilephotoimageview: UIImageView = {
        let imageview = UIImageView()
        imageview.clipsToBounds = true
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    private let usernamelabel: UILabel = {
      let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    private let morebutton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
       return button
    }()
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.addSubview(profilephotoimageview)
         contentView.addSubview(usernamelabel)
         contentView.addSubview(morebutton)
         morebutton.addTarget(self, action: #selector(didtapmorebutton), for: .touchUpInside)
         
     }
    
    @objc private func didtapmorebutton(){
        delegate?.didtapmorebutton()
    }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
         let size = contentView.height-4
         profilephotoimageview.frame = CGRect(x: 2, y: 2, width: size, height: size)
         profilephotoimageview.layer.cornerRadius = size/2
         morebutton.frame = CGRect(x: contentView.width-size, y: 2, width: size, height: size)
         usernamelabel.frame = CGRect(x: profilephotoimageview.right+10, y: 2, width: contentView.width-(size*2)-15, height: contentView.height-4)
     }
    func configure(with model: user){
        usernamelabel.text = model.username
        profilephotoimageview.image = UIImage(systemName: "person.circle")
     }
    override func prepareForReuse() {
        super.prepareForReuse()
        usernamelabel.text = nil
        profilephotoimageview.image = nil
    }

}
