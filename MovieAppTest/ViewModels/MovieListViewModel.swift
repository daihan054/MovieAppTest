//
//  MovieListViewModel.swift
//  MovieAppTest
//
//  Created by REVE Systems on 22/11/23.
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
