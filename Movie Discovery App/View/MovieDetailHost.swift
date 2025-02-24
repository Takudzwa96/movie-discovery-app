//
//  MovieDetailHost.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/21.
//

import SwiftUI
/// A SwiftUI wrapper that hosts a `MovieDetailViewController` within a SwiftUI view.
struct MovieDetailHost: UIViewControllerRepresentable {
    let movieID: Int

    /// Creates and configures the `MovieDetailViewController` instance.
    func makeUIViewController(context: Context) -> MovieDetailViewController {
        let vc = MovieDetailViewController()
        vc.navigationItem.backButtonTitle = ""
        vc.movieID = movieID
        return vc
    }
    /// Updates the `MovieDetailViewController` when SwiftUI state changes.
    func updateUIViewController(_ uiViewController: MovieDetailViewController, context: Context) {}
}

