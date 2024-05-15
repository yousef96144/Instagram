//
//  ProfileTabsCollectionReusableView.swift
//  instagram
//
//  Created by yousef Elaidy on 22/12/2023.
//

import UIKit
protocol ProfileTabsCollectionReusableViewDelegate: AnyObject     {
    func gridbutton()
    func taggedbuutton()


}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
      static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    struct constant {
        static let padding: CGFloat = 8
    }
    let gridbutton:UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
   private let taggedbutton:UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubview(taggedbutton)
        addSubview(gridbutton)
        gridbutton.addTarget(self, action: #selector(didtapgridbutton), for: .touchUpInside)
        taggedbutton.addTarget(self, action: #selector(didtaptagbutton), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   @objc private func didtapgridbutton(){
       gridbutton.tintColor = .systemBlue
       taggedbutton.tintColor = .lightGray
       delegate?.taggedbuutton()
       
    }
    
   @objc private func didtaptagbutton(){
       gridbutton.tintColor = .lightGray
       taggedbutton.tintColor = .systemBlue
       delegate?.gridbutton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (constant.padding * 2)
        let gridbuttonx = ((width/2)-size)/2
        gridbutton.frame = CGRect(x: gridbuttonx, y: constant.padding, width: size, height: size)
        taggedbutton.frame = CGRect(x: gridbuttonx+(width/2), y: constant.padding, width: size, height: size)
        
    }
    
    
}
