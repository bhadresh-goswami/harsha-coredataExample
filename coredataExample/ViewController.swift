//
//  ViewController.swift
//  coredataExample
//
//  Created by Mac on 18/02/19.
//  Copyright © 2019 bhadresh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableInfo: UITableView!
    @IBOutlet weak var txtId: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtCourse: UITextField!
    
    
    var managedObj:NSManagedObject!
    var manageContext:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        ReadData()
        
    }

    @IBAction func TapToSaveData(_ sender: UIBarButtonItem) {
    
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: self.manageContext)
        
        self.managedObj = NSManagedObject(entity: entity!, insertInto: self.manageContext)
        
        self.managedObj.setValue(Int16(txtId.text!)!, forKey: "id")
        self.managedObj.setValue(txtName.text!, forKey: "name")
        self.managedObj.setValue(txtCourse.text!, forKey: "course")
        
        do{
            try self.manageContext.save()
            self.ReadData()
        }
        catch let err as NSError{
            print(err.localizedDescription)
        }
        
    }
    
    
    var managedObjList:[NSManagedObject]!
    
    func ReadData()  {
        self.managedObjList = [NSManagedObject]()
        
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Student")
        
        do{
            
            self.managedObjList = try self.manageContext.fetch(fetchReq)
            self.tableInfo.reloadData()

            
        }catch let err as NSError{
            print(err.localizedDescription)
        }

        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managedObjList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        cell.textLabel?.text = "\(managedObjList[indexPath.row].value(forKey: "name")!)"
        
        cell.detailTextLabel?.text = "\(managedObjList[indexPath.row].value(forKey: "course")!)"
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = Int16("\(managedObjList[indexPath.row].value(forKey: "id")!)")
        
        
    }
}

