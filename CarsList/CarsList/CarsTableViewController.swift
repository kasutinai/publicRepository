//
//  CarsTableViewController.swift
//  CarsList
//
//  Created by Андрей Касутин on 19/05/2019.
//  Copyright © 2019 Андрей Касутин. All rights reserved.
//

import UIKit
import CoreData

class CarsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var carsTable: [Cars] = []
    let segueIdentifier = "carsToCar"
    
    @IBAction func AddCar(_ sender: Any) {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    var fetchedResultsController:NSFetchedResultsController <Cars> = {
        let fetchRequest: NSFetchRequest<Cars> = Cars.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "model", ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            if let fetchedObjects = fetchedResultsController.fetchedObjects{
                carsTable = fetchedObjects
                /*for car in carsTable {
                    print("Model - \(car.model!), klass - \(car.klass!), producer - \(car.producer!), type - \(car.type!), year - \(car.year)")
                }*/
            }
        } catch {
            print(error)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return carsTable.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let car = carsTable[indexPath.row]
        cell.textLabel?.text = "\(car.model!), \(car.klass!), \(car.producer!), \(car.type!), \(car.year)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = carsTable[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: car)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResultsController.object(at: indexPath) as NSManagedObject
            AppDelegate.instance.persistentContainer.viewContext.delete(managedObject)
            AppDelegate.instance.saveContext()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let controller = segue.destination as! CarViewController
            controller.car = sender as? Cars
        }
    }
    
    // MARK: - Fetched Results Controller Delegate
    
    func controllerWillChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type:
        NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            } default:
                tableView.reloadData()
        }
        if let fetchedObjects = controller.fetchedObjects {
            carsTable = fetchedObjects as! [Cars]
        } }
    func controllerDidChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
