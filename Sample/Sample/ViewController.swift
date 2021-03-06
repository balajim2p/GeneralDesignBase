//
//  ViewController.swift
//  Sample
//
//  Created by Balaji  on 15/02/22.
// /* EX: */

import UIKit
import DesignBase
import Alamofire
import ObjectMapper

class ViewController: UIViewController {
    
    @IBOutlet weak var profileView: UIImageView!
    private var imagePicker: ImagePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* EX: InternetStatus*/
        print(DesignBase.shared.isInternetStatus())
        
        /* EX: Corner radius , Color , OneEdgeCorner*/
        let myView = UIView()
        myView.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
        profileView.setCornerRadius(radius: 20)
        myView.roundCorners(corners: .bottomRight, radius: 34)
        myView.backgroundColor = UIColor.setColour(colour: Colour.lightGrey.rawValue)
        self.view.addSubview(myView)
        
        /* EX: Trim WhiteSpace*/
        print(" Trimspace ".trim)
        
        /* EX: Picker*/
        profileView.circleRadius()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    
    }
    
    @IBAction func alertAction(_ sender: UIButton){
        showMessageAlert(message: "Profile Picker",retryTitle: "gallery") {
            self.imagePicker.present(from: sender)
        } onCancel: {
            print("Cancel")
        }
    }
    
    @IBAction func webViewAction(_ sender: UIButton){
        DesignBase.shared.openWebViewVC(url: "https://www.google.co.in/", title: "WebView",from:self)
    }
    
    @IBAction func APIAction(_ sender: UIButton){
        self.API()
    }
    
    func API(){
        M2PWebServiceClass.shared.callAPI(type: UserModel.self,
                                          with: "api/users",
                                          method: .get,
                                          parameter: nil,
                                          headers: nil,
                                          URL: "https://reqres.in/" ,
                                          completion: { (response, error, code, headLessResponse) in

            print(response?.data?.first ?? [])
            if let imgURL = URL(string: response?.data?.first?.avatar ?? ""){
                self.profileView.load(url:imgURL)
            }
                
        })
    }
}


/* Image Picker delegate */
extension ViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let img = image {
            profileView.image = image
            if let pngRepresentation = img.pngData() {
                UserDefaults.standard.set(pngRepresentation, forKey: "profile")
                UserDefaults.standard.synchronize()
            }
        }
    }
}


