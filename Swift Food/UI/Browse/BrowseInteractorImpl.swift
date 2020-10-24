//
//  BrowseInteractorImpl.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation
import Resolver
import RxSwift

class BrowseInteractorImpl: BrowseInteractor {
    private let apiClient: APIClient
    
    init(_ apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getCategories() -> Single<NetworkResult<FoodCategory>> {
        return apiClient.getFoodCategories()
            .map({ (items) -> NetworkResult<FoodCategory> in
                return NetworkResult(data: items)
            })
            .catchError { (error) -> Observable<NetworkResult<FoodCategory>> in
                return Observable.just(NetworkResult<FoodCategory>(error: error))
            }.asSingle()
    }
    
    func getFoodFor(_ category: FoodCategory) -> Single<NetworkResult<Food>> {
        return apiClient.getFood(category)
            .map({ (items) -> NetworkResult<Food> in
                return NetworkResult(data: items)
            })
            .catchError { (error) -> Observable<NetworkResult<Food>> in
                return Observable.just(NetworkResult<Food>(error: error))
            }.asSingle()
    }
}
