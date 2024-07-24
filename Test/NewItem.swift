//
//  NewItem.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import SwiftUI

//view that add new user to database

struct NewItem: View {
    @StateObject var vm = ViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State var id: String
    @State var name: String
    @State var surname: String
    @State var date: String
    
    @State var bname: String
    @State var author: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 25.0) {
                Text("User")
                TextField("id", text: $id)
                TextField("name", text: $name)
                TextField("surname", text: $surname)
                TextField("date", text: $date)
            }.padding(.horizontal, 20)
            
            
//            VStack(alignment: .leading, spacing: 25.0) {
//                Text("Book")
//                TextField("nome", text: $bname)
//                TextField("author", text: $author)
//            }.padding(.horizontal, 20)
                .padding(.vertical, 50)
            
            Button{
                Task{
                    //function to update new user to database
                    await vm.addNewUser(user: User(id: id, name: name, surname: surname, date: date, email: "", phoneNumber: ""))
                    await vm.loadBookList()
                    await vm.loadUserList()
                }
                dismiss()
            }label: {
                Text("Create")
            }
        }
        
    }
}

#Preview {
    NewItem(id: "", name: "", surname: "", date: "", bname: "", author: "")
}
