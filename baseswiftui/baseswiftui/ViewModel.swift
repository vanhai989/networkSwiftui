//
//  ViewModel.swift
//  baseswiftui
//
//  Created by Hai Dev on 02/10/2022.
//

import Foundation
import Combine
import Alamofire
class ViewModel: ObservableObject {
    
    @Published var chats =  [ChatModel]()
    @Published var message: String = ""
    @Published var chatListLoadingError: String = ""
    @Published var showAlert: Bool = false
    @Published var loginResponse: LoginModel?
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    init( dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
//        getChatList()
//        login()
    }
    
    func getChatList() {
        dataManager.fetchChats()?
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    print("response: \(String(describing: dataResponse.value))")
                    self.message = dataResponse.value!.message
                }
            }.store(in: &cancellableSet)
    }
    
    func login() {
        var parameters = Parameters()
        parameters = ["email":"test@example.com", "password": "123456Abc"]
        
        dataManager.login(parameters: parameters)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    print("response: \(String(describing: dataResponse.value))")
                    self.loginResponse = dataResponse.value
                }
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        chatListLoadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}
