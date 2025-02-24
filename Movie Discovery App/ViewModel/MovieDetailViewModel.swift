//
//  MovieDetailViewModel.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/19.
//

import SwiftUI
import Combine

class MovieDetailViewModel: ObservableObject {
    // MARK: - Published Properties (Observable by Views)

    /// Holds the fetched movie details. When updated, the view will automatically refresh.
    @Published var movie: Movie?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let movieService = MovieServices()
    
    // MARK: - Fetch Movie Details

    /// Fetches detailed information for a specific movie by its ID.
    /// - Parameters:
    ///   - id: The unique identifier of the movie to fetch details for.
    ///   - completion: A closure called after the fetch is completed (success or failure).
    func fetchMovieDetails(id: Int, completion: @escaping () -> Void) {
        isLoading = true
        movieService.fetchMovieDetails(movieId: "\(id)") { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movie):
                    self?.movie = movie
                    completion()
                case .failure(let error):
                    print("Error fetching movie details: \(error.localizedDescription)")
                }
            }
        }
    }
}

