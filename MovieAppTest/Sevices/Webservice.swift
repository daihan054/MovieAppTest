//
//  Webservice.swift
//  MovieAppTest
//
//  Created by REVE Systems on 22/11/23.
//

import Foundation

class WebService {
    
    func fetchMovies(completion: @escaping ([MovieViewModel]?) -> Void) {
        let query = "marvel"
        
        let apiUrl = "\(Constants.baseURL)\(Constants.Endpoints.searchMovie)?api_key=\(Constants.apiKey)&query=\(query)"
        
        if let url = URL(string: apiUrl) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print("Error fetching data: \(error)")
                    completion(nil)
                    return
                }
                
                // Check if data is available
                if let data = data {
                    do {
                        // Decode the JSON data using JSONDecoder and MovieData model
                        let decoder = JSONDecoder()
                        let movieData = try decoder.decode(MovieData.self, from: data)
                        
                        // Extract and create an array of MovieViewModels
                        let movies = movieData.results
                        let movieViewModels = movies.map { movie in
                            return MovieViewModel(posterPath: movie.posterPath ?? "",
                                                  originalTitle: movie.originalTitle,
                                                  overview: movie.overview)
                        }
                        
                        // Call the completion handler with the array of MovieViewModels
                        completion(movieViewModels)
                        
                    } catch {
                        print("Error decoding JSON: \(error)")
                        completion(nil)
                    }
                }
                
            }.resume() // Start the URLSession task
            
        }
    }
}
