//
//  HomePresenter.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation

protocol HomePresenter: BasePresenter {
    func loadOffers(onSuccess: @escaping ([FoodPromo]) -> Void, onFailure: @escaping (Error) -> Void)
    func addToCart(_ item: Food)
}
