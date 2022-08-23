//
//  PriorityQueue.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import Foundation

final class PriorityQueue<Element: Equatable> {
  
  private var items: [QueueItem<Element>] = []
  
  var isEmpty: Bool {
    items.isEmpty
  }
  
  func contains(_ item: Element) -> Bool {
    items.contains { $0.value == item }
  }
  
  func push(_ item: Element, priority: Double) {
    if contains(item) {
      update(item, priority: priority)
    } else {
      let newItem = QueueItem(value: item, priority: priority)
      items.append(newItem)
      sortItems()
    }
  }
  
  func pop() -> Element? {
    guard !isEmpty else { return nil }
    
    let item = items.removeFirst()
    return item.value
  }
  
  private func update(_ item: Element, priority: Double) {
    if let existingItem = items.filter({ $0.value == item }).first {
      existingItem.priority = priority
      sortItems()
    }
  }
  
  private func sortItems() {
    items = items.sorted(by: <)
  }
}

fileprivate class QueueItem<Element: Equatable>: Comparable {
  
  let value: Element
  var priority: Double
  
  init(value: Element, priority: Double) {
    self.value = value
    self.priority = priority
  }
  
  static func < (lhs: QueueItem<Element>, rhs: QueueItem<Element>) -> Bool {
    lhs.priority < rhs.priority
  }
  
  static func == (lhs: QueueItem<Element>, rhs: QueueItem<Element>) -> Bool {
    lhs.priority == rhs.priority
  }
}
