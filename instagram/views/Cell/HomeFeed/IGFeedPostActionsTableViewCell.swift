//
//  IGFeedPostActionsTableViewCell.swift
//  instagram
//
//  Created by yousef Elaidy on 19/12/2023.
//

import UIKit

protocol IGFeedPostActionsTableViewCellDelegate: AnyObject {
    func didtablikebutton()
    func didtabcommentbutton()
    func didtabsendbutton()

}
class IGFeedPostActionsTableViewCell: UITableViewCell {

    static let idenefier = "IGFeedPostActionsTableViewCell"
    public weak var delegate:IGFeedPostActionsTableViewCellDelegate?
    private let likebutton: UIButton = {
       let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    private let commentbutton: UIButton = {
       let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    private let sendbutton: UIButton = {
       let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.addSubview(likebutton)
         contentView.addSubview(commentbutton)
         contentView.addSubview(sendbutton)
         
         likebutton.addTarget(self, action: #selector(didtablikebutton), for: .touchUpInside)
         commentbutton.addTarget(self, action: #selector(didtabcommentbutton), for: .touchUpInside)
         sendbutton.addTarget(self, action: #selector(didtabsendbutton), for: .touchUpInside)

     }
    
    @objc private func didtablikebutton(){
        delegate?.didtablikebutton()
    }
    @objc private func didtabcommentbutton(){
        delegate?.didtabcommentbutton()
    }
    @objc private func didtabsendbutton(){
        delegate?.didtabsendbutton()
    }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
         let buttonsize = contentView.height-10
         let buttons = [likebutton,commentbutton,sendbutton]
         for x in 0..<buttons.count{
             let button = buttons[x]
             button.frame = CGRect(x: (CGFloat(x)*buttonsize) + (10*CGFloat(x+1)), y: 5 , width: buttonsize, height: buttonsize)
         }
     }
     func configure(){
          
     }
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
