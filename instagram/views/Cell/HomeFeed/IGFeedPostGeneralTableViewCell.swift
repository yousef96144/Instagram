//
//  IGFeedPostGeneralTableViewCell.swift
//  instagram
//
//  Created by yousef Elaidy on 19/12/2023.
//

import UIKit

class IGFeedPostGeneralTableViewCell: UITableViewCell {

   static let idenefier = "IGFeedPostGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func configure(){
         
    }
}
