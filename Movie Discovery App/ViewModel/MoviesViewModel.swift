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
    func fetchpopularMovies() {
        isLoading = true
        movieService.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.movies = movies.results.sorted { $0.title < $1.title }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
