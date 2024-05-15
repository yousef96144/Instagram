//
//  photocollectionviewcell.swift
//  instagram
//
//  Created by yousef Elaidy on 22/12/2023.
//

import UIKit
import SDWebImage
class photocollectionviewcell: UICollectionViewCell {
    static let identifier = "photocollectionviewcell"
    
    let imageview: UIImageView = {
       let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageview.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageview.image = nil
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageview)
        contentView.clipsToBounds = true
        accessibilityLabel = "user post image"
        accessibilityHint = "Double Tap To Open Post"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(with model: UserPost){
        let url = model.thumbnailimage
       
            imageview.sd_setImage(with: url,completed: nil )

        }
    
    
    public func configure(debug imageName: String){
        imageview.image =   UIImage(named: imageName )
    }
}
