//
//  Cart.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 24/10/2020.
//

import Foundation

class Cart {
    static let sharedInstance = Cart()
    
    private var items: [Food]
    private var listeners: [(Cart) -> Void]
    var count: Int {
        return items.count
    }
    
    private init() {
        self.items = [Food]()
        self.listeners = [(Cart) -> Void]()
    }
    
    func addToCart(_ food: Food) {
        self.items.append(food)
        for listener in listeners {
            listener(self)
        }
    }
    
    func removeFromCart(_ index: Int) {
        self.items.remove(at: index)
        for listener in listeners {
            listener(self)
        }
    }
    
    func totalPrice() -> Double {
        var total = 0.0
        for item in items {
            total = total + item.price
        }
        return total
    }
    
    func getItem(_ index: Int) -> Food {
        return items[index]
    }
    
    func addListener(_ listener: @escaping (Cart) -> Void) {
        self.listeners.append(listener)
    }
    
    func removeListeners() {
        self.listeners.removeAll()
    }
}
