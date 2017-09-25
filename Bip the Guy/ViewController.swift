//
//  ViewController.swift
//  Bip the Guy
//
//  Created by Arya Murthi on 9/17/17.
//  Copyright © 2017 Arya Murthi. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var audioPlayer = AVAudioPlayer()
    var imagePicker = UIImagePickerController()
    
    //MARK: Properties
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var libraryButtonOutlet: UIButton!
    @IBOutlet weak var cameraButtonOutlet: UIButton!
    
    
    //MARK: Functions
    
    func animateImage() {
        // Shrink image
        let bounds = self.image.bounds
        let shrinkValue = CGFloat(60)
        
        self.image.bounds = CGRect(x: self.image.bounds.origin.x + shrinkValue, y: self.image.bounds.origin.y + shrinkValue, width: self.image.bounds.size.width - shrinkValue , height: self.image.bounds.size.height - shrinkValue)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: { self.image.bounds = bounds }, completion: nil)
        
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        
        // Is it possible to load in the sound file?
        if let sound = NSDataAsset(name: soundName) {
            
            // check if sound.data is a usable file
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                
                // if sound.data is not a valid audio file
                print("ERROR: file \(soundName) didn't load.")
            }
        } else {
            // if reading the assets folder didn't work
            print("ERROR: file \(soundName) didn't load.")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage]
            as! UIImage
        image.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func errorMessage() {
        let alertController = UIAlertController(title: "ERROR:", message: "Camera not found.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        present(alertController, animated:true, completion: nil)
        
        alertController.addAction(defaultAction)
    }
    
    //MARK: Actions
    
    @IBAction func libraryPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            errorMessage()
        }
        
        
    }
    
    @IBAction func imagePunched(_ sender: UITapGestureRecognizer) {
        animateImage()
        playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.layer.borderWidth = 2.0
        libraryButtonOutlet.layer.borderWidth = 2.0
        cameraButtonOutlet.layer.borderWidth = 2.0
    }
    
    
    
    
}

