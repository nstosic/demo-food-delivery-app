//
//  BrowseInteractor.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation
import RxSwift

protocol BrowseInteractor {
    func getCategories() -> Single<NetworkResult<FoodCategory>>
    func getFoodFor(_ category: FoodCategory) -> Single<NetworkResult<Food>>
}
