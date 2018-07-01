//
//  MMFTableViewController.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 01/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import UIKit

//MARK: - SentMMTableViewController: UIViewController

class SentMMTableViewController: UIViewController {

    //MARK: Outlets
   
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Life Cycle views
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let appDelegate = UIApplication.shared.delegate as! MMFAppDelegate
        if appDelegate.memes.count == 0 {
            let editVC = self.storyboard?.instantiateViewController(withIdentifier: "MMFEditorViewController")
            self.present(editVC!, animated: false, completion: nil)
        }
        
        //self.tableView.register(SentMMTableViewCell.self, forCellReuseIdentifier: "TableCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: .UIDeviceOrientationDidChange, object: nil)
    }
}


//MARK: - SentMMTableViewController: UITableViewDataSource

extension SentMMTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! MMFAppDelegate
        return appDelegate.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! SentMMTableViewCell
        let appDelegate = UIApplication.shared.delegate as! MMFAppDelegate
        let meme = appDelegate.memes[indexPath.row]
        
        cell.meme = meme
        
        cell.configureTableViewCell(meme)
        
        return cell
    }
}

//MARK: - SentMMTbaleViewController: UITableViewDelegate

extension SentMMTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MMFDetailViewController") as! MMFDetailViewController
        let appDelegate = UIApplication.shared.delegate as! MMFAppDelegate
        let meme = appDelegate.memes[indexPath.row]
        detailVC.memeDetail = meme
        self.navigationController?.show(detailVC, sender: self)
      
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! MMFAppDelegate
            appDelegate.memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
        }
    }
}
