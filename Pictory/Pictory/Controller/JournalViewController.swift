//
//  JournalViewController.swift
//  Pictory
//
//  Created by Jenna on 2/5/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit
import Firebase
import JTAppleCalendar

class JournalViewController: UIViewController {
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var month: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCalendarView()
    }
    
    func setupCalendarView() {
        //Setup calendar spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.scrollsToTop = false
        
        //Setup labels
        calendarView.visibleDates {(visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func handleCelltextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else {return}
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = UIColor.white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = UIColor.darkGray
            } else {
                validCell.dateLabel.textColor = UIColor.lightGray
            }
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        self.dateFormatter.dateFormat = "MMMM yyyy"
        self.month.text = self.dateFormatter.string(from: date)
    }
}

extension JournalViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        
        let startDate = dateFormatter.date(from: "2018-06-01 00:00:00 +0000")!
        let endDate = dateFormatter.date(from: "2018-07-31 00:00:00 +0000")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! CustomCell
        sharedFunctionToConfigureCell(myCustomCell: cell, cellState: cellState, date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        sharedFunctionToConfigureCell(myCustomCell: cell, cellState: cellState, date: date)
        cell.dateLabel.text = cellState.text
//        handleCellSelected(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
        return cell
    }
    
    func sharedFunctionToConfigureCell(myCustomCell: CustomCell, cellState: CellState, date: Date) {
        myCustomCell.dateLabel.text = cellState.text
    }
}
