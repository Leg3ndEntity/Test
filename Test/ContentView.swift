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
                Section(header: Text("BOOKS")){
                    ForEach(vm.bookList) { book in
                        Text(book.name!)
                    }
                }
                Section(header: Text("USERS")){
                    ForEach(vm.userList) { user in
                        Text(user.name ?? "pollo")
                    }.onDelete(perform: { indexSet in
                        Task {
                            for index in indexSet {
                                await vm.deleteUser(index: index)
                            }
                        }
                    })
                }
            }
            .navigationTitle("List")
            .onAppear {
                Task {
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
        }.sheet(isPresented: $open, content: {
            NewItem(id: "", name: "", surname: "", date: "", bname: "", author: "")
        })
    }
}

#Preview {
    ContentView()
}

