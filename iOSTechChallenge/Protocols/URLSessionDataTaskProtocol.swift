//
//  URLSessionDataTaskProtocol.swift
//  iOSTechChallenge
//
//  Created by Raphael Pedrini on 26/02/2021.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
