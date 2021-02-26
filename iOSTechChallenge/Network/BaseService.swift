//
//  BaseService.swift
//  iOSTechChallenge
//
//  Created by Raphael Pedrini on 26/02/2021.
//

import Foundation

enum ServiceFetchError: Error {
    case invalidJSON
    case decodingError
    case invalidURL
    case networkFailed
    case limit
}

class BaseService {

    var session: URLSessionProtocol
    private var task: URLSessionDataTaskProtocol?
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    internal func url(withPath path: String) -> URL? {
        return URL(string: APIConstants.base + path)
    }
    
    typealias ResultBlock<T> = (Result <T, Error>) -> Void
    
    /**
    * Use to call Api with given response data type
    * Need to pass url
    - Parameter url: Url of event which will extened with page
    */
    func fetch<T: Decodable>(listOf representable: T.Type,
                                                     withURL url: URL?,
                                                     completionHandler: @escaping (Result<T, ServiceFetchError>) -> Void) {
        
        guard let url = url else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        task = session.data(with: url) { (data, _, error) -> Void in
            
            guard error == nil else {
                completionHandler(.failure(.networkFailed))
                return
            }
            guard let jsonData = data else {
                completionHandler(.failure(.invalidJSON))
                return
            }
            
            /// `Decode` Json
            let json = JSONDecoder()
            do {
                let decodedData: T = try json.decode(T.self, from: jsonData)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(.decodingError))
            }
            
        }
        
        task?.resume()
    }
    internal func cancel() {
        task?.cancel()
    }
}
