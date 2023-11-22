//
//  ViewController.swift
//  MovieAppTest
//
//  Created by REVE Systems on 22/11/23.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var movieViewModels: [MovieViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let webService = WebService()
        loader.startAnimating()
        webService.fetchMovies { [weak self] movieViewModels in
            if let movieViewModels = movieViewModels {
                self?.movieViewModels = movieViewModels
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            DispatchQueue.main.async {
                self?.loader.stopAnimating()
            }
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movieViewModel = movieViewModels[indexPath.row]
        
        cell.configure(with: movieViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let movieViewModel = movieViewModels[indexPath.row]
        let newCell = (cell as! MovieCell)
        newCell.loadMoviePoster(with: movieViewModel)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

