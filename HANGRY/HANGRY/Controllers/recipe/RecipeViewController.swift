//
//  RecipeViewController.swift
//  HANGRY
//
//  Created by Dua Almahyani on 12/11/2020.
//

import UIKit

class RecipeViewController: UIViewController, recipeDataDelegate, photoDelegate {
    
    var recipes = [Recipe]()
    var imageKey = String()
    
    var collectionView = UICollectionView()
    
    let addImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "addButton")
        return image
    }()
    
    let RecipeDocumentArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("Recipe.plist")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupCollection()
//
//        loadTasks()
//
//        setupUI()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
//        addImage.isHidden = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addRecipe":
            let vc = segue.destination as! RecipeEntryViewController
            vc.delegate = self
        default:
            break
        }
    }
    
    func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.height/3)-4)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecipesCollectionViewCell.self, forCellWithReuseIdentifier: RecipesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                             bottom: view.bottomAnchor, right: view.rightAnchor,
                             paddingTop: 20, paddingLeft: 0,
                             paddingBottom: 0, paddingRight: 0)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeImage(for: height)
    }
    

    
    func saveChanges() {
        print(RecipeDocumentArchiveURL)
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(recipes)
            try data.write(to: RecipeDocumentArchiveURL, options: [.atomic])
            print(RecipeDocumentArchiveURL)
            print("Action Saved")
        } catch let encodingError {
            print("Error While doing Action: \(encodingError)")
        }
    }
    
    func loadTasks() {
        do {
            let data = try Data(contentsOf: RecipeDocumentArchiveURL)
            let unarchiver = PropertyListDecoder()
            let recipes = try unarchiver.decode([Recipe].self, from: data)
            self.recipes = recipes
        } catch {
            print("Error reading in saved ingredients: \(error)")
        }
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(addImage)
        addImage.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        addImage.clipsToBounds = true
        addImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addImage.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            addImage.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState + 10),
            addImage.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState * 1.4),
            addImage.widthAnchor.constraint(equalTo: addImage.heightAnchor)
        ])
    }
    
    private func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        
        addImage.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    //MARK: - Delegate functions
    
    func addIngredient(_ recipe: Recipe) {
        recipes.append(recipe)
        saveChanges()
    }
    
    func passPhoto(_ imageKeyStore: String) {
        self.imageKey = imageKeyStore
    }
    
    
    
    //MARK: - @objc
    @objc func rightNavItemTapped(_ sender: UIButton){
        performSegue(withIdentifier: "addIngredient", sender: nil)
        addImage.isHidden = true
    }
}



extension RecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipesCollectionViewCell.identifier, for: indexPath) as! RecipesCollectionViewCell
        return cell
    }
    
}

private struct Const {
    /// Image height/width for Large NavBar state
    static let ImageSizeForLargeState: CGFloat = 40
    /// Margin from right anchor of safe area to right anchor of Image
    static let ImageRightMargin: CGFloat = 16
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
    static let ImageBottomMarginForLargeState: CGFloat = 12
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
    static let ImageBottomMarginForSmallState: CGFloat = 6
    /// Image height/width for Small NavBar state
    static let ImageSizeForSmallState: CGFloat = 32
    /// Height of NavBar for Small state. Usually it's just 44
    static let NavBarHeightSmallState: CGFloat = 44
    /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
    static let NavBarHeightLargeState: CGFloat = 96.5
}

