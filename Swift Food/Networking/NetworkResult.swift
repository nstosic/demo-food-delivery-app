//
//  NetworkResult.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 23/10/2020.
//

import Foundation

class NetworkResult<T : BaseEntity> {
    let data: [T]?
    let error: Error?
    
    private init(_ data: [T]?, _ error: Error?) {
        assert((data == nil) != (error == nil))
        self.data = data
        self.error = error
    }
    
    convenience init(data: [T]) {
        self.init(data, nil)
    }
    
    convenience init(error: Error) {
        self.init(nil, error)
    }
}
