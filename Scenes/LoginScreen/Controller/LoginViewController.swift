//
//  LoginViewController.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 29/07/2023.
//
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    var viewModel: LoginViewModel! // Declare the view model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel = LoginViewModel()
    }
    
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        guard let email = EmailTextField.text, let password = PasswordTextField.text else {
            return
        }
        
        viewModel.login(email: email, password: password) { [weak self] success, error in
            if success {
                let homeViewController = HomeViewController()
                let navigationController = UINavigationController(rootViewController: homeViewController)
                navigationController.modalPresentationStyle = .fullScreen
                self?.present(navigationController, animated: true, completion: nil)
            } else {
                self?.showToast(message: error)
                self?.EmailTextField.showErrorBorder()
                self?.PasswordTextField.showErrorBorder()
            }
        }
    }
}
