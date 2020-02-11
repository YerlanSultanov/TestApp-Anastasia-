//
//  DetailedTableVC.swift
//  TestApp(Anastasia)
//
//  Created by Ерлан Султанов on 2/10/20.
//  Copyright © 2020 Ерлан Султанов. All rights reserved.
//

import Foundation
import UIKit

class DetailedForecastVC: UIViewController {
    
    var cityName: String!
    let detailedForecastVM = DetailedForecastVM()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        detailedForecastVM.getForecastData(city: cityName, completion: tableView.reloadData)
        setupViews()
    }
    
    private func setupViews() {
        self.title = cityName
        tableView.tableFooterView = UIView()
    }
    
}

extension DetailedForecastVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailedForecastVM.forecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedForecastCell", for: indexPath) as! DetailedForecastCell
              let data = detailedForecastVM.forecastData[indexPath.row]
              cell.setupData(data: data)
              return cell
    }
}


