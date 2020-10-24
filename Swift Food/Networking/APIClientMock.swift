//
//  APIClientMock.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 23/10/2020.
//

import Foundation
import RxSwift

class APIClientMock: APIClient {
    
    fileprivate static let mockedFoodCategories = [
        FoodCategory(id: "1", name: "Pizza"),
        FoodCategory(id: "2", name: "Sushi"),
        FoodCategory(id: "3", name: "Drinks"),
    ]
    
    fileprivate static let mockedPizzaFood = [
        Food(photoURL: "https://cdn.donesi.rs/cdn-cgi/image/w=800,h=450,fit=cover,q=100,f=auto/restaurants/1838/banner_item/000000212378", name: "Capriciossa", description: "Staple pizza that everybody offers", portion: "32cm pizza", price: 4.0),
        Food(photoURL: "https://cdn.donesi.rs/cdn-cgi/image/w=800,h=450,fit=cover,q=100,f=auto/restaurants/1838/banner_item/000000212372", name: "Kiflizza", description: "Special made pizza that has home baked pastry instead of crust", portion: "34cm pizza", price: 10.0),
        Food(photoURL: "https://cdn.donesi.rs/cdn-cgi/image/w=800,h=450,fit=cover,q=100,f=auto/restaurants/1838/banner_item/000000212395", name: "Choco plazma pizza", description: "Sugar rush pizza filled with chocolate cream", portion: "24cm pizza", price: 9.0)
    ]
    
    fileprivate static let mockedSushiFood = [
        Food(photoURL: "https://cdn.donesi.rs/cdn-cgi/image/w=800,h=450,fit=cover,q=100,f=auto/restaurants/149/banner_item/000000206674", name: "Shrimps lover", description: "Variety of shrimp based sushi slices", portion: "16 slices", price: 32.0),
        Food(photoURL: "https://cdn.donesi.rs/cdn-cgi/image/w=800,h=450,fit=cover,q=100,f=auto/restaurants/149/banner_item/000000206675", name: "Tuna lover", description: "Variety of tuna based sushi slices", portion: "16 slices", price: 30.0)
    ]
    
    fileprivate static let mockedDrinksFood = [
        Food(photoURL: "https://cdn.donesi.rs/cdn-cgi/image/h=160,fit=cover,q=100,f=auto/global_assets/coca-cola-330ml", name: "Coca-Cola", description: "High sugary drink from WWI", portion: "0.33l can", price: 4.0),
        Food(photoURL: "https://cdn.donesi.rs/cdn-cgi/image/h=160,fit=cover,q=100,f=auto/global_assets/fanta-orange-500ml", name: "Fanta", description: "High sugary drink with citrus notes", portion: "0.5l bottle", price: 5.0),
        Food(photoURL: "https://cdn.donesi.rs/cdn-cgi/image/h=160,fit=cover,q=100,f=auto/global_assets/sprite-500ml", name: "Sprite", description: "The least popular high sugary drink", portion: "0.5l bottle", price: 3.5),
        Food(photoURL: "https://cdn.donesi.rs/cdn-cgi/image/h=160,fit=cover,q=100,f=auto/global_assets/schweppes-bitter-lemon-500ml", name: "Schweppes", description: "Bitter lemon with toxic additives", portion: "0.33l can", price: 5.0),
    ]
    
    fileprivate static let mockedPromotions = [
        FoodPromo(id: "1", restaurant: "Kazarov Delivery", title: "Saturday discount", subtitle: "Enjoy two pizzas for the price of one every Saturday"),
        FoodPromo(id: "2", restaurant: "Kazarov Delivery", title: "Tuesday discount", subtitle: "Buy two sushi sets and get free drinks"),
        FoodPromo(id: "3", restaurant: "Kazarov Delivery", title: "Monday discount", subtitle: "Buy pizza and sushi and get extra cookies"),
    ]
    
    func getFoodCategories() -> Observable<[FoodCategory]> {
        return Observable.just(APIClientMock.mockedFoodCategories)
    }
    
    func getFood(_ of: FoodCategory) -> Observable<[Food]> {
        if of.id == "1" {
            return Observable.just(APIClientMock.mockedPizzaFood)
        }
        if of.id == "2" {
            return Observable.just(APIClientMock.mockedSushiFood)
        }
        if of.id == "3" {
            return Observable.just(APIClientMock.mockedDrinksFood)
        }
        return Observable.empty()
    }
    
    func getOffers() -> Observable<[FoodPromo]> {
        return Observable.just(APIClientMock.mockedPromotions)
    }
}
