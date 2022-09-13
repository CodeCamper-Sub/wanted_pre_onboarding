//
//  WeatherDetailViewController.swift
//  wanted_pre_onboarding
//
//  Created by CodeCamper on 2022/09/13.
//

import Foundation
import UIKit

class WeatherDetailViewController: UIViewController {
  // MARK: Outlet UI
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var temperatureBoundLabel: UILabel!
  @IBOutlet weak var feltTemperatureLabel: UILabel!
  @IBOutlet weak var weatherIconImageView: UIImageView!
  @IBOutlet weak var weatherDescriptionLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var pressureLabel: UILabel!
  @IBOutlet weak var windSpeedLabel: UILabel!
  
  // MARK: Properties
  private var region: Region?
  private var weatherData: Weather?
  
  // MARK: Init
  static func instantiate(_ region: Region, _ weather: Weather) -> Self {
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Self.className) as! Self
    vc.region = region
    vc.weatherData = weather
    return vc
  }
  
  // MARK: View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    guard
      let region = region?.rawValue,
      let temp = weatherData?.main?.temp,
      let minTemp = weatherData?.main?.tempMin,
      let maxTemp = weatherData?.main?.tempMin,
      let feltTemp = weatherData?.main?.feelsLike,
      let icon = weatherData?.weather?[0].icon,
      let description = weatherData?.weather?[0].weatherDescription,
      let humidity = weatherData?.main?.humidity,
      let pressure = weatherData?.main?.pressure,
      let windSpeed = weatherData?.wind?.speed
    else { return }
    titleLabel.text = region
    temperatureLabel.text = "\(Int(temp))°C"
    temperatureBoundLabel.text = "\(Int(maxTemp))°C / \(Int(minTemp))°C"
    feltTemperatureLabel.text = "체감기온 \(Int(feltTemp))°C"
    weatherIconImageView.loadImage("https://openweathermap.org/img/wn/\(icon).png")
    weatherDescriptionLabel.text = description
    humidityLabel.text = "\(humidity)%"
    pressureLabel.text = "\(pressure)hPa"
    windSpeedLabel.text = "\(windSpeed)m/s"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.navigationBar.isHidden = false
  }
  
  // MARK: Outlet Action
  @IBAction func backButtonTapped(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
}
