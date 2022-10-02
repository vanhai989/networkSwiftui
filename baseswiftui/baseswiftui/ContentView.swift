//
//  ContentView.swift
//  baseswiftui
//
//  Created by Hai Dev on 02/10/2022.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
//        ScrollView {
//            LazyVStack {
//                ForEach(viewModel.chats, id: \.id) { chat in
//                    HStack {
//
//                        // you can show image here by importing SDWebImageSwiftUI
//                        VStack(alignment: .leading) {
//                            Text(chat.chatName)
//                                .foregroundColor(.white)
//                                .font(.custom("Avenir", size: 16))
//                                .fontWeight(.heavy)
//
//                            if chat.message != nil {
//                                HStack {
//                                    Text(chat.message!.content)
//                                        .foregroundColor(.white)
//                                        .font(.custom("Avenir", size: 14))
//                                        .lineLimit(1)
//
//                                    Text(chat.message!.created_at)
//                                        .foregroundColor(.white)
//                                        .font(.custom("Avenir", size: 14))
//                                }
//
//                            }
//
//                        }.padding(.horizontal)
//
//                        Spacer()
//
//                        if !chat.read {
//                            Circle()
//                                .fill(Color(UIColor(red: 0/255, green: 148/255, blue: 255/255, alpha: 1)))
//                                .frame(width: 14, height: 14)
//                        }
//
//                    }.padding(.vertical, 8)
//                    .padding(.horizontal)
//                    .background(!chat.read ? Color(UIColor(red: 83/255, green: 90/255, blue: 97/255, alpha: 1)) : Color.clear)
//                }
//            }
//        }.alert(isPresented: $viewModel.showAlert) {
//            Alert(title: Text("Error"), message: Text (viewModel.chatListLoadingError ), dismissButton: .default(Text("OK")))
//        }
        VStack {
            TextField("email", text: $email)
            TextField("password", text: $password)
            Button {
                print("pressed")
            } label: {
                Text("Login")
            }

        }.onAppear {
            viewModel.getChatList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
