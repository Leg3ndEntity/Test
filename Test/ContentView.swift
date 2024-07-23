//
//  ContentView.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(vm.bookList) { book in
                    Text(book.name)
                }
            }.navigationTitle("Book List")
                .onAppear{
                    Task {
                        await vm.loadBookList()
                    }
                }
        }
        
    }
}

#Preview {
    ContentView()
}
