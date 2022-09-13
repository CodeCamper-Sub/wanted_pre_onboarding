//
//  WeatherListCell.swift
//  wanted_pre_onboarding
//
//  Created by 한경수 on 2022/09/12.
//

import Foundation
import UIKit

class WeatherListCell: UICollectionViewCell {
  // MARK: Outlet UI
  @IBOutlet weak var regionLabel: UILabel!
  @IBOutlet weak var weatherImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  
  override func awakeFromNib() {
    self.contentView.layer.cornerRadius = 12
  }
  
  func setCell(_ region: Region, _ data: Weather) {
    guard
      let icon = data.weather?[0].icon,
      let temp = data.main?.temp,
      let humidity = data.main?.humidity
    else { return }
          
    regionLabel.text = region.rawValue
    weatherImageView.loadImage("https://openweathermap.org/img/wn/\(icon).png")
    temperatureLabel.text = "\(round(temp))°C"
    humidityLabel.text = "\(humidity)%"
  }
}
