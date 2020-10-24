//
//  HomeInteractorImpl.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation
import RxSwift

class HomeInteractorImpl: HomeInteractor {
    let apiClient: APIClient
    
    init(_ apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getOffers() -> Single<NetworkResult<FoodPromo>> {
        self.apiClient.getOffers().map { (result) -> NetworkResult<FoodPromo> in
            return NetworkResult(data: result)
        }.catchError { (error) -> Observable<NetworkResult<FoodPromo>> in
            return Observable.just(NetworkResult.init(error: error))
        }.asSingle()
    }
}
