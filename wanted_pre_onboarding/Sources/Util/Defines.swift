//
//  Defines.swift
//  wanted_pre_onboarding
//
//  Created by 한경수 on 2022/09/12.
//

import Foundation

enum Region: String, CaseIterable {
  case gongju = "공주"
  case gwangju = "광주(전라남도)"
  case gumi = "구미"
  case gunsan = "군산"
  case daegu = "대구"
  case daejeon = "대전"
  case mokpo = "목포"
  case busan = "부산"
  case seosan = "서산"
  case seoul = "서울"
  case sokcho = "속초"
  case suwon = "수원"
  case suncheon = "순천"
  case ulsan = "울산"
  case iksan = "익산"
  case jeonju = "전주"
  case jeju = "제주시"
  case cheonan = "천안"
  case cheongju = "청주"
  case chuncheon = "춘천"
  
  
  // MARK: 위도
  var latitude: Double {
    switch self {
    case .gongju:
      return 36.44667
    case .gwangju:
      return 35.15972
    case .gumi:
      return 36.11944
    case .gunsan:
      return 35.96833
    case .daegu:
      return 35.87222
    case .daejeon:
      return 36.35111
    case .mokpo:
      return 34.81183
    case .busan:
      return 35.17944
    case .seosan:
      return 36.78500
    case .seoul:
      return 37.56667
    case .sokcho:
      return 38.20694
    case .suwon:
      return 37.26389
    case .suncheon:
      return 34.95583
    case .ulsan:
      return 35.53889
    case .iksan:
      return 35.95000
    case .jeonju:
      return 35.82500
    case .jeju:
      return 33.50000
    case .cheonan:
      return 36.81528
    case .cheongju:
      return 36.64389
    case .chuncheon:
      return 37.88131
    }
  }
  
  // MARK: 경도
  var longitude: Double {
    switch self {
    case .gongju:
      return 127.11972
    case .gwangju:
      return 126.85306
    case .gumi:
      return 128.34472
    case .gunsan:
      return 126.73722
    case .daegu:
      return 128.60250
    case .daejeon:
      return 127.38500
    case .mokpo:
      return 126.39216
    case .busan:
      return 129.07556
    case .seosan:
      return 126.45056
    case .seoul:
      return 126.97806
    case .sokcho:
      return 128.59194
    case .suwon:
      return 127.02861
    case .suncheon:
      return 127.49028
    case .ulsan:
      return 129.31667
    case .iksan:
      return 126.95833
    case .jeonju:
      return 127.15000
    case .jeju:
      return 126.51667
    case .cheonan:
      return 127.11389
    case .cheongju:
      return 127.48944
    case .chuncheon:
      return 127.72997
    }
  }
  
  // MARK: URL
  var url: URL? {
    var url = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
    url?.queryItems = [
      URLQueryItem(name: "lat", value: String(self.latitude)),
      URLQueryItem(name: "lon", value: String(self.longitude)),
      URLQueryItem(name: "appid", value: "1730e952e9eba3a8aae590f1332d6ef1"),
      URLQueryItem(name: "units", value: "metric"),
      URLQueryItem(name: "lang", value: "kr")
    ]
    return url?.url
  }
}
