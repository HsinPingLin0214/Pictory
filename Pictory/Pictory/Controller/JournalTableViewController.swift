//
//  JournalTableViewController.swift
//  Pictory
//
//  Created by Jenna on 2/5/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class JournalTableViewController: UITableViewController {
    
    // MARK: - Variables
    private let SECTION_NEWJOURNAL = 0
    private let SECTION_COUNT = 1
//    var DisplayName: String?
//    var ChannelTextField: UITextField?
    private var journals: [Journal] = []
    private var journalRef = Database.database().reference().child("journals")
    private var journalRefHandle: DatabaseHandle?
    private let dateFormatter = DateFormatter()
    private let dateShowFormatter = DateFormatter()
    
    // Tutorial: https://firebase.google.com/docs/database/ios/read-and-write?authuser=1
    // MARK: - Firebase Observation
    private func observeJournals()
    {
        journalRef.observe(.value, with: { snapshot in

            self.dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss Z"
            
            var newJournals: [Journal] = []
            
            print(snapshot)

            for child in snapshot.children {
                print(snapshot.children)
                if let snapshot = child as? DataSnapshot {
                    print(snapshot.key)
                    if let value = snapshot.value as? NSDictionary {
                        let name = value["name"] as! String
                        print(name)
                        
                        let startDate:Date = self.dateFormatter.date(from: (value["startDate"] as? String)!)!
                        
                        let endDate:Date = self.dateFormatter.date(from: (value["endDate"] as? String)!)!

                        let journal = Journal(name: name, startDate: startDate, endDate: endDate, images: [])
                        
                        print(journal)
                        newJournals.append(journal)
                        
                        print(newJournals)
                    }
                }
                // 4
//                if let snapshot = child as? DataSnapshot,
//                    let journal = Journal(name: snapshot.value(forKey: "name") as! String, startDate: snapshot.value(forKey: "startDate") as! Date, endDate: snapshot.value(forKey: "endDate") as! Date, images: []) as? Journal {
//                    newJournals.append(journal)
//                }
            }

            // 5
            self.journals = newJournals
            self.tableView.reloadData()
        })
        
    }
    
    // Journal sample
    private func firstjournal(){
        let journal1 = Journal(name: "Start your journal", startDate: Date(), endDate: Date(), images: [])
        
        let journal2 = Journal(name: "Second journal", startDate: Date(), endDate: Date(), images: [])
        
        let firstJournalRef = journalRef.child("journal001")
        let SecondJournalRef = journalRef.child("journal002")
        
        //(setValue:) Firebase can only store objects of type NSNumber, NSString, NSDictionary, and NSArray.
        firstJournalRef.setValue(journal1.getDictionary())
        SecondJournalRef.setValue(journal2.getDictionary())
        
//        print(journal.getDictionary())
//        let data  = try! JSONSerialization.data(withJSONObject: journal.getDictionary(), options: [])
//        print(String(data: data, encoding: .utf8)!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        firstjournal()
        observeJournals()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == SECTION_COUNT {
            return 1
        }else {
            return journals.count
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath)
//        var cellReuseIdentifier = "JournalCell"
        if indexPath.section == SECTION_NEWJOURNAL {
            //Configure the cell ...
            let journalCell = cell as? JournalTableViewCell
            
            journalCell?.nameLabel.text = journals[indexPath.row].name
            
            // Using
            // self.dateShowFormatter.dateFormat = "YYYY-MM-dd"
            // self.dateShowFormatter.dateFormat = "dd-MM-YYYY"
            // Using two labels to display startDate - endDate in storyboard
            journalCell?.timeLabel.text = journals[indexPath.row].startDate.description
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
