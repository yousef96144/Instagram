//
//  ExploreViewController.swift
//  instagram
//
//  Created by yousef Elaidy on 09/12/2023.
//

import UIKit

class ExploreViewController: UIViewController {

    private var models = [UserPost]()
    private var searchbar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.backgroundColor = .secondarySystemBackground
        searchbar.placeholder = "Search"
        return searchbar
    }()
    private var collectionview: UICollectionView?
    private let dimmedview: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchbar
        view.addSubview(dimmedview)
        
        let layout=UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
        layout.itemSize = CGSize(width: (view.width-4)/3, height: (view.width-4)/3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview?.register(photocollectionviewcell.self, forCellWithReuseIdentifier: photocollectionviewcell.identifier)
       
        collectionview?.delegate=self
        collectionview?.dataSource=self
        guard let collectionview = collectionview else{
            return
        }
        view.addSubview(collectionview)
        searchbar.delegate = self
        
        }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionview?.frame = view.bounds
        dimmedview.frame = view.bounds
    }
    

   

}
extension ExploreViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionview?.dequeueReusableCell(withReuseIdentifier: photocollectionviewcell.identifier, for: indexPath) as? photocollectionviewcell else {
            return UICollectionViewCell()
        }
        cell.configure(debug: "test")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = user(username: "joe", bio: "", name: (first:"",last:""), birthdate: Date(), gender: .male, counts: usercount(followers: 1, following: 1, posts: 1), profilephoto: URL(string: "https://www.google.com")!)
        let post = UserPost(posttype: .photo, thumbnailimage: URL(string: "https://www.google.com")!, posturl: URL(string: "https://www.google.com")!, caption: nil, likecount: [], comments: [], postDate: Date(), tagpost: [], owner: user)
        let vc = PostViewController(model: post)
        vc.title=post.posttype.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ExploreViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text =  searchbar.text, !text.isEmpty else {
            return
        }
        query(
            text)
    }
    private func query(_ text : String)
    {
                
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(didtabcancelbarbutton))
        dimmedview.isHidden = false
        UIView.animate(withDuration: 0.2){
            self.dimmedview.alpha = 0.4
        }
                       }
    @objc private func didtabcancelbarbutton(){
        searchbar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        UIView.animate(withDuration: 0.2,animations:{
            self.dimmedview.alpha = 0
        }){done in
            if done{
                self.dimmedview.isHidden = true

            }
        }
    }
}
