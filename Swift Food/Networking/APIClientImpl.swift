//
//  APIClientImpl.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 19/10/2020.
//

import Foundation
import RxSwift

class APIClientImpl: APIClient {
    
    func getFoodCategories() -> Observable<[FoodCategory]> {
        return Observable.empty()
    }
    
    func getFood(_ of: FoodCategory) -> Observable<[Food]> {
        return Observable.empty()
    }
    
    func getOffers() -> Observable<[FoodPromo]> {
        return Observable.empty()
    }
}
