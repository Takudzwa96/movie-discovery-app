//
//  MovieDetailViewController.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/21.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    // MARK: - UI Outlets

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var watchTrailerButton: UIButton!

    // MARK: - Properties

    var movieID: Int!
    private let viewModel = MovieDetailViewModel()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchMovieDetails(id: movieID) { [weak self] in
            self?.updateUI()
        }
    }

    // MARK: - UI Setup

    private func setupUI() {
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        releaseDateLabel.textColor = .darkGray
        releaseDateLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)

        ratingLabel.textColor = .darkGray
        ratingLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)

        overviewLabel.textColor = .black
        overviewLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        watchTrailerButton.setTitle("Watch Trailer", for: .normal)
        watchTrailerButton.backgroundColor = UIColor.brown
        watchTrailerButton.setTitleColor(.white, for: .normal)
        watchTrailerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        watchTrailerButton.layer.cornerRadius = watchTrailerButton.frame.height / 2
        watchTrailerButton.layer.masksToBounds = true

    }

    // MARK: - Update UI with Fetched Data

    private func updateUI() {
        // Load movie poster using Kingfisher with placeholder and caching options
        if let posterURL = viewModel.movie?.posterURL {
            posterImageView.kf.setImage(
                with: posterURL,
                placeholder: UIImage(named: "placeholder"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ]
            )
        } else {
            posterImageView.image = UIImage(named: "placeholder")
        }

        // Update text labels with movie details
        titleLabel.text = viewModel.movie?.title
        releaseDateLabel.text = "Release Date: \(viewModel.movie?.releaseDate ?? "")"
        ratingLabel.text = "Rating: \(viewModel.movie?.voteAverage ?? 0)/10"
        overviewLabel.text = viewModel.movie?.overview
    }
}
