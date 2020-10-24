//
//  HomePresenterImpl.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation
import RxSwift

class HomePresenterImpl: HomePresenter {
    let dispoableBag: DisposeBag = DisposeBag()
    
    private let interactor: HomeInteractor
    private let router: HomeRouter
    
    init(_ interactor: HomeInteractor, _ router: HomeRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func loadOffers(onSuccess: @escaping ([FoodPromo]) -> Void, onFailure: @escaping (Error) -> Void) {
        dispose(self.interactor.getOffers().subscribe(onSuccess: { result in
            if let data = result.data {
                onSuccess(data)
            } else {
                onFailure(result.error!)
            }
        }, onError: { error in
            onFailure(error)
        }))
    }
    
    func addToCart(_ item: Food) {
        Cart.sharedInstance.addToCart(item)
    }
}
