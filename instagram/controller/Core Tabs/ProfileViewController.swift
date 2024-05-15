//
//  ProfileViewController.swift
//  instagram
//
//  Created by yousef Elaidy on 09/12/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
   private let UserPosts = [UserPost]()
    var collectionview: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    configureNavigationBar()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let size = (view.width - 4)/3
        layout.itemSize = CGSize(width: size, height: size)
        collectionview?.register(photocollectionviewcell.self,  forCellWithReuseIdentifier: photocollectionviewcell.identifier)
        collectionview?.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        collectionview?.register(ProfileTabsCollectionReusableView .self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        collectionview?.delegate = self
        collectionview?.dataSource = self
        collectionview?.backgroundColor = .red
        guard let collectionview = collectionview else{
            return
        }
        view.addSubview(collectionview)
       
}

     override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
         collectionview?.frame = view.bounds
        
    }
    private func configureNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),  style: .done, target: self, action: #selector(didTapSettingButton))
}

    @objc private  func didTapSettingButton(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
  

}
extension  ProfileViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let model = UserPosts[indexPath.row]
        let cell = collectionview?.dequeueReusableCell(withReuseIdentifier: photocollectionviewcell.identifier, for: indexPath) as! photocollectionviewcell
//        cell.configure(with: model)
        cell.backgroundColor = .systemBlue
        cell.configure(debug: "test")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = UserPosts[indexPath.row]
        let user = user(username: "joe", bio: "", name: (first:"",last:""), birthdate: Date(), gender: .male, counts: usercount(followers: 1, following: 1, posts: 1), profilephoto: URL(string: "https://www.google.com")!)
        let post = UserPost(posttype: .photo, thumbnailimage: URL(string: "https://www.google.com")!, posturl: URL(string: "https://www.google.com")!, caption: nil, likecount: [], comments: [], postDate: Date(), tagpost: [], owner: user)
        let vc = PostViewController(model: post)
        vc.title = post.posttype.rawValue
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else{
            // footer
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1{
            let tabscontrolheader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
            return tabscontrolheader
        }
        
        let profileheader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        profileheader.delegate = self
        return profileheader
    }
    
  @objc  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        if section == 0 {
            return CGSize(width: collectionView.width, height:  collectionView.height/3)
        }
        // size of section tabs
        return CGSize(width: collectionView.width, height:  50)
    }
}


extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate{
    func profilheaderdidtappostsbutton(_ header: ProfileInfoHeaderCollectionReusableView) {
        collectionview?.scrollToItem(at: IndexPath(row: 0, section: 1),at: .top, animated: true)
    }
    
    func profilheaderdidtapfollowingbuutton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockdata = [userrelationship]()
        for x in 0..<10{
            mockdata.append(userrelationship(username: "@joe", name: "joe smith", type: x % 2 == 0 ? .following : .notfollowing))
        }
        let vc = ListViewController(data: mockdata)
        vc.title = "Following"
   //     vc.navigationItem.LargeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profilheaderdidtapfollowerbutton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockdata = [userrelationship]()
        for x in 0..<10{
            mockdata.append(userrelationship(username: "@joe", name: "joe smith", type: x % 2 == 0 ? .following : .notfollowing))
        }
        let vc = ListViewController(data: mockdata)
        vc.title = "Follower"
     //   vc.navigationItem.LargeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profilheaderdidtapeditprofilebutton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    
}

extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate{
    func gridbutton() {
        
    }
    
    func taggedbuutton() {
        
    }
    
    
}
