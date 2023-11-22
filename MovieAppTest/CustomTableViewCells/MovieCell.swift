//
//  MovieCell.swift
//  MovieAppTest
//
//  Created by REVE Systems on 22/11/23.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverView: UITextView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadMoviePoster(with movieViewModel: MovieViewModel) {
        if let posterPath = movieViewModel.posterPath {
            if let posterURL = URL(string: Constants.imageBaseURL + posterPath) {
                loader.startAnimating()
                let task = URLSession.shared.dataTask(with: posterURL) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.moviePoster.image = image
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.loader.stopAnimating()
                    }
                }
                task.resume()
            }
        }
    }
    
    func configure(with movieViewModel: MovieViewModel) {
        movieTitle.text = movieViewModel.originalTitle
        movieOverView.text = movieViewModel.overview
    }
}

