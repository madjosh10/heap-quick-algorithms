//
//  Heap.swift
//  Heap
//
//  Created by Joshua Madrigal on 2/20/20.
//  Copyright © 2020 Joshua Madrigal. All rights reserved.
//

import UIKit
import Foundation

/*
 Joshua Madrigal
 Algorithms
 
 (Reference)
 Book: Data Structures and Algorithms in Swift
 Authors: Kevin Lau, Vincent Ngo
 
 Time complexity for Heap
 Time complexity for quickSort
 - Best - O(n log(n))
 - Worst - O(n^2)
 - Avg - O(n log(n))
 
 Writing Heap to fetch min/max element of a collection

 Defing Heap struct(of value type) Using Element & Equatable protocol
 Equatable is a type that can be comapred for value equality
 Element is a type representing the sequences element (usually uses associated type Iterator)
   Iterator - A type that provides the sequence’s iteration interface and encapsulates its iteration state.
 
*/

struct Heap<Element:Equatable> {
    var elements: [Element] = []
    let sort: (Element, Element) -> Bool
    /*
     Using @escaping since it is a closure(function) within the initializer
     */
    
    init(sort: @escaping (Element,Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                shiftDown(from: i)
            }
        }
        
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    // MARK - Method to peek at the beginning of the array
    func peek() -> Element? {
        return elements.first
    }
    
    //MARK - methods for left, right and parent indecies
    func leftChildIndex(ofParent index: Int) -> Int {
        return (2 * index) + 1
    }
    func rightChildIndex(ofParent index: Int) -> Int {
        return (2 * index) + 2
    }
    
    func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }
    
    //MARK - Method is a remove operation simply removing the root node from the heap and positioning it into its appropriate position.
    /*
     - Checking if the heap is empty, if so return nil
     - Swap the root with last element
     - Remove the last element which is either max/min and return it back.
     - May not be a max or min anymore, need to shiftDown to conform to the guidelines.
     
     defer: statement is used for executing code just before transferring program control outside of the scope that the statement appears in. (Prints variable before mutation but usually goes after it changed variable)
     
     */
    mutating func remove() -> Element? {
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            shiftDown(from: 0)
        }
        return elements.removeLast()
    }
    
    /*
     - Store parent index, then continuing shifting until return
     - Get parent's left and right child index
     - The next var is used as a temp index var to swap with parent
     - If there is a left child, has higher priority than its parent make it next.
     - If there is a right child, has an even greater priority, it will become next instead.
     - If next is still parent, reached end, no shifting.
     - Swap next with parent, set as new parent.
     */
    mutating func shiftDown(from index: Int) {
        var parent = index
        while true {
            let left = leftChildIndex(ofParent: parent)
            let right = rightChildIndex(ofParent: parent)
            
            var next = parent
            
            if left < count && sort(elements[left], elements[next]) {
                next = left
            }
            
            if right < count && sort(elements[right], elements[next]) {
                next = right
            }
            
            if next == parent {
                return
            }
            
            elements.swapAt(parent, next)
            parent = next
        }
        
    }
    
    /*
     Insert appends the element into the array, shiftsUp
     */
    
    mutating func insert(_ element: Element) {
        elements.append(element)
        shiftUp(from: elements.count - 1)
    }
    
    /*
     Shiftup swaps current node with parent, as long as that node has a higher priority than its parent.
     */
    
    mutating func shiftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
        
    }
    
    /*
     - Check if index is within the bounds of the array, if not nil
     - if removing last element remove, and return element.
     - not removing last element first swap element with the last element.
     - return and remove the last element
     - perform a shift down and shift up to adjust heap
     */
    
    mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {
            return nil
        }
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, elements.count - 1)
            defer {
                shiftDown(from: index)
                shiftUp(from: index)
            }
            return elements.removeLast()
        }
    }
    
    /*
        If the index is greater than the number of the elements in the array, the search failed.
        Check if the element you are looking for has higher priority.
        If the element is equal to the element at index i, return i
        Recursively search for the element starting from the left child of i.
        Recursively search for the element starting from the right child of i.
        If both searches failed, search failed. Return nil
     */
    
    func index(of element: Element, startAt i: Int) -> Int? {
        if i >= count {
            return nil
        }
        
        if sort(element,elements[i]) {
            return nil
        }
        
        if element == elements[i] {
            return i
        }
        if let j = index(of: element, startAt: leftChildIndex(ofParent: i)) {
            return j
        }

        if let j = index(of: element, startAt: rightChildIndex(ofParent: i)) {
            return j
        }
        return nil
        
    }
    
}
