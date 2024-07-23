//
//  DBManager.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import Foundation

struct DBManager {
    private let baseUrl = URL(string: "https://napoli-2.fm-testing.com/fmi/odata/v4/Test")
    private let baseUrl1 = "https://napoli-2.fm-testing.com/fmi/odata/v4/Test"
    private let username = "Admin"
    private let password = "lulu11"

    private var basicAuthorizationHeader: String {
        let auth = "\(username):\(password)".data(using: .utf8)?.base64EncodedString() ?? ""
        return "Basic \(auth)"
    }
    
    func fetchData<T: Decodable>(path: String) async throws -> [T] {
        let urlString = baseUrl1 + path
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.setValue(basicAuthorizationHeader, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        print(request)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(FileMakerODataResponse<[T]>.self, from: data)
            
            return response.value
        } catch {
            print("pizdec")
            throw error
        }
    }

    func fetchBooks() async throws -> [Book] {
        guard let url = baseUrl?.appending(path: "Test") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.setValue(basicAuthorizationHeader, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode / 100 == 2
        else {
            throw URLError(.badServerResponse)
        }
        let decodedData = try JSONDecoder().decode(FileMakerODataResponse<[Book]>.self, from: data)
        return decodedData.value
    }
    
    func addUser(name: String) async throws -> User {
        guard let url = baseUrl?.appending(path: "Teams") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(basicAuthorizationHeader, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newTeam = ["name": name]
        request.httpBody = try JSONEncoder().encode(newTeam)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode / 100 == 2
        else {
            throw URLError(.badServerResponse)
        }
        let decodedData = try JSONDecoder().decode(User.self, from: data)
        return decodedData
    }

    
    
}
