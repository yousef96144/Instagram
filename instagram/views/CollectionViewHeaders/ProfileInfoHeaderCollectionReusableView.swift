//
//  ProfileInfoHeaderCollectionReusableView.swift
//  instagram
//
//  Created by yousef Elaidy on 22/12/2023.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject	 {
    func profilheaderdidtappostsbutton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profilheaderdidtapfollowingbuutton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profilheaderdidtapfollowerbutton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profilheaderdidtapeditprofilebutton(_ header: ProfileInfoHeaderCollectionReusableView)

}
class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        addsubviews()
        addbuttonaction()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let profilephotoimage: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .red
        imageview.layer.masksToBounds = true
        return imageview
    }()
    private let postbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let followersbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)

        button.backgroundColor = .secondarySystemBackground


        return button
    }()
    private let followingbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)

        button.backgroundColor = .secondarySystemBackground


        return button
    }()
    private let editprofilebutton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)

        button.backgroundColor = .secondarySystemBackground


        return button
    }()
    private let namelabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "Joe Aidy"
        return label
    }()
    private let biolabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "this is the first account!"

        return label
    }()
    
    private func addbuttonaction(){
        followersbutton.addTarget(self, action: #selector(didtapfollowerbutton), for: .touchUpInside)
        followingbutton.addTarget(self, action: #selector(didtapfollowingbutton), for: .touchUpInside)
        postbutton.addTarget(self, action: #selector(didtappostsbutton), for: .touchUpInside)
        editprofilebutton.addTarget(self, action: #selector(didtapeditprofilebutton), for: .touchUpInside)

    }
    private func addsubviews(){
        addSubview(profilephotoimage)
        addSubview(postbutton)
        addSubview(followersbutton)
        addSubview(followingbutton)
        addSubview(editprofilebutton)
        addSubview(namelabel)
        addSubview(biolabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilephotosize = width/4
        profilephotoimage.frame = CGRect(x: 5, y: 5, width: profilephotosize, height: profilephotosize).integral
        profilephotoimage.layer.cornerRadius = profilephotosize/2.0
        
        let buttonheight = profilephotosize/2
        let countbuttonwidth = (width-10-profilephotosize)/3
        
        postbutton.frame = CGRect(x: profilephotoimage.right, y: 5, width: countbuttonwidth, height: buttonheight).integral
        followingbutton.frame = CGRect(x: postbutton.right, y: 5, width: countbuttonwidth, height: buttonheight).integral
        followersbutton.frame = CGRect(x: followingbutton.right, y: 5, width: countbuttonwidth, height: buttonheight).integral
        editprofilebutton.frame = CGRect(x: profilephotoimage.right, y: 5+buttonheight, width: countbuttonwidth*3, height: buttonheight).integral
        namelabel.frame = CGRect(x: 5, y: 5+profilephotoimage.bottom, width: width-10, height: 50).integral
        let biolabelsize = biolabel.sizeThatFits(frame.size)
        biolabel.frame = CGRect(x: 5, y: 5+namelabel.bottom, width: width-10, height: biolabelsize.height).integral

        
        profilephotoimage.layer.cornerRadius = profilephotosize/2.0
        
    }
    
    @objc func didtapfollowerbutton(){
        delegate?.profilheaderdidtapfollowerbutton(self)
    }
    @objc func didtapfollowingbutton(){
        delegate?.profilheaderdidtapfollowingbuutton(self)
    }
    @objc func didtappostsbutton(){
        delegate?.profilheaderdidtappostsbutton(self)
    }
    @objc func didtapeditprofilebutton(){
        delegate?.profilheaderdidtapeditprofilebutton(self)
    }
    
    
}
