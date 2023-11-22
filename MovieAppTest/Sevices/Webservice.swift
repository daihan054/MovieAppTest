//
//  Webservice.swift
//  MovieAppTest
//
//

import Foundation

class WebService {
    
    func fetchMovies(completion: @escaping ([MovieInfo]?) -> Void) {
        let query = "marvel"
        
        let apiUrl = "\(Constants.baseURL)\(Constants.Endpoints.searchMovie)?api_key=\(Constants.apiKey)&query=\(query)"
        
        if let url = URL(string: apiUrl) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print("Error fetching data: \(error)")
                    completion(nil)
                    return
                }
                
                if let data = data {
                    do {
                        
                        let decoder = JSONDecoder()
                        let movieData = try decoder.decode(MovieData.self, from: data)
                        
                        let movies = movieData.results
                        let movieViewModels = movies.map { movie in
                            return MovieInfo(posterPath: movie.posterPath ?? "",
                                                  originalTitle: movie.originalTitle,
                                                  overview: movie.overview)
                        }
                        
                        completion(movieViewModels)
                        
                    } catch {
                        print("Error decoding JSON: \(error)")
                        completion(nil)
                    }
                }
                
            }.resume()
            
        }
    }
}
