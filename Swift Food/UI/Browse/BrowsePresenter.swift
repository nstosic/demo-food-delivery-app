//
//  BrowsePresenter.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation

protocol BrowsePresenter: BasePresenter {
    func refreshCategories(onSuccess: @escaping ([FoodCategory]) -> Void, onFailure: @escaping (Error) -> Void)
    func refreshFood(_ category: FoodCategory, onSuccess: @escaping ([Food]) -> Void, onFailure: @escaping (Error) -> Void)
    func goToCartView()
}
