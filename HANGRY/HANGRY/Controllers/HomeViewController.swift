//
//  HomeViewController.swift
//  HANGRY
//
//  Created by Dua Almahyani on 10/11/2020.
//

import Foundation
import UIKit
import Combine

enum Section {
    case informationCollection
    case warrningList
    case generate
}
class HomeViewController: UIViewController {
    
    var collectionView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupCollectionView()
        
    }
//
//    func setupCollectionView() {
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SectionCell")
//    }
}

//extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func numberOfSections(in collectionView: UICollectionView) -> Int { 3 }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 4 }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell =
//    }
//
//}
