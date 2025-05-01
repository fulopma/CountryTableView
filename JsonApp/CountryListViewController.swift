//
//  ViewController.swift
//  JsonApp
//
//  Created by Marcell Fulop on 4/25/25.
//

import Foundation
import UIKit

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

/// When conforming multiple protocols, try to conform one protocol at a time inside a separate a extension
class CountryListViewController: UIViewController, UITableViewDataSource {
    var countries: [Country] = []

    @IBOutlet weak var countryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callApiForCountries()
        
        countryTableView.dataSource = self
        countryTableView.delegate = self
    }

    func callApiForCountries() {
        guard let url = URL(string: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json") else {
            print("Failed to parse URL.")
            abort()
        }
        let session = URLSession.shared
        let datatask = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                self.countries = try jsonDecoder.decode([Country].self, from: data)
                DispatchQueue.main.async {
                    self.countries.sort(by: { $0.name < $1.name } )
                    self.countryTableView.reloadData()
                }
            }catch {
                print("\(error)")
                abort()
            }
        }
        datatask.resume()
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
        return cell ?? UITableViewCell()
    }

}

extension CountryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "CountryDetailsViewController")
                as? CountryDetailsViewController else{
            return
        }
        vc.country = countries[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
