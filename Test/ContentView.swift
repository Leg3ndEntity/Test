//
//  ContentView.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    @State var open = false
    
    var body: some View {
        NavigationStack {
            List {
                //visualization of books in the view
                Section(header: Text("BOOKS")){
                    ForEach(vm.bookList) { book in
                        Text(book.name)
                    }
                }
                //visualization of user in the view
                Section(header: Text("USERS")){
                    ForEach(vm.userList) { user in
                        Text(user.name)
                        
                    }.onDelete(perform: { indexSet in
                        Task {
                            for index in indexSet {
                                //function to delete from view and database
                                await vm.deleteUser(index: index)
                            }
                        }
                    })
                }
            }
            .navigationTitle("List")
            .onAppear {
                Task {
                    //function to refresh the view for eventually database change
                    await vm.loadBookList()
                    await vm.loadUserList()
                }
            }
            .toolbar{
                ToolbarItem{
                    Button{
                        open.toggle()
                    }label: {
                        Image(systemName: "plus")
                    }
                }
            }
            Button{
                Task {
                    //function to refresh the view for eventually database change
                    await vm.loadBookList()
                    await vm.loadUserList()
                }
            }label: {
                Text("REFRESH")
            }
        }.sheet(isPresented: $open, content: {
            NewItem(id: "", name: "", surname: "", date: "", bname: "", author: "")
        })
    }
}

#Preview {
    ContentView()
}

