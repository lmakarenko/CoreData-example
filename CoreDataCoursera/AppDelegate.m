//
//  AppDelegate.m
//  CoreDataCoursera
//
//  Created by Lev Makarenko on 27.02.2021.
//

#import "AppDelegate.h"
#import "Company+CoreDataClass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.context = self.persistentContainer.viewContext;
    return YES;
}

- (void)createCompany:(Company*)companyData {
    // Company *company = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.context];
    Company *company = [[Company alloc] initWithContext:self.context];
    company.name = companyData.name;
    company.ticker = companyData.ticker;
    company.web = companyData.web;
    company.address = companyData.address;
    [self saveContext];
}

- (NSArray <Company*>*)fetchCompanies {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    NSArray<Company*> *companies = [self.context executeFetchRequest:request error:nil];
    [self printCompaniesArray:companies];
    return companies;
}

- (NSArray <Company *>*)fetchWithSort {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    NSSortDescriptor *ageDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[ageDescriptor];
    NSArray <Company*> *companies = [self.context executeFetchRequest:request error:nil];
    [self printCompaniesArray:companies];
    return companies;
}

- (NSArray <Company *>*)fetchWithFilter {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ticker = \"T\""];
    request.predicate = predicate;
    NSArray <Company*> *companies = [self.context executeFetchRequest:request error:nil];
    [self printCompaniesArray:companies];
    return companies;
}

//- (void)updateCompany:(Company*)companyData {
//    Company *company = self.fetchCompanies[0];
//    company.name = companyData.name;
//    company.ticker = companyData.ticker;
//    company.web = companyData.web;
//    company.address = companyData.address;
//    [self saveContext];
//}

- (void)deleteCompany:(Company*)company {
//    NSArray <Company*>* companies = [self fetchWithFilter];
//    Company *company = companies[0];
    [self.context deleteObject:company];
    [self saveContext];
}

- (void)printCompaniesArray:(NSArray <Company *>*)companies {
    for(Company *company in companies) {
        NSLog(@"%@", company.name);
    }
}

#pragma mark - Core Data Stack

- (void)applicationWillTerminate:(UIApplication *)application {
    //[self saveContext];
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreDataCoursera"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
