//
//  ViewModel.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import Foundation

class ViewModel: ObservableObject {
    
    let manager = DBManager()
    
    @Published var userList: [User] = []
    @Published var bookList: [Book] = []
    
    func loadBookList() async {
        do{
            let books = try await manager.fetchBooks()
            await MainActor.run {
                self.bookList = books
            }
        }catch{
            print(error)
        }
    }
    
    func loadUserList() async {
        do{
            let user = try await manager.fetchUsers()
            await MainActor.run {
                self.userList = user
            }
        }catch{
            print(error)
        }
    }
    
    func addNewTeam(user: User) async{
        do {
            let newUser = try await manager.addUser(user: user)
            await MainActor.run {
                self.userList.append(newUser)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteUser(index: Int) async{
        let userToDelete = userList[index]
        do {
            try await manager.deleteUser(user: userToDelete)
            await MainActor.run {
                self.userList.remove(at: index)
            }
        } catch {
            print(error)
        }
    }
    
}
