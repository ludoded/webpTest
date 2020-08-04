//
//  ViewController.swift
//  webpTest
//
//  Created by Haik Ampardjian on 04.08.2020.
//  Copyright © 2020 Odessite. All rights reserved.
//

import UIKit
import WebP

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapButton(_ sender: Any) {
        print("tapped")
        let encoder = WebPEncoder()
        let decoder = WebPDecoder()
        let queue = DispatchQueue(label: "me.ainam.webp")
        let image = UIImage(contentsOfFile: "im1.png")!

        queue.async {
            do {
                print("convert start")
                let data = try! encoder.encode(image, config: .preset(.picture, quality: 95))
                var options = WebPDecoderOptions()
                options.scaledWidth = Int(image.size.width)
                options.scaledHeight = Int(image.size.height)
                self.save(data)
//                let webpImage = try decoder.decode(toUImage: data, options: options)
                print("decode finish")
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func save(_ data: Data) {
        let filename = getDocumentsDirectory().appendingPathComponent("output.webp")

        do {
            try data.write(to: filename, options: Data.WritingOptions.atomic)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

