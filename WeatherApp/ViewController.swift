//
//  ViewController.swift
//  WeatherApp
//
//  Created by Nikita Syrtsev on 01.11.2019.
//  Copyright © 2019 Nikita Syrtsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
    }
    
    lazy var weatherManager = APIWeatherManager(apiKey: "38ae1514c717cdd3967b88dfa0f6883e")
      let coordinates = Coordinates(latitude: 54.741704, longitude: 55.984471)
      
      override func viewDidLoad() {
        super.viewDidLoad()

        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
          switch result {
          case .Success(let currentWeather):
            self.updateUIWith(currentWeather: currentWeather)
          case .Failure(let error as NSError):
            
            let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
          default: break
          }
        }
      }
      
      func updateUIWith(currentWeather: CurrentWeather) {
        
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
        self.humidityLabel.text = currentWeather.humidityString
      }
    }
