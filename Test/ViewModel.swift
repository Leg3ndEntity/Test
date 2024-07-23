//
//  ViewModel.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import Foundation

class ViewModel: ObservableObject {
    
    let manager = DBManager()
    
    @Published var bookList: [Book] = []
    
    func loadBookList() async {
        do{
            bookList = try await manager.fetchData( path: "/User")
        }catch{
            print(error)
        }
    }
    
}
