//
//  ViewModel.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import Foundation

// class used for utility function application-side
class ViewModel: ObservableObject {
    
    //instance of DBManager()
    let manager = DBManager()
    
    //array of user coming from database
    @Published var userList: [User] = []
    //array of book coming from database
    @Published var bookList: [Book] = []
    
    
    //function that load all the books from database
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
    //function that load all the user from database
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
    
    //function that add new user to database 
    func addNewUser(user: User) async{
        do {
            let newUser = try await manager.addUser(user: user)
            await MainActor.run {
                self.userList.append(newUser)
            }
        } catch {
            print(error)
        }
    }
    
    // function that delete user from database
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
