//
//  SplashViewController.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/23.
//

import UIKit
import SwiftUI

class SplashViewController: UIViewController {
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let logoImageView = UIImageView(image: UIImage(named: "movie_Splash"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.heightAnchor.constraint(equalToConstant: 300)
        ])

        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseOut, animations: {
            logoImageView.alpha = 0
        }) { _ in
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            self.view.window?.rootViewController = navigationController
            self.view.window?.makeKeyAndVisible()
        }

    }
}
