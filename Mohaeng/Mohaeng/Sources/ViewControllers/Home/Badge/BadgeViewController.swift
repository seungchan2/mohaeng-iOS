//
//  MedalViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/09/18.
//

import UIKit

import SnapKit
import Then

class BadgeViewController: UIViewController {
    
// MARK: - Properties
    private var collectionView: UICollectionView!
    
    private let badges: [Badge] = [Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라왈랄왈랄ㄹ라왈랄ㄹ라왈랄ㄹ라왈랄ㄹ라왈랄ㄹ라왈랄왈랄ㄹ라왈랄ㄹ라왈랄ㄹ라왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: false),
                                  Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: true),
                                  Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: true),
                                  Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: true),
                                  Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: true),
                                  Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: true),
                                  Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: true),
                                  Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: true),
                                  Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: true),
                                  Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: true),
                                  Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: true),
                                  Badge(id: 0, name: "초급사진가", info: "왈랄ㄹ라", image: "typeCforMapGrey", hasBadge: true)
    ]
    
// MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewController()
        initNavigationBar()
        initCollectionView()
        
        setDelegation()
        setLayout()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
// MARK: - Functions
    
    private func initViewController() {
        view.backgroundColor = .White
        tabBarController?.tabBar.isHidden = true
    }
    
    private func initNavigationBar() {
        navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        navigationItem.title = "배지"
    }
    
    private func initCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .White
        collectionView.register(BadgeCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: BadgeCollectionViewCell.self))
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setDelegation() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - UIViewControllerTransitioningDelegate
extension BadgeViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: - UICollectionViewDelegate
extension BadgeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let badgeModalViewController = BadgeModalViewController(badge: badges[indexPath.item])
        
        badgeModalViewController.modalPresentationStyle = .custom
        badgeModalViewController.transitioningDelegate = self
        
        self.present(badgeModalViewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension BadgeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BadgeCollectionViewCell.self), for: indexPath) as? BadgeCollectionViewCell
        else { return UICollectionViewCell() }
        cell.setData(badge: badges[indexPath.item])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BadgeViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let width = UIScreen.main.bounds.width
            
            let cellWidth = width * (155/375)
            let cellHeight = cellWidth * (159/155)
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 30, left: 24, bottom: 24, right: 24)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 17
        }
}