//
//  NotificationView.swift
//  instagram
//
//  Created by yousef Elaidy on 06/01/2024.
//

import UIKit

class NotificationView: UIView {

    
    private let label: UILabel = {
       let label = UILabel()
        label.text = "No Notification Yet"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let imageview = {
       let imageview = UIImageView()
        imageview.tintColor = .secondaryLabel
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(systemName: "bell")
        return imageview
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageview)
    }
    
    override func layoutSubviews() {
        imageview.frame = CGRect(x: (width-50)/2, y: 0, width: 50, height: 50).integral
        label.frame = CGRect(x: 0, y: imageview.bottom, width: width, height: height-50).integral
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
