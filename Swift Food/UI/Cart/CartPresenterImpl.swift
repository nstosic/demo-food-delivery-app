//
//  CartPresenterImpl.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 24/10/2020.
//

import Foundation
import RxSwift

class CartPresenterImpl: CartPresenter {
    var dispoableBag: DisposeBag = DisposeBag()
    
    private let interactor: CartInteractor
    private let router: CartRouter
    
    init(_ interactor: CartInteractor, _ router: CartRouter) {
        self.interactor = interactor
        self.router = router
    }
}
