//
//  MovieCell.swift
//  MovieAppTest
//
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverView: UITextView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var viewModel: MovieCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        movieTitle.text = viewModel?.title
        movieOverView.text = viewModel?.overview
        loadMoviePoster()
    }

    private func loadMoviePoster() {
        guard let posterURL = viewModel?.posterURL else { return }

        loader.startAnimating()
        let task = URLSession.shared.dataTask(with: posterURL) { [weak self] (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.moviePoster.image = image
                    self?.loader.stopAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self?.loader.stopAnimating()
                }
            }
        }
        task.resume()
    }
}

