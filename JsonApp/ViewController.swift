//
//  ViewController.swift
//  JsonApp
//
//  Created by Marcell Fulop on 4/25/25.
//

import Foundation
import UIKit

// 1. understand above JSON data
// 2. create model from above Json data
// 3.  store json data locally in .json file
// 4. read the local json file and parese json data using JSONDecoder
// 5. populate read countries data into table view.

struct Country: Decodable {
    let capital: String
    let code: String
    let currency: Currency
    let flag: String
    let language: Language
    let name: String
    let region: String
}

struct Currency: Decodable {
    let code: String
    let name: String
    let symbol: String?
}

struct Language: Decodable {
    let code: String?
    let name: String
}

class ViewController: UIViewController, UITableViewDataSource {
    var countries: [Country] = []

    @IBOutlet weak var countryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries = readCountriesJson()
        countryTableView.dataSource = self
    }

    /// Read the contents of a `countries.json` file. If there is any failure, this function will fail and take
    /// the app with it.
    func readCountriesJson() -> [Country] {
        guard
            let url = Bundle.main.url(
                forResource: "countries",
                withExtension: "json"
            )
        else {
            print("File not found")
            abort()
        }

        guard let data = try? Data(contentsOf: url) else {
            print("Cannot read file")
            abort()
        }
        let jsonDecorder = JSONDecoder()
        do {
            let countries = try jsonDecorder.decode([Country].self, from: data)
            return countries
        } catch {
            print("Error parsing json: \(error)")
            abort()
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "countryCell",
                for: indexPath
            ) as? CountryViewCell
        cell?.countryCapitalLabel.text = countries[indexPath.row].capital
        cell?.countryNameLabel.text = countries[indexPath.row].name
        cell?.countryCodeLabel.text = countries[indexPath.row].code
        cell?.countryFlagLabel.text = countries[indexPath.row].flag
        cell?.countryRegionLabel.text = countries[indexPath.row].region
        cell?.languageNameLabel.text = countries[indexPath.row].language.name
        cell?.languageCodeLabel.text =
            countries[indexPath.row].language.code ?? "N/A"
        cell?.currencyNameLabel.text = countries[indexPath.row].currency.name
        cell?.currencyCodeLabel.text = countries[indexPath.row].currency.code
        cell?.currencySymbolLabel.text =
            countries[indexPath.row].currency.symbol ?? "N/A"
        return cell ?? UITableViewCell()
    }

}
