//
//  URLSession+Extension.swift
//  wanted_pre_onboarding
//
//  Created by 한경수 on 2022/09/12.
//

import Foundation

enum HTTPError: Error {
  case unspecified
}

extension URLSession {
  func dataTaskDecoded<T: Decodable>(with url: URL) async throws -> T {
    try await withCheckedThrowingContinuation { continuation in
      URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
          continuation.resume(throwing: error)
          return
        }
        if let response = response as? HTTPURLResponse,
           !(200...299).contains(response.statusCode) {
          continuation.resume(throwing: HTTPError.unspecified)
          return
        }
        do {
          guard let data = data else { return }
          let decoder = JSONDecoder()
          let decoded = try decoder.decode(T.self, from: data)
          continuation.resume(returning: decoded)
        } catch let error {
          continuation.resume(throwing: error)
        }
      }.resume()
    }
  }
  
  func dataTask(with url: URL) async throws -> Data? {
    try await withCheckedThrowingContinuation { continuation in
      URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
          continuation.resume(throwing: error)
          return
        }
        if let response = response as? HTTPURLResponse,
           !(200...299).contains(response.statusCode) {
          continuation.resume(throwing: HTTPError.unspecified)
          return
        }
        continuation.resume(returning: data)
      }.resume()
    }
  }
}
