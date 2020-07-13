//
//  HolidayRequest.swift
//  HolidayCalendar
//
//  Created by User on 6/22/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import Foundation

enum HolidayError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequest {
    let resourceURL: URL
    let apikey = "96dc8e4efd1c974271e64da02bea3451720031da"
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(apikey)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else{fatalError()}
        self.resourceURL = resourceURL
    }
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void)  {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.canNotProcessData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }

        }
        dataTask.resume()
    }
    
}
