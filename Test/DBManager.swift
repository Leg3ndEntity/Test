//
//  DBManager.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import Foundation

struct DBManager {
    private let baseUrl = URL(string: "https://napoli-2.fm-testing.com/fmi/odata/v4/Test")
    private let username = "admin"
    private let password = "lulu11"
    
    private var basicAuthorizationHeader: String {
        let auth = "\(username):\(password)".data(using: .utf8)?.base64EncodedString() ?? ""
        return "Basic \(auth)"
    }
    
    func fetchBooks() async throws -> [Book] {
        guard let url = baseUrl?.appendingPathComponent("Book") else {
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
    
    func fetchUsers() async throws -> [User] {
        guard let url = baseUrl?.appendingPathComponent("User") else {
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
        let decodedData = try JSONDecoder().decode(FileMakerODataResponse<[User]>.self, from: data)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let jsonData = try jsonEncoder.encode(decodedData.value)
        
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON data:\(jsonString)")
        }
        
        return decodedData.value
    }
    
    func addUser(user: User) async throws -> User {
        guard let url = baseUrl?.appending(path: "User") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(basicAuthorizationHeader, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newUser = ["idCode": user.id, "name": user.name, "surname": user.surname, "dateOfBirth": user.date, "mail": "s.msiio@032hds.com", "phoneNumber": "2345672345"]
        request.httpBody = try JSONEncoder().encode(newUser)
        
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
    
    func deleteUser(user: User) async throws {
        guard let baseUrl = baseUrl else {
            throw URLError(.badURL)
        }
        
        let urlString = "User('\(user.id)')"
        let url = baseUrl.appendingPathComponent(urlString)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue(basicAuthorizationHeader, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = nil
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            if httpResponse.statusCode / 100 != 2 {
                let errorMessage = "Server error with status code: \(httpResponse.statusCode)"
                print(errorMessage)
                throw URLError(.badServerResponse)
            }
        } catch {
            print("Error deleting user: \(error)")
            throw error
        }
    }


    
}
