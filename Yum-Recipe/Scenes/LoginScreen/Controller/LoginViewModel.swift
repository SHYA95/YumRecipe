//
//  LoginViewModel.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 29/07/2023.
//

import Foundation


class LoginViewModel {
    func login(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
            // Check email format
            guard isValidEmail(email) else {
                completion(false, "Invalid email format")
                return
            }
            
            // Check email and password
        if email == NetworkConstants.validEmail && password == NetworkConstants.validPassword {
                completion(true, "")
            } else {
                completion(false, "Incorrect email or password")
            }
        }
        
        private func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }
    }
