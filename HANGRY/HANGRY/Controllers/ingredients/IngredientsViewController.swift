//
//  ViewController.swift
//  HANGRY
//
//  Created by Dua Almahyani on 08/11/2020.
//

import UIKit

class IngredientsViewController: UIViewController, ingredientDataDelegate, photoDelegate  {
    
    
    var ingredients = [Ingredient]()
    
    var tableView = UITableView()
    
    var imageArray = [UIImage]()
    var imageKey = String()
    var imageStore = ImageStore()
    
    let addImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "addButton")
        return image
    }()
    
    let ingredientDocumentArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("ingredientsList.plist")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BGColor")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightNavItemTapped(_:)))
            addImage.isUserInteractionEnabled = true
            addImage.addGestureRecognizer(tapGestureRecognizer)

        
        loadTasks()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupTableView()

        setupUI()
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        addImage.isHidden = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addIngredient":
            let vc = segue.destination as! IngredientEntryViewController
            vc.delegate = self
        default:
            break
        }
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeImage(for: height)
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "BGColor")
        tableView.separatorColor = .clear
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: "ingredientCell")
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                         bottom: view.bottomAnchor, right: view.rightAnchor,
                         paddingTop: 20, paddingLeft: 0,
                         paddingBottom: 0, paddingRight: 0)
        tableView.reloadData()
        
    }
    let queue = DispatchQueue(label: "import image", attributes: [.concurrent])
    
    func saveChanges() {
        print(ingredientDocumentArchiveURL)
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(ingredients)
            try data.write(to: ingredientDocumentArchiveURL, options: [.atomic])
            print(ingredientDocumentArchiveURL)
            print("Action Saved")
        } catch let encodingError {
            print("Error While doing Action: \(encodingError)")
        }
    }
    
    func loadTasks() {
        do {
            let data = try Data(contentsOf: ingredientDocumentArchiveURL)
            let unarchiver = PropertyListDecoder()
            let ingredient = try unarchiver.decode([Ingredient].self, from: data)
            ingredients = ingredient
        } catch {
            print("Error reading in saved ingredients: \(error)")
        }
        tableView.reloadData()
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
    
    func addIngredient(_ ingredient: Ingredient) {
        ingredients.append(ingredient)
        saveChanges()
        tableView.reloadData()
    }
    
    func passPhoto(_ imageKeyStore: String) {
        self.imageKey = imageKeyStore
        tableView.reloadData()
    }
    

    
    //MARK: - @objc
    @objc func rightNavItemTapped(_ sender: UIButton){
        performSegue(withIdentifier: "addIngredient", sender: nil)
        addImage.isHidden = true
    }
}



extension IngredientsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientTableViewCell
        let ingredient = ingredients[indexPath.row]
        cell.ingredientNameLabel.text! = ingredient.name
        cell.getRemainingTime = ingredient.expiresDate
        //let image = imageArray[indexPath.row]
        let image = imageStore.fetchImage(forKey: ingredient.ingredientKey)
        print(ingredient.ingredientKey)
        if image != nil {
            cell.ingredientImage.image = image
        }
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let DvC = storyboard.instantiateViewController(identifier: "taskDetailVC")
//
//
//
//        self.navigationController?.pushViewController(DvC, animated: true)
//
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let ingredient = ingredients[indexPath.row]
            imageStore.deleteImage(forKey: ingredient.ingredientKey)
            ingredients.remove(at: indexPath.row)
            saveChanges()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
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

