//
//  APIClient.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 19/10/2020.
//

import Foundation
import RxSwift

protocol APIClient: class {
    func getFoodCategories() -> Observable<[FoodCategory]>
    func getFood(_ of: FoodCategory) -> Observable<[Food]>
    func getOffers() -> Observable<[FoodPromo]>
}
