//
//  CountryDetailsViewController.swift
//  JsonApp
//
//  Created by Marcell Fulop on 5/1/25.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    var country: Country?
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryDetailsLabel: UILabel!
    @IBOutlet weak var countryFlagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        guard let _country = country else {
            print("No country value passed.")
            abort()
        }
        countryNameLabel.text = _country.name
        countryDetailsLabel.text = """
            Code: \(_country.code)
            Capital: \(_country.capital)
            Region: \(_country.region)
            Currency: \(_country.currency.name)
            \tSymbol: \(_country.currency.symbol ?? "No symbol")
            \tCode: \(_country.currency.code)
            Language: \(_country.language.name)
            \tCode: \(_country.language.code ?? "No code")
            """
        countryFlagLabel.text = _country.flag
        
    }
    

}
