//
//  TableViewCell.swift
//  instagram
//
//  Created by yousef Elaidy on 19/12/2023.
//

import UIKit
import SDWebImage
import AVFoundation
final class IGFeedPostTableViewCell: UITableViewCell {

    static let  identifier = "IGFeedPostTableViewCell"
    private var player:AVPlayer?
    private var playerlayer = AVPlayerLayer()
    private let postimageview: UIImageView = {
       let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = nil
        imageview.clipsToBounds = true
        return imageview
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerlayer)
        contentView.addSubview(postimageview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost){
        postimageview.image = UIImage(named: "test")
        return
        switch post.posttype{
        case .photo:
            postimageview.sd_setImage(with: post.posturl, completed: nil)
        case .video:
            player = AVPlayer(url: post.posturl)
            playerlayer.player=player
            playerlayer.player?.volume = 0
            playerlayer.player?.play()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        postimageview.frame = contentView.bounds
        playerlayer.frame = contentView.bounds

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        postimageview.image = nil
    }
}
