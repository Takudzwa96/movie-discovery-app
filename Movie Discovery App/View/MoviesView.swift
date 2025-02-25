//
//  MoviesView.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/19.
//

import SwiftUI

/// The main view displaying a list of popular movies with search functionality.
struct MoviesView: View {
    @StateObject private var viewModel = MoviesViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)

                if viewModel.isLoading {
                    LoadingSpinner()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.red)
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                        Button(action: {
                            viewModel.fetchPopularMovies()
                        }) {
                            Text("Retry")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                } else {
                    List(viewModel.searchedMovies) { movie in
                        NavigationLink {
                            MovieDetailHost(movieID: movie.id)
                        } label: {
                            MovieRow(movie: movie)
                        }
                    }
                }
            }
            .navigationTitle("Movies")
        }
        .onAppear { viewModel.fetchPopularMovies() }
    }
}

/// A view representing a single movie item within the list.
struct MovieRow: View {
    let movie: Movie

    var body: some View {
        HStack {
            AsyncImage(url: movie.posterURL) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 80, height: 120)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(movie.title).font(.headline)
                Text(movie.releaseDate).font(.subheadline)
                Text("Rating: \(movie.voteAverage, specifier: "%.1f")/10")
            }
        }
    }
}
