//
//  main.swift
//  boostcamp_ios
//
//  Created by jgchoiqa on 2017. 6. 8..
//  Copyright © 2017년 Joshua. All rights reserved.
//

import Foundation
let filePath = NSHomeDirectory() + "/students.json"
let resultPath = NSHomeDirectory() + "/result.txt"
var total: Double = 0
var count: Int = 0
var resultText: String = "성적결과표\n\n"
var studentText: String = ""
var completion: [String] = []
var student: [String:Int]

private func readJson() {
    
    do {
        let nsstr = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue)
            let data = String(nsstr)
    
            do {
                let dic: NSArray = try JSONSerialization.jsonObject(with: data.data(using: String.Encoding.utf8)!) as! NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
                let sortedResults = dic.sortedArray(using: [descriptor])
                print(sortedResults)
                for index in 0...sortedResults.count-1 {
                    var current = [Int]()
                    var current2: Double = 0
                    let dic2 = sortedResults[index] as! [String:Any]
                    let dic3 = dic2["grade"] as! [String:Any]
                    let studentName = dic2["name"] as! String
                    for (_, value) in dic3 {
                        current2 += value as! Double
                        count += 1
                        current.append(value as! Int)
                    }
                    total += (current2 / Double(dic3.count))
                    studentText.append("\(studentName)\t: " + judgeRank(scores: current, name: studentName) + "\n")
                }
                print(total)
                let result = total / Double(dic.count)
                resultText.append("전체 평균 : ")
                resultText.append(String(format: "%.2f", result) + "\n\n")
                print(String(format: "%.2f", result))
                resultText.append("개인별 학점\n" + studentText + "\n")
                let stringArray = completion.joined(separator: ", ")
                resultText.append("수료생\n\(stringArray)")
            } catch {
                print("failed")
            }
    } catch {
        print("failed")
    }
}

private func judgeRank(scores: [Int], name: String) -> String {
    var totalScore = 0
    for index in scores {
        totalScore += index
    }
    totalScore /= scores.count
    if totalScore >= 70 {
        completion.append(name)
    }
    
    if(totalScore >= 90) {
        return "A"
    } else if(totalScore >= 80) {
        return "B"
    } else if(totalScore >= 70) {
        return "C"
    } else if(totalScore >= 60) {
        return "D"
    } else {
        return "F"
    }
}

readJson()
print(resultText)

do {
    try resultText.write(toFile: resultPath, atomically: false, encoding: String.Encoding.utf8)
} catch let error as NSError {
    print("file write failed!")
}
