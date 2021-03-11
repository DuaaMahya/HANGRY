//
//  RecipesCollectionViewCell.swift
//  HANGRY
//
//  Created by Dua Almahyani on 12/11/2020.
//

import UIKit

class RecipesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "collectionCell"
    
//    var serving: Int = 0
//
//    lazy var servingContainerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .purple
//        view.layer.cornerRadius = 9
//
//        view.addSubview(servingMinusButton)
//        servingMinusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        servingMinusButton.anchor(top: view.topAnchor, left: view.leftAnchor,
//                                  paddingTop: 5, paddingLeft: 5)
//
//        view.addSubview(servingLabel)
//        servingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        servingLabel.anchor(top: view.topAnchor, paddingTop: 5)
//
//        view.addSubview(servingMinusButton)
//        servingMinusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        servingMinusButton.anchor(top: view.topAnchor, right: view.rightAnchor,
//                                  paddingTop: 5, paddingRight: 5)
//
//        return view
//    }()
//
//    let recipeImage: UIImageView = {
//        let image = UIImageView()
//        image.image = #imageLiteral(resourceName: "pickImage")
//        return image
//    }()
//
//    let recipeTitle: UILabel = {
//        let label = UILabel()
//        label.text = "Title"
//        return label
//    }()
//
//    let servingLabel: UILabel = {
//        let label = UILabel()
//        label.text = ""
//        return label
//    }()
//
//    let servingAdditionButton: UIButton = {
//        let button = UIButton()
//        button.titleLabel?.text = "+"
//        button.backgroundColor = .green
//        return button
//    }()
//
//    let servingMinusButton: UIButton = {
//        let button = UIButton()
//        button.titleLabel?.text = "-"
//        button.backgroundColor = .green
//        return button
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.backgroundColor = .systemBlue
//
//        contentView.addSubview(recipeImage)
//
//        contentView.addSubview(servingContainerView)
//
//        contentView.addSubview(recipeTitle)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        recipeImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        recipeImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingRight: 10, width: 101, height: 101)
//
//        servingContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        servingContainerView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor,
//                                    right: contentView.rightAnchor,
//                                    paddingTop: 92, paddingLeft: 0, paddingRight: 0,
//                                    width: 130, height: 37)
//
//        recipeTitle.anchor(top: servingContainerView.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, paddingTop: 5, paddingLeft: 2, paddingBottom: 5)
//    }
    
}
