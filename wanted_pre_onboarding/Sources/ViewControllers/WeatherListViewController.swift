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
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // MARK: Properties
  private var regions = Region.allCases
  private var weatherData = Dictionary<Region, Weather>()
  
  // MARK: View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    getCurrentWeathers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.navigationBar.isHidden = false
  }
  
  // MARK: API
  func getCurrentWeathers() {
    Task {
      DispatchQueue.main.async {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
      }
      for region in regions {
        do {
          guard let url = region.url else { return }
          let response: Weather = try await URLSession.shared.dataTaskDecoded(with: url)
          weatherData[region] = response
        } catch let error {
          debugPrint(error)
        }
      }
      DispatchQueue.main.async {
        self.collectionView.reloadData()
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
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
    
    collectionView.register(UINib(nibName: WeatherListCell.className, bundle: nil), forCellWithReuseIdentifier: WeatherListCell.className)
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
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let region = regions[indexPath.row]
    guard let weather = weatherData[region] else { return }
    let vc = WeatherDetailViewController.instantiate(region, weather)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
