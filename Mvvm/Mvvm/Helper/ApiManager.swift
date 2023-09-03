//
//  ApiManager.swift
//  Mvvm
//
//  Created by Adarsh Singh on 04/09/23.
//



import Foundation

enum DataError: Error{
    
    case invalidResponse
    case invalidURL
    case invalidDecoding
    case network(Error?)
}

typealias Handler = (Result<[Product], DataError>) -> Void
class ApiManager{
    
    
    static let shared = ApiManager()
    
    init(){}
    
    func fetchProducts(completion: @escaping Handler){
        guard let url = URL(string: Constant.API.productApi) else {
            return}
        //Background Task
        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else {return} OR NEECHE WAALA
            guard let data, error == nil else{
                completion(.failure(.invalidResponse))
                return
                
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return }
            
            // JSONDecoder() - Data ko model array mai convert karta hai
            do{
                let products = try JSONDecoder().decode([Product].self,
                from: data)
                completion(.success(products))
            }catch{
                completion(.failure(.network(error)))
            }
            
            
            
            
        }.resume()
    }
}



//singleton (s) : singleton class ka object create hoga outside of the class
