//
//  BrowsePresenterImpl.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation
import RxSwift

class BrowsePresenterImpl: BrowsePresenter {
    let dispoableBag: DisposeBag = DisposeBag()
    
    private let interactor: BrowseInteractor
    private let router: BrowseRouter
    
    init(_ interactor: BrowseInteractor, _ router: BrowseRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func refreshCategories(onSuccess: @escaping ([FoodCategory]) -> Void, onFailure: @escaping (Error) -> Void) {
        dispose(self.interactor.getCategories().subscribe(onSuccess: { (result) in
            if let data = result.data {
                onSuccess(data)
            } else {
                onFailure(result.error!)
            }
        }, onError: { (error) in
            onFailure(error)
        }))
    }
    
    func refreshFood(_ category: FoodCategory, onSuccess: @escaping ([Food]) -> Void, onFailure: @escaping (Error) -> Void) {
        dispose(self.interactor.getFoodFor(category).subscribe(onSuccess: { (result) in
            if let data = result.data {
                onSuccess(data)
            } else {
                onFailure(result.error!)
            }
        }, onError: { (error) in
            onFailure(error)
        }))
    }
    
    func goToCartView() {
        router.navigateToCartView()
    }
}
