//
//  main.swift
//  boostcamp_ios
//
//  Created by jgchoiqa on 2017. 6. 8..
//  Copyright © 2017년 Joshua. All rights reserved.
//

import Foundation
let filePath = NSHomeDirectory() + "/students.json"

private func readJson(){
    
    do {
        let nsstr = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue)
            let data = String(nsstr)
    
            print(data)
            do {
                let dic = try JSONSerialization.jsonObject(with: data.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                print(dic[1])
            } catch {
                print("failed")
            }
    } catch {
        print("failed1")
    }
}

readJson()
