//
//  TimelineDateInfoViewModel.swift
//  Timeline
//
//  Created by user on 2021/11/27.
//

import Foundation

enum PrintFormat {
    case day
    case week
    case month
    case year

    func toString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")

        switch self {
        case .day:
            dateFormatter.dateFormat = "yyyy-MM-dd"

            return dateFormatter.string(from: date)
        case .week:
            return "다음 주"
        case .month:
            dateFormatter.dateFormat = "MMMM"

            return dateFormatter.string(from: date)
        case .year:
            dateFormatter.dateFormat = "yyyy.MM.dd"

            return dateFormatter.string(from: date)
        }
    }
}

class TimelineDateInfoViewModel {
    let date: Date
    let dateInfo: String
    var format: PrintFormat = .day
    init(previousModel: TimelineLogModel, nextModel: TimelineLogModel) {
        date = nextModel.date

        if previousModel.date.weekday > nextModel.date.weekday {
            format = .week
        }
        else {
            let timeInterval = nextModel.date.timeIntervalSince(previousModel.date)
            if timeInterval.days >= 7 {
                format = .week
            }
        }

        if previousModel.date.month != nextModel.date.month {
            format = .month
        }

        if previousModel.date.year != nextModel.date.month {
            format = .year
        }

        dateInfo = format.toString(date: date)
    }

}

fileprivate extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    var month: Int {
         return Calendar.current.component(.month, from: self)
    }

    var weekday: Int {
         return Calendar.current.component(.weekday, from: self)
    }

    var day: Int {
         return Calendar.current.component(.day, from: self)
    }
}

fileprivate extension TimeInterval {
    var days: Int {
        return Int(self) / 86400
    }
}
