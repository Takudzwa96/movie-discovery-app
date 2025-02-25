//
//  MoviesViewModel.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/18.
//

import SwiftUI
import Combine

class MoviesViewModel: ObservableObject {
    // MARK: - Published Properties (Observable by Views)

    /// Holds the fetched movies. When updated, the view will automatically refresh.
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var searchText = ""
    @Published var errorMessage: String?

    private let movieService = MovieServices()

    var searchedMovies: [Movie] {
        guard !searchText.isEmpty else { return movies }
        return movies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    // MARK: - Fetch Movies

    /// Fetches movies
    func fetchPopularMovies() {
        isLoading = true
        errorMessage = nil

        movieService.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let movies):
                    if movies.results.isEmpty {
                        self.errorMessage = "No movies available at the moment."
                    } else {
                        self.movies = movies.results.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
                    }
                case .failure(let error):
                    if let afError = error.asAFError {
                        switch afError.responseCode {
                        case 401:
                            self.errorMessage = "Unauthorized access. Please log in again."
                        case 404:
                            self.errorMessage = "Movies not found. Please try again later."
                        default:
                            self.errorMessage = "An unexpected error occurred. Please try again."
                        }
                    } else {
                        self.errorMessage = "Failed to load movies. Please check your internet connection."
                    }
                }
            }
        }
    }
}
