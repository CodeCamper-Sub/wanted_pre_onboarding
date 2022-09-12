//
//  ViewController.swift
//  wanted_pre_onboarding
//
//  Created by 한경수 on 2022/09/12.
//

import UIKit

class WeatherListViewController: UIViewController {
  // MARK: Outlet UI
  @IBOutlet weak var collectionView: UICollectionView!
  
  // MARK: Properties
  var regions = Region.allCases
  var weatherData = Dictionary<Region, Weather>()
  
  // MARK: View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(UINib(nibName: WeatherListCell.className, bundle: nil), forCellWithReuseIdentifier: WeatherListCell.className)
    configureCollectionView()
    getCurrentWeathers()
  }
  
  // MARK: API
  func getCurrentWeathers() {
    Task {
      for region in regions {
        do {
          guard let url = region.url else { return }
          let response: Weather = try await URLSession.shared.dataTask(with: url)
          weatherData[region] = response
        } catch let error {
          debugPrint(error)
        }
      }
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  // MARK: Configure UI
  func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    let width: CGFloat = UIScreen.main.bounds.width - 32
    let height: CGFloat = 72
    layout.itemSize = CGSize(width: width, height: height)
    layout.minimumLineSpacing = 8
    collectionView.collectionViewLayout = layout
  }
}

extension WeatherListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return weatherData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let region = regions[indexPath.row]
    guard
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherListCell.className, for: indexPath) as? WeatherListCell,
      let data = weatherData[region]
    else { return UICollectionViewCell() }
    cell.setCell(region, data)
    return cell
  }
}

extension WeatherListViewController: UICollectionViewDelegate {
  
}
