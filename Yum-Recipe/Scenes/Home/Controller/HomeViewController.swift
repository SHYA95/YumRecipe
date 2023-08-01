//
//  HomeViewController.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 29/07/2023.
//
import UIKit

class HomeViewController: UIViewController, RecipeCollectionViewCellDelegate {
    func didTapFavoriteButton(for recipeID: String) {
    
        }
    
    @IBOutlet weak var Indicator: UIActivityIndicatorView!
    @IBOutlet weak var RecipesCollectionView: UICollectionView!
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader()
        RecipesCollectionView.backgroundColor = .black
        
        setupCollectionView()
        initializeViewModel()
    }
    
    private func setupCollectionView() {
        RecipesCollectionView.register(UINib(nibName: "RecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecipeCollectionViewCell")
        RecipesCollectionView.dataSource = self
        RecipesCollectionView.delegate = self
    }
    
    private func initializeViewModel() {
        viewModel = HomeViewModel()
        viewModel.delegate = self
        viewModel.getData()
        viewModel.recipes.bind { [weak self] _ in
            self?.hideLoader()
            self?.RecipesCollectionView.reloadData()
        }
    }
    
    func showLoader() {
        Indicator.startAnimating()
        Indicator.isHidden = false
    }

    func hideLoader() {
        Indicator.stopAnimating()
        Indicator.isHidden = true
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfRecipes()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as! RecipeCollectionViewCell
        cell.delegate = self

        if let recipe = viewModel.getRecipe(at: indexPath.item) {
            cell.setupCell(recipe)
        }

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
        let cellHeight = cellWidth + 105
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let recipe = viewModel.getRecipe(at: indexPath.item) {
            let recipeDetailsViewModel = DetailsRecipeViewModel(recipe: recipe)
            let recipeDetailsViewController = RecipeDetailsViewController()
            recipeDetailsViewController.viewModel = recipeDetailsViewModel
            navigationController?.pushViewController(recipeDetailsViewController, animated: true)
            

        }
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func didToggleFavoriteStatus(for recipeID: Int) {
    }
    
    func didTapFavoriteButton(for recipeID: Int) {
    }
    func didSelectRecipe(_ recipe: RecipesModel) {
        let recipeDetailsViewModel = DetailsRecipeViewModel(recipe: recipe)
        let recipeDetailsViewController = RecipeDetailsViewController()
        recipeDetailsViewController.viewModel = recipeDetailsViewModel
        navigationController?.pushViewController(recipeDetailsViewController, animated: true)
    }
}
