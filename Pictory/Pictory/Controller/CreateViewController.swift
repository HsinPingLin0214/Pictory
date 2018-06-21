//
//  CreateViewController.swift
//  Pictory
//
//  Created by Jenna on 2/5/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit
import Firebase
import JTAppleCalendar

class CreateViewController: UIViewController {
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var month: UILabel!
    
    var firstDate: Date?
    
    let outsideMonthColor = UIColor.lightGray
    let monthColor = UIColor.darkGray
    let selectedMonthColor = UIColor.white
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        calendarView.allowsMultipleSelection  = true
        calendarView.isRangeSelectionUsed = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else {return}
        /* // Selected one date
        if cellState.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
        ramdom selected */
        
        // Range select
        switch cellState.selectedPosition() {
        case .full, .left, .right:
            validCell.selectedView.isHidden = false
            validCell.selectedView.backgroundColor = UIColor.brown
        case .middle:
            validCell.selectedView.isHidden = false
            validCell.selectedView.backgroundColor = UIColor.lightGray
        default:
            validCell.selectedView.isHidden = true
            validCell.selectedView.backgroundColor = nil
        }
    }
    
    func handleCelltextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else {return}
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = selectedMonthColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = monthColor
            } else {
                validCell.dateLabel.textColor = outsideMonthColor
            }
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        self.dateFormatter.dateFormat = "MMMM yyyy"
        self.month.text = self.dateFormatter.string(from: date)
    }
}

extension CreateViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {

    // Tutorial 1 - set up calendar: https://www.youtube.com/watch?v=zOphH-h-qCs
    // Totorial 2 - customise calendar: https://www.youtube.com/watch?v=Qd_Gc67xzlw
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        
        let startDate = dateFormatter.date(from: "2018-06-01 00:00:00 +0000")!
        let endDate = dateFormatter.date(from: "2019-12-31 00:00:00 +0000")!
        
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
        handleCellSelected(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
        return cell
    }
    
    func sharedFunctionToConfigureCell(myCustomCell: CustomCell, cellState: CellState, date: Date) {
        myCustomCell.dateLabel.text = cellState.text
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if firstDate != nil {
            calendarView.selectDates(from: firstDate!, to: date,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
        } else {
            firstDate = date
        }
        handleCellSelected(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }
    
    // Deselect Date in range select
    // https://github.com/patchthecode/JTAppleCalendar/issues/244
    func calendar(_ calendar: JTAppleCalendarView, shouldDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        let selectedDates = calendar.selectedDates
        
        if selectedDates.contains(date) {
            // remove dates from the last selected.
            if (selectedDates.count > 2 && selectedDates.first != date && selectedDates.last != date) {
                let indexOfDate = selectedDates.index(of: date)
                let dateBeforeDeselectedDate = selectedDates[indexOfDate!]
                calendar.deselectAllDates()
                calendar.selectDates(
                    from: selectedDates.first!,
                    to: dateBeforeDeselectedDate,
                    triggerSelectionDelegate: true,
                    keepSelectionIfMultiSelectionAllowed: true)
                
                calendar.reloadData()
            }
        }
        return true
    }
//    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
//        let selectedDates = calendar.selectedDates
//
//        if selectedDates.contains(date) {
//            if (selectedDates.count == 2 && selectedDates.first != date && selectedDates.last != date) {
//
//                let indexOfDate = selectedDates.index(of: date)
//                let secondDate = selectedDates[indexOfDate!]
//                calendar.deselectAllDates()
//                calendar.selectDates(
//                    from: selectedDates.first!,
//                    to: secondDate,
//                    triggerSelectionDelegate: true,
//                    keepSelectionIfMultiSelectionAllowed: true)
//
//                calendar.reloadData()
//            }
//        }
//        return true
//    }
}
