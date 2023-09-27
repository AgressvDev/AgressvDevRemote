//
//  AddGameViewController.swift
//  AGRESSV
//
//  Created by RyanMax OMelia on 9/18/23.
//

import UIKit
import UIKit
import Firebase
import FirebaseFirestore


class AddGameViewController: UIViewController {
    
    
   
    
    @IBOutlet weak var lbl_WL_Prompt: UILabel!
    
    @IBOutlet weak var lbl_CurrentUser: UILabel!
    
    @IBOutlet weak var lbl_Partner: UILabel!
    
    @IBOutlet weak var lbl_OppOne: UILabel!
    
    @IBOutlet weak var lbl_OppTwo: UILabel!
    
    @IBOutlet weak var lbl_doublesgame: UILabel!
    
    @IBOutlet weak var lbl_VS: UILabel!
    
    //Displaying game players
    var currentuser: String = ""
    var selectedCellValue: String = SharedData.shared.PartnerSelection //Partner
    var selectedCellValueOppOne: String =  SharedData.shared.OppOneSelection//Opp One
    var selectedCellValueOppTwo: String = SharedData.shared.OppTwoSelection
    
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        func getcurrentuser() {
            let db = Firestore.firestore()
            let uid = Auth.auth().currentUser!.email
            let docRef = db.collection("Agressv_Users").document(uid!)
            
            docRef.getDocument { (document, error) in
                if let err = error {
                    print("Error getting documents: \(err)")
                } else {
                    print("\(document!.documentID) => \(String(describing: document!.data()))")
                    
                    let Doubles_Rank = document!.data()!["Username"]
                    let Doubles_Rank_As_String = String(describing: Doubles_Rank!)
                    self.currentuser = Doubles_Rank_As_String
                    self.lbl_CurrentUser.text = self.currentuser
                 
                }
            }
        }
        
        print(getcurrentuser())
        
        func GetDoublesRank() {
            let db = Firestore.firestore()
            let uid = Auth.auth().currentUser!.email
            let docRef = db.collection("Agressv_Users").document(uid!)
            
            docRef.getDocument { (document, error) in
                if let err = error {
                    print("Error getting documents: \(err)")
                } else {
                    print("\(document!.documentID) => \(String(describing: document!.data()))")
                    
                    let Doubles_Rank = document!.data()!["Doubles_Rank"]
                    let Doubles_Rank_As_String = String(describing: Doubles_Rank!)
                    self.CurrentUserDoublesRank = Doubles_Rank_As_String
                    
                 
                }
            }
        }
        
        print(GetDoublesRank())
        
        
        
        self.lbl_Partner.text = selectedCellValue
        self.lbl_OppOne.text = selectedCellValueOppOne
        self.lbl_OppTwo.text = selectedCellValueOppTwo
        
        
        lbl_CurrentUser.frame.origin = CGPoint(x:140, y:205)
        lbl_Partner.frame.origin = CGPoint(x:140, y:245)
        lbl_OppOne.frame.origin = CGPoint(x:140, y:355)
        lbl_OppTwo.frame.origin = CGPoint(x:140, y:395)
        lbl_doublesgame.frame.origin = CGPoint(x:70, y:105)
        lbl_VS.frame.origin = CGPoint(x:175, y:300)
        lbl_WL_Prompt.frame.origin = CGPoint(x:70, y:500)
    } //end of load
    
    
    
    var WL_Selection = "W"
    
    var Today = Date()
 
    //For calculating players' ranks
    var CurrentUserDoublesRank: String!
    var PartnerDoublesRank: String!
    var OppOneDoublesRank: String!
    var OppTwoDoublesRank: String!
    
    
    @IBOutlet weak var seg_WLOutlet: UISegmentedControl!
    
    
    
    @IBAction func seg_WL(_ sender: UISegmentedControl) {

       
        if seg_WLOutlet.selectedSegmentIndex == 0
        {

            self.WL_Selection = "W"
            
            }
            else if seg_WLOutlet.selectedSegmentIndex == 1
                        
            {
            
            self.WL_Selection = "L"
            
            }
        }
    
    
    
    
    @IBAction func btn_LogGame(_ sender: UIButton) {
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser!.email
   
        let Game_ref = db.collection("Agressv_Games").document()
        let User_ref = db.collection("Agressv_Users").document(uid!)
        
     
    
       if WL_Selection == "W" {
            
            User_ref.updateData([
                "Doubles_Games_Wins": FieldValue.increment(Int64(1))])
            
            User_ref.updateData([
                "Doubles_Rank": FieldValue.increment(0.1)])
           
           //Partner_ref
//           Partner_ref.updateData([
//               "Doubles_Games_Wins": FieldValue.increment(Int64(1))])
//
//           Partner_ref.updateData([
//               "Doubles_Rank": FieldValue.increment(0.1)])
           
        }
        
        else if WL_Selection == "L"{
            
            User_ref.updateData([
                "Doubles_Games_Losses": FieldValue.increment(Int64(1))])
            
            //Partner_ref
//            Partner_ref.updateData([
//                "Doubles_Games_Losses": FieldValue.increment(Int64(1))])
            
            //if Doubles Rank is 8.5 do not decrement
            if CurrentUserDoublesRank == "8.5" {
                //do not decrement
            }
//            if DoublesRankValue_Partner == "8.5" {
//                //do not decrement
//            }
            
            else {
                User_ref.updateData([
                    "Doubles_Rank": FieldValue.increment(-0.1)])
                
//                Partner_ref.updateData([
//                    "Doubles_Rank": FieldValue.increment(-0.1)])
                
               
            }
        }
        
            
        
            
        Game_ref.setData(["Game_Result" : WL_Selection, "Game_Date" : Today, "Game_Creator": uid!, "Game_Type": "Doubles", "Game_Partner": "", "Game_Opponent_One": "", "Game_Opponent_Two": ""])
            
            User_ref.updateData([
                "Doubles_Games_Played": FieldValue.increment(Int64(1))])
            
            //Partner_ref
//          Partner_ref.updateData([
//            "Doubles_Games_Played": FieldValue.increment(Int64(1))])
            
            let dialogMessage = UIAlertController(title: "Success!", message: "Your game has been logged.", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
            
            
        }
        
        
        
        
        
        
    }

