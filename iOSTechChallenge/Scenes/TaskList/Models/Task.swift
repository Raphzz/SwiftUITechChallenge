//
//  Task.swift
//  iOSTechChallenge
//
//  Created by Raphael Pedrini on 26/02/2021.
//

struct Task: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let type: String
}
