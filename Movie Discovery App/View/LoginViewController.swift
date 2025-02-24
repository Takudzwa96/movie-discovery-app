//
//  LoginViewController.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/20.
//

import UIKit
import SwiftUI
import LocalAuthentication


class LoginViewController: UIViewController {

    // MARK: - UI Outlets

    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var LoginLabel: UILabel!
    @IBOutlet private var loginButton: UIButton!

    // MARK: - Properties

    private let viewModel = LoginViewModel()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
        if viewModel.isUserLoggedIn {
            navigateToMovieScreen()
        } else {
            authenticateWithBiometrics()
        }
    }

    // MARK: - UI Setup

    private func setupUI() {
        // Set up userImageView
        userImageView.contentMode = .scaleAspectFill
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.clipsToBounds = true
        userImageView.image = UIImage(named: "icons_user")

        LoginLabel.text = "LOGIN"
        LoginLabel.textColor = .black
        LoginLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        // Set up passwordTextField
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderWidth = 4.0
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = UIColor.clear.cgColor

        // Set up loginButton
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        configureTextField(emailTextField)
        configureTextField(passwordTextField)

    }

    // MARK: - ViewModel Binding
    /// Binds ViewModel states to UI updates
    private func bindViewModel() {
        viewModel.isLoading = { [weak self] isLoading in
            self?.loginButton.isEnabled = !isLoading
            self?.loginButton.setTitle(isLoading ? "Logging in..." : "Login", for: .normal)
        }

        viewModel.onLoginSuccess = { [weak self] in
            self?.navigateToMovieScreen()
        }

        viewModel.onLoginFailure = { [weak self] errorMessage in
            self?.showError(errorMessage)
        }
    }

    // MARK: - Text Field Configuration

    /// Adds rounded borders and validation for text fields
    private func configureTextField(_ textField: UITextField) {
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    /// Validates text field input and updates the login button state
    @objc private func textFieldDidChange() {
        let isInputValid = !(emailTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true)
        loginButton.isEnabled = isInputValid
        loginButton.backgroundColor = isInputValid ? .blue : UIColor.gray.withAlphaComponent(0.5)
    }

    // MARK: - Login Handling

    /// Triggered when the login button is tapped
    @objc private func loginButtonTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        guard !email.isEmpty, !password.isEmpty else {
            showError("Please enter both email and password.")
            return
        }
        viewModel.login(email: email, password: password)
    }

    private func showError(_ message: String) {
        let alertController = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    private func navigateToMovieScreen() {
        let movieVC = UIHostingController(rootView: MoviesView())
        navigationController?.setViewControllers([movieVC], animated: true)
    }
}

// MARK: - Biometric Authentication Handling

extension LoginViewController {

    /// Checks if biometric authentication is available on the device
    func canUseBiometrics() -> Bool {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            return true
        } else {
            return false
        }
    }

    /// Initiates biometric authentication and handles the result
    func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to log in") { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        self.navigateToMovieScreen()
                    } else {
                        self.showError(error?.localizedDescription ?? "")
                    }
                }
            }
        } else {
            self.showBiometricUnavailableError()
        }
    }

    /// Displays an error if biometric authentication is unavailable
    func showBiometricUnavailableError() {
        let alertController = UIAlertController(title: "Biometrics Unavailable", message: "Biometric authentication is not available on this device. Please use another login method.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }


}
