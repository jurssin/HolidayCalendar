//
//  Holiday.swift
//  HolidayCalendar
//
//  Created by User on 6/22/20.
//  Copyright © 2020 Syrym Zhursin. All rights reserved.
//

import Foundation

struct HolidayResponse : Decodable {
    var response: Holidays
}

struct Holidays : Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail : Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo : Decodable {
    var iso: String
}
