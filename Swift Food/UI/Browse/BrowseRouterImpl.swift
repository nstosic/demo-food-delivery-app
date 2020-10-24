//
//  BrowseRouterImpl.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation
import UIKit

class BrowseRouterImpl: BrowseRouter {
    
    func navigateToCartView() {
        guard let navigationController = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as? UINavigationController else { return }
        navigationController.pushViewController(CartView(), animated: true)
    }
}
