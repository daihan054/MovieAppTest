//
//  MovieCellViewModel.swift
//  MovieAppTest
//
//  Created by REVE Systems on 22/11/23.
//

import Foundation

class MovieCellViewModel {
    let movie: MovieInfo

    init(movie: MovieInfo) {
        self.movie = movie
    }

    var title: String {
        return movie.originalTitle
    }

    var overview: String {
        return movie.overview
    }

    var posterURL: URL? {
        guard let posterPath = movie.posterPath else { return nil }
        return URL(string: Constants.imageBaseURL + posterPath)
    }
}
