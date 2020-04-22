//
//  FetchedResultsControllerEntityObserver.swift
//
//
//  Created by Luca Gobbo on 21/04/2020.
//

import CoreData
import Foundation
import ReactiveKit

public final class FetchedResultsControllerEntityObserver<T: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {
    typealias Observer =  AtomicObserver<[T], ReactiveKitCoreData.Error>

    private let observer: Observer
    private let fetchedResultsController: NSFetchedResultsController<T>

    init(observer: Observer, fetchRequest: NSFetchRequest<T>, managedObjectContext context: NSManagedObjectContext, sectionNameKeyPath: String?, cacheName: String?) {
        self.observer = observer

        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: sectionNameKeyPath, cacheName: cacheName)
        super.init()

        context.perform {
            self.fetchedResultsController.delegate = self

            do {
                try self.fetchedResultsController.performFetch()
            } catch {
                observer.receive(completion: .failure(.fetchFailed(error)))
            }

            self.sendNextElement()
        }
    }

    private func sendNextElement() {
        fetchedResultsController.managedObjectContext.perform {
            let entities = self.fetchedResultsController.fetchedObjects ?? []
            self.observer.receive(entities)
        }
    }

    public func controllerDidChangeContent(_: NSFetchedResultsController<NSFetchRequestResult>) {
        sendNextElement()
    }
}

// MARK: - Disposable

extension FetchedResultsControllerEntityObserver: Disposable {
    public var isDisposed: Bool { fetchedResultsController.delegate == nil }
    public func dispose() {
        fetchedResultsController.delegate = nil
    }
}
