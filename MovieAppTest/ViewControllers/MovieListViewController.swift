//
//  ViewController.swift
//  MovieAppTest
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    var movieListViewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        movieListViewModel.fetchMovies()
        
        movieListViewModel.isLoading.bind { [weak self] isLoading in
            DispatchQueue.main.async {
                isLoading == true ? self?.loader.startAnimating() : self?.loader.stopAnimating()
            }
        }

        movieListViewModel.movieViewModels.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewModel.movieViewModels.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell,
              let movie = movieListViewModel.movieViewModels.value?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cellViewModel = MovieCellViewModel(movie: movie)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

