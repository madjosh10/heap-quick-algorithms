//
//  Quick.swift
//  HeapQuick
//
//  Created by Joshua Madrigal on 2/20/20.
//  Copyright © 2020 Joshua Madrigal. All rights reserved.
//

import UIKit
import Foundation

struct QuickSort {

    func partition(list: [Int], first: Int, last: Int) -> Int {
        var pivot = list[first]
        var a = list
        var low = first + 1
        var high = last
        
        while (high > low) {
            
            while (low <= high && list[low] <= pivot) {
                low += 1
            }
            while (low <= high && list[high] > pivot) {
                high -= 1
            }
            
            if (high > low) {
                var temp = a[high]
                a[high] = a[low]
                a[low] = temp
            }
            
        }
        while(high > first && list[high] >= pivot) {
            high -= 1
        }
        
        if(pivot > list[high]) {
            a[first] = a[high]
            a[high] = pivot
            return high
            
        } else {
            return first
        }
        
    }
    
    func quickSort(list: [Int], first: Int, last: Int) {
        if( last > first) {
            var pivotIndex = partition(list: list, first: first, last: last)
            quickSort(list: list, first: first, last: pivotIndex - 1)
            quickSort(list: list, first: pivotIndex + 1, last: last)
        }
    }
    func quickSort(A: [Int]) -> [Int] {
        
        var smaller = [Int]()
        var equal = [Int]()
        var bigger = [Int]()
        
        if A.count > 1 {
          let pivot = A[0]
            
            for x in A {
                if x < pivot {
                    smaller.append(x)
                }
                if x == pivot {
                    equal.append(x)
                }
                if x > pivot {
                    bigger.append(x)
                }
            }
            return (quickSort(A: smaller) + equal + quickSort(A: bigger))
        }  else {
            return A
        }
    }
}
