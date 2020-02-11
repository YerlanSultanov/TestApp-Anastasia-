//
//  WeatherTableVC.swift
//  TestApp(Anastasia)
//
//  Created by Ерлан Султанов on 2/10/20.
//  Copyright © 2020 Ерлан Султанов. All rights reserved.
//

import Foundation
import UIKit


class WeatherTableVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    let weatherTableVM = WeatherTableVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSettings()
    }
    
    
    private func viewSettings() {
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weatherTableVM.getRequaredCities()
    }
    
    
    @IBAction func addButtonTapped(sender: UIButton) {
        
        if (textField.text?.isEmpty)!  {
            
        } else {
            weatherTableVM.getCityWeatherData(city: textField.text!, completion: { message in
                self.tableView.reloadData()
                self.showAlert(message: message)
            })
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension WeatherTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherTableVM.database.objects(CityWeather.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        let data = weatherTableVM.database.objects(CityWeather.self)[indexPath.row]
        cell.setupData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
 
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let data = weatherTableVM.database.objects(CityWeather.self)[indexPath.row]
        let delete = UITableViewRowAction(style: .normal, title: "Delete", handler: { _,_  in
            self.weatherTableVM.deleteObject(object: data, completion: tableView.reloadData)
        })
        delete.backgroundColor = .red
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = weatherTableVM.database.objects(CityWeather.self)[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "DetailedTableVC") as! DetailedForecastVC
        vc.cityName = data.name
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
