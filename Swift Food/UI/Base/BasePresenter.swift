//
//  BasePresenter.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 19/10/2020.
//

import Foundation
import RxSwift

protocol BasePresenter: class {
    var dispoableBag: DisposeBag { get }
    
}

extension BasePresenter {
    func dispose(_ disposable: Disposable) {
        dispoableBag.insert(disposable)
    }
}
