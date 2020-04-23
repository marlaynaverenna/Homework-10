//
//  ViewController.swift
//  Homework 10
//
//  Created by Marlayna Verenna on 4/23/20.
//  Copyright © 2020 Marlayna Verenna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var school: UITextField!
    @IBOutlet weak var gradeLevel: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var results: UITextView!
    
    @IBAction func saveResults(_ sender: Any) {
        let csvLine:String = "\(firstName.text!),\(school.text!),\(gradeLevel.text!),\(major.text!)\n"
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDir:String=paths[0]
        let resultsFile:String=(docDir as NSString).appendingPathComponent("results.csv")
        
        if !FileManager.default.fileExists(atPath: resultsFile) {
            FileManager.default.createFile(atPath: resultsFile, contents: nil, attributes: nil)
        }
        
        let fileHandle:FileHandle=FileHandle(forUpdatingAtPath:resultsFile)!
        fileHandle.seekToEndOfFile()
        fileHandle.write(csvLine.data(using: String.Encoding.utf8)!)
        fileHandle.closeFile()
        
        firstName.text = ""
        school.text = ""
        gradeLevel.text = ""
        major.text = ""
    }
    
    @IBAction func displayResults(_ sender: Any) {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDir:String=paths[0] as String
        
        let resultsFile:String=(docDir as NSString).appendingPathComponent("results.csv")
        
        if FileManager.default.fileExists(atPath: resultsFile) {
            let fileHandle:FileHandle = FileHandle(forReadingAtPath:resultsFile)!
            let resultsData:String!=NSString(data:fileHandle.availableData, encoding:String.Encoding.utf8.rawValue)! as String
            fileHandle.closeFile()
            results?.text=resultsData
        } else {
            // File does not exist
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

