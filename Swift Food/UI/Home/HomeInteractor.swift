//
//  HomeInteractor.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation
import RxSwift

protocol HomeInteractor {
    func getOffers() -> Single<NetworkResult<FoodPromo>>
}
