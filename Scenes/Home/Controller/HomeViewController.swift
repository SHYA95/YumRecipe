import UIKit

class HomeViewController: UIViewController ,UICollectionViewDelegate{
    
    @IBOutlet weak var Indicator: UIActivityIndicatorView!
    @IBOutlet weak var RecipesCollectionView: UICollectionView!
    
    var viewModel: HomeViewModel! // Declare the view model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader()
        RecipesCollectionView.backgroundColor = .black
        
        viewModel = HomeViewModel() // Initialize the view model
        viewModel.delegate = self // Set the delegate to self
     
        RecipesCollectionView.register(UINib(nibName: "RecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecipeCollectionViewCell")
        RecipesCollectionView.dataSource = self
        RecipesCollectionView.delegate = self
        
        // Call getData to fetch the data from the API
                viewModel.getData()
                
                // Bind the data to the collection view
                viewModel.recipes.bind { [weak self] _ in
                    self?.hideLoader() // Hide the loader indicator once the data is loaded
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
        return viewModel.getNumberOfRecipes() // Use the view model to get the number of recipes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as! RecipeCollectionViewCell
        
        if let recipe = viewModel.getRecipe(at: indexPath.item) { // Unwrap the recipe
            cell.setupCell(recipe) // Configure the cell using the recipe
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
        // Adjust the height according to your design
        
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
            // Create an instance of DetailsRecipeViewModel with the selected recipe
            let recipeDetailsViewModel = DetailsRecipeViewModel(recipe: recipe)
            
            // Create an instance of RecipeDetailsViewController
            let recipeDetailsViewController = RecipeDetailsViewController()
            
            // Set the view model of RecipeDetailsViewController
            recipeDetailsViewController.viewModel = recipeDetailsViewModel
            
            // Push the RecipeDetailsViewController onto the navigation stack
            navigationController?.pushViewController(recipeDetailsViewController, animated: true)
        }
    }
    
}

// MARK: - HomeViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func didSelectRecipe(_ recipe: RecipesModel) {
        let recipeDetailsViewModel = DetailsRecipeViewModel(recipe: recipe)
        let recipeDetailsViewController = RecipeDetailsViewController()
        recipeDetailsViewController.viewModel = recipeDetailsViewModel
        navigationController?.pushViewController(recipeDetailsViewController, animated: true)
    }
}
