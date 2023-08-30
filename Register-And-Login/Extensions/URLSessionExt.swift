//
//  URLSessionExt.swift
//  Register-And-Login
//
//  Created by Saim on 29/08/2023.
//

import Foundation

extension URLSession {
    func fetchData<T: Decodable>(at url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let toDos = try JSONDecoder().decode([T].self, from: data)
          completion(.success(toDos))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}
