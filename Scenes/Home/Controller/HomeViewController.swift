//
//  HomeViewController.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var RecipesCollectionView: UICollectionView!
    
    var viewModel: HomeViewModel! // Declare the view model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecipesCollectionView.backgroundColor = .black
        
        viewModel = HomeViewModel() // Initialize the view model
        viewModel.delegate = self // Set the delegate to self
        
        RecipesCollectionView.register(UINib(nibName: "RecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecipeCollectionViewCell")
        RecipesCollectionView.dataSource = self
        RecipesCollectionView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getData()
    }
}


// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9 // Use the view model to get the number of recipes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as! RecipeCollectionViewCell
        
//        let recipe = viewModel.getRecipe(at: indexPath.item) // Use the view model to get the recipe at the specified index
//        cell.configure(with: recipe) // Configure the cell using the recipe
//
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let spacing: CGFloat = 16
        let collectionViewWidth = collectionView.frame.width
        let cellWidth = (collectionViewWidth - 1 * padding - 2 * spacing) / 2
        let cellHeight = cellWidth + 75 // Adjust the height according to your design
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func didSelectRecipe(_ recipe: RecipesModel) {
        // Handle the selected recipe here or navigate to another view controller
    }
}
