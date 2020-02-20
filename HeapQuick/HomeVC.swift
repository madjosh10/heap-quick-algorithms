//
//  HomeVC.swift
//  HeapQuick
//
//  Created by Joshua Madrigal on 2/20/20.
//  Copyright © 2020 Joshua Madrigal. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var heapTime: UILabel!
    @IBOutlet weak var quickTime: UILabel!
    
    var unSortedArray = [Int]()
    var unSortedArray2 = [Int]()
    var unSortedArray3 = [Int]()
    var unSortedArray4 = [Int]()

    var sortedArray = [Int]()
    var sortedArray2 = [Int]()
    var sortedArray3 = [Int]()
    var sortedArray4 = [Int]()
    
    var isHeapTimerOn = false
    var isQuickTimerOn = false
    var quickTimer = 0.0
    var heapTimer = 0.0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let quick = QuickSort()
        
        let array = quick.partition(list: unSortedArray, first: 1, last: unSortedArray.count)
        
        print(array)
        
        
        
    }
    
    func generatingRandomNumbs(arr: [Int]) -> [Int] {
        var array = arr
        for _ in 1...100 {
            let number = Int.random(in: 0...500)
            array.append(number)
        }
        return array
        
    }
    
    @IBAction func startingTimer(_ sender: Any) {
        toggleHeapTimer(on: isHeapTimerOn)
        toggleQuickTimer(on: isQuickTimerOn)
        
        unSortedArray = generatingRandomNumbs(arr: unSortedArray)
        unSortedArray2 = generatingRandomNumbs(arr: unSortedArray2)
        unSortedArray3 = generatingRandomNumbs(arr: unSortedArray3)
        unSortedArray4 = generatingRandomNumbs(arr: unSortedArray4)
        
        print("___________ UNSORTED ARRAYS __________\n")
        print(unSortedArray)
        print(unSortedArray2)
        print(unSortedArray3)
        print(unSortedArray4)
        
        var quick = QuickSort()
        var heaping = Heap(sort: <, elements: unSortedArray)
        var heaping2 = Heap(sort: <, elements: unSortedArray2)
        var heaping3 = Heap(sort: <, elements: unSortedArray3)
        var heaping4 = Heap(sort: <, elements: unSortedArray4)
        
        
        /*
        This creates a max/ min heap (because >/ < is used as the sorting function) and removes elements one-by-one until it is empty.
        */
        
        while !heaping.isEmpty {
            sortedArray.append(heaping.remove()!)
        }
        while !heaping2.isEmpty {
            sortedArray2.append(heaping2.remove()!)
        }
        while !heaping3.isEmpty {
            sortedArray3.append(heaping3.remove()!)
        }
        while !heaping4.isEmpty {
            sortedArray4.append(heaping4.remove()!)
        }
        print("___________ HEAP SORTED __________\n")
        print("\n \(sortedArray)")
        print("\n \(sortedArray2)")
        print("\n \(sortedArray3)")
        print("\n \(sortedArray4)")
        
        print("____________ QUICK SORTED _________\n")
        print(quick.quickSort(A: unSortedArray))
        print(quick.quickSort(A: unSortedArray2))
        print(quick.quickSort(A: unSortedArray3))
        print(quick.quickSort(A: unSortedArray4))
        
    }
    
    func toggleHeapTimer(on: Bool) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self](_) in
            guard let strongSelf = self else { return }
            var roundedString = String(format: "%.3f", strongSelf.heapTimer)
            strongSelf.heapTimer += 0.1
            strongSelf.heapTime.text = roundedString
        })
    }
    
    func toggleQuickTimer(on: Bool) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self](_) in
            guard let strongSelf = self else { return }
            
            var roundedString = String(format: "%.3f", strongSelf.quickTimer)
                   
            strongSelf.quickTimer += 0.1
            strongSelf.quickTime.text = roundedString
        })
    }
    
} // end HomeVC
