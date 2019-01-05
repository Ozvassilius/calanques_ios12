//
//  TableViewIntegreeController.swift
//  Les Calanques
//
//  Created by Macinstosh on 05/01/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class TableViewIntegreeController: UITableViewController {
    
    var Calanques : [Calanque] = []
    var cellID = "CalanqueCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        Calanques = CalanqueCollection().all()
       // tableView.backgroundColor = UIColor.clear
        let bg = UIImageView(frame: view.bounds)
        bg.image = Calanques[0].image
        bg.contentMode = .scaleAspectFill
        tableView.backgroundView = bg
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Calanques.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? CalanqueCell {
            cell.setupCell(calanque: Calanques[indexPath.row])
            
            return cell
        } else {
         // Configure the cell... (cell par defaut)
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let calanque = Calanques[indexPath.row]
        cell.textLabel?.text = calanque.nom
        cell.imageView?.image = calanque.image

        return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
