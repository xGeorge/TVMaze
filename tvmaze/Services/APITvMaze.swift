//
//  APITvMaze.swift
//  tvmaze
//
//  Created by Jorge Armando Torres Perez on 17/01/21.
//

import Foundation

class APITvMaze {
    let defaultSession = URLSession(configuration: .default)
    let queue = DispatchQueue.global(qos: .userInitiated)
    var dataTask: URLSessionDataTask?

    func getSchedules(completion: @escaping (Schedules?, Error?) -> Void) {
        dataTask?.cancel()
        queue.async {
            if let urlComponents = URLComponents(string: "http://api.tvmaze.com/schedule") {
        //          urlComponents.query = "country=US&date=2021-02-01"
                guard let url = urlComponents.url else {
                    completion(nil, nil)
                    return
                }
                self.dataTask = self.defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    defer {
                        self?.dataTask = nil
                    }
                    if let error = error {
                        completion(nil, error)
                    }
                    else if let data = data,
                           let response = response as? HTTPURLResponse,
                           response.statusCode == 200 {
                            let decoder = JSONDecoder()
                            let schedules: Schedules? = try? decoder.decode(Schedules.self, from: data)
                            DispatchQueue.main.async {
                                completion(schedules, nil)
                            }
                    }
              }
                self.dataTask?.resume()
            }
        }
    }
}

