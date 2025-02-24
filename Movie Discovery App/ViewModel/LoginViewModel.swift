//
//  LoginViewModel.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/21.
//

import Foundation
import Alamofire

class LoginViewModel {

    // MARK: - Properties

    var movieService = MovieServices()
    /// Closure triggered when the loading state changes (e.g., show/hide a loading spinner).
    var isLoading: ((Bool) -> Void)?
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?

    // MARK: - Initializer

    /// Initializes the `LoginViewModel` with a given `MovieServices` instance for dependency injection.
    /// - Parameter movieService: Allows injecting a custom service for testing purposes.
    init(movieService: MovieServices = MovieServices()) {
        self.movieService = movieService
    }

    var isUserLoggedIn: Bool {
        return UserDefaults.standard.isLoggedIn && KeychainHelper.shared.read(forKey: "loginToken") != nil
    }

    // MARK: - Login Functionality

    /// Performs the login operation by sending credentials to the backend.
    /// - Parameters:
    ///   - email: User's email address.
    ///   - password: User's password.
    func login(email: String, password: String) {
        isLoading?(true)
        movieService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading?(false)
                switch result {
                case .success(let response):
                    self?.saveLoginState(token: response.token ?? "")
                    self?.onLoginSuccess?()
                    print("Login Successful. Token: \(response.token ?? "")")
                case .failure(let error):
                    print("Login Failed: \(error.localizedDescription)")
                    self?.onLoginFailure?("Login failed: \(error.localizedDescription)")
                }
            }
        }
    }

    // MARK: - Save Login State

    /// Saves the login state securely by storing the token in the Keychain and setting a login flag in UserDefaults.
    /// - Parameter token: The token received upon successful authentication.
    private func saveLoginState(token: String) {
        UserDefaults.standard.isLoggedIn = true
        KeychainHelper.shared.save(token, forKey: "loginToken")
    }

    
    // MARK: - Logout Functionality

    /// Logs the user out by clearing the stored token and resetting the login state.
    func logout() {
        UserDefaults.standard.isLoggedIn = false
        KeychainHelper.shared.delete(forKey: "loginToken")
    }
}

