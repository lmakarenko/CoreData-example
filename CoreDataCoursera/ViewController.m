//
//  ViewController.m
//  CoreDataCoursera
//
//  Created by Lev Makarenko on 27.02.2021.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Company+CoreDataClass.h"
    
@interface ViewController ()

@property (nonatomic, weak) AppDelegate *appDelegate;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSArray <Company*>*companies;

@property (weak, nonatomic) IBOutlet UITextField *companyField;
@property (weak, nonatomic) IBOutlet UITextField *tickerField;
@property (weak, nonatomic) IBOutlet UITextField *webField;
@property (weak, nonatomic) IBOutlet UITextField *addresField;
@property (weak, nonatomic) IBOutlet UILabel *recordCount;
@property (weak, nonatomic) IBOutlet UITextView *recordsLog;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context = self.appDelegate.persistentContainer.viewContext;
    [self fetchAllCompanies];
}

- (void)fetchAllCompanies {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    self.companies = [self.context executeFetchRequest:request error:nil];
    [self updateCompaniesCount];
    [self updateRecordsLog];
}

- (void)updateCompaniesCount {
    self.recordCount.text = [self companiesCountString];
}

- (NSString *)companiesCountString {
    return [NSString stringWithFormat:@"%lu", self.companies.count];
}

- (void)updateRecordsLog {
    NSMutableString *fullText = [[NSMutableString alloc] init];
    for(Company *company in self.companies) {
        NSString *companyInfo = [NSString stringWithFormat:@"%@ (%@), %@, %@\n\n", company.name, company.ticker, company.web, company.address];
        [fullText appendString:companyInfo];
    }
    self.recordsLog.text = fullText;
}

- (void)clearForm {
    self.companyField.text = @"";
    self.tickerField.text = @"";
    self.webField.text = @"";
    self.addresField.text = @"";
}

- (IBAction)addRecord:(id)sender {
    Company *company = [[Company alloc] initWithContext: self.context];
    company.name = self.companyField.text;
    company.ticker = self.tickerField.text;
    company.web = [NSURL URLWithString:self.webField.text];
    company.address = self.addresField.text;
    //[self.appDelegate createCompany:company];
    [self.appDelegate saveContext];
    [self clearForm];
    [self fetchAllCompanies];
}

- (IBAction)deleteAllRecords:(id)sender {
    //[self.context deletedObjects];
    for(Company *company in self.companies) {
        [self.context deleteObject:company];
    }
    [self.appDelegate saveContext];
    [self clearForm];
    [self fetchAllCompanies];
}

@end
