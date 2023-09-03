//
//  ProductCell.swift
//  Mvvm
//
//  Created by Adarsh Singh on 04/09/23.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet var productBgView: UIView!
    
    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var productTitleLbl: UILabel!
  
    @IBOutlet var productCategoryLabel: UILabel!
    
    @IBOutlet var rateBtn: UIButton!
    
    @IBOutlet var descriptionLbl: UILabel!
    
    @IBOutlet var priceLbl: UILabel!
    
    
    var product: Product?{
        didSet{ //property observer jaise hi kuch product mai change hoga did set call hojayega
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productBgView.clipsToBounds = false
        productBgView.layer.cornerRadius = 15
        
        imgView.layer.cornerRadius = 10
        
        self.productBgView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration(){
        
        productTitleLbl.text = product?.title
        productCategoryLabel.text = product?.category
        descriptionLbl.text = product?.description
        priceLbl.text = "₹\(product!.price)"
        rateBtn.setTitle("\(product!.rating.rate)", for: .normal)
        imgView.setImage(with: product!.image)
    }
    
}
