//
//  ProductListViewController.swift
//  Mvvm
//
//  Created by Adarsh Singh on 04/09/23.
//

import UIKit

class ProductListViewController: UIViewController {

    private var viewModel = ProductViewModel()
    
    @IBOutlet weak var productTabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        configuration()
    }
    
}

extension ProductListViewController{
    
    func configuration(){
        
        productTabelView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
    }
    
    func initViewModel(){
        viewModel.fetchProducts()
    }
    
    //Data Binding Event observe karega
    func observeEvent(){
        
        viewModel.eventHandler = { [weak self] event in
    // weak self use karte hai hum jab hume pata na ho ki event object may be nil hosakta hai aur nahi bhi
            guard let self else {return}
            
            switch event{
                
            case .loading:
                print("product loading...")
            case .stopLoading:
                print("stop loading")
            case .dataLoaded:
                print("Data Loaded")
               
                DispatchQueue.main.async {
                    self.productTabelView.reloadData()
                }
                
            case .error(let error):
                print(error)
                
            }
        }
    }
}




extension ProductListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell else{
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        
        return cell
    }
}
