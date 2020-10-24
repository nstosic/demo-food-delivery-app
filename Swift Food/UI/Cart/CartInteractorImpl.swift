//
//  CartInteractorImpl.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 24/10/2020.
//

import Foundation

class CartInteractorImpl: CartInteractor {
    let apiClient: APIClient
    
    init(_ apiClient: APIClient) {
        self.apiClient = apiClient
    }
}
