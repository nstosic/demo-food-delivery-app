//
//  DependencyGraph.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 19/10/2020.
//

import Foundation
import Resolver

class DependencyInjection {
    static func setup() {
        
        // Networking
        Resolver.register { APIClientMock() as APIClient }
        
        // Home
        Resolver.register { HomeRouterImpl() as HomeRouter }
        Resolver.register { HomeInteractorImpl(Resolver.resolve()) as HomeInteractor }
        Resolver.register { HomePresenterImpl(Resolver.resolve(), Resolver.resolve()) as HomePresenter }
        
        // Browse
        Resolver.register { BrowseRouterImpl() as BrowseRouter }
        Resolver.register { BrowseInteractorImpl(Resolver.resolve()) as BrowseInteractor }
        Resolver.register { BrowsePresenterImpl(Resolver.resolve(), Resolver.resolve()) as BrowsePresenter }
        
        // Cart
        Resolver.register { CartRouterImpl() as CartRouter }
        Resolver.register { CartInteractorImpl(Resolver.resolve()) as CartInteractor }
        Resolver.register { CartPresenterImpl(Resolver.resolve(), Resolver.resolve()) as CartPresenter }
    }
}
