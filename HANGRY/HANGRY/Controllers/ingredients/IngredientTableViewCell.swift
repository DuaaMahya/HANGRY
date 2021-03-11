//
//  TableViewCell.swift
//  toDoList
//
//  Created by Dua Almahyani on 03/11/2020.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
        
    lazy var cellContainerView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width, height: 70))
        view.backgroundColor = UIColor(named: "lightPurple")
        view.layer.cornerRadius = 9.0
        
        view.addSubview(ingredientImage)
        ingredientImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        ingredientImage.anchor(top: view.topAnchor, left: view.leftAnchor,
                               paddingTop: 12, paddingLeft: 10,
                               width: 35, height: 30)
        ingredientImage.layer.cornerRadius = 35/2
        
        view.addSubview(ingredientNameLabel)
        ingredientNameLabel.anchor(top: view.topAnchor, left: ingredientImage.rightAnchor, paddingTop: 12, paddingLeft: 10)
        
        view.addSubview(remainingTimeLabel)
        remainingTimeLabel.anchor(top: ingredientNameLabel.bottomAnchor, left: ingredientImage.rightAnchor,
                                  paddingTop: 5, paddingLeft: 10)
        
        return view
    }()
    
    let ingredientImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "pickImage")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
 
    
    let ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.text = "label"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "due in"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    var getImage = UIImage()
    var getIngredientName = String()
    var getRemainingTime = Date()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ingredientImage.image = getImage
        ingredientNameLabel.text = getIngredientName
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = UIColor(named: "BGColor")

        addSubview(cellContainerView)
        cellContainerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 5, paddingRight: 20)
        
        if getRemainingTime != nil {
            let reminTime = calculateRemainingTime(date: getRemainingTime)
            remainingTimeLabel.text = reminTime
        }
        
    }
    
    func calculateRemainingTime(date: Date) -> String {
        let now = Date()
        let calendar = Calendar.current.dateComponents([.day, .hour, .minute], from: now, to: date)
        let day = calendar.day
        let hour = calendar.hour
        let minutes = calendar.minute
        
        return "\(String(describing: day!))D \(String(describing: hour!))H \(String(describing: minutes!))m"
    }
    

}
