//
//  MovieListViewModel.swift
//  MovieAppTest
//

import Foundation

class MovieListViewModel {
    var movieViewModels = Observable<[MovieInfo]>([])
    var isLoading = Observable<Bool>(false)

    func fetchMovies() {
        isLoading.value = true
        let webService = WebService()
        webService.fetchMovies { [weak self] movieViewModels in
            DispatchQueue.main.async {
                if let movieViewModels = movieViewModels {
                    self?.movieViewModels.value = movieViewModels
                }
                self?.isLoading.value = false
            }
        }
    }
}
