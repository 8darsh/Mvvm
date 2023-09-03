//
//  ProductViewModel.swift
//  Mvvm
//
//  Created by Adarsh Singh on 04/09/23.
//

import Foundation

final class ProductViewModel{
    
    var products:[Product] = []
    
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding closure
    
    func fetchProducts(){
        self.eventHandler?(.loading)
        ApiManager.shared.fetchProducts { response in
            
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}
extension ProductViewModel{
    enum Event{
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
