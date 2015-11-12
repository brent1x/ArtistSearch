//
//  ViewController.m
//  ArtistSearch
//
//  Created by Brent Dady on 11/11/15.
//  Copyright © 2015 Brent Dady. All rights reserved.
//

#import "ViewController.h"
#import "ArtistResult.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSDictionary *returnedDictionary;
@property NSArray *individualResults;
@property NSMutableArray *arrayOfResults;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self networkCall];
}

- (void)networkCall {
    self.returnedDictionary = [NSDictionary new];
    self.individualResults = [NSArray new];
    self.arrayOfResults = [NSMutableArray new];

    NSString *appleURL = @"https://itunes.apple.com/search?term=mariah+carey&limit=20";

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:appleURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {

                self.returnedDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                self.individualResults = [self.returnedDictionary objectForKey:@"results"];

                for (NSDictionary *dict in self.individualResults) {
                    NSString *artistName = [dict objectForKey:@"artistName"];
                    NSString *trackName = [dict objectForKey:@"trackName"];
                    NSString *collectionName = [dict objectForKey:@"collectionName"];
                    NSString *previewUrl = [dict objectForKey:@"previewUrl"];
                    NSString *artworkUrl100 = [dict objectForKey:@"artworkUrl100"];
                    NSString *collectionViewUrl = [dict objectForKey:@"collectionViewUrl"];
                    NSNumber *collectionPrice = [dict objectForKey:@"collectionPrice"];
                    NSNumber *trackPrice = [dict objectForKey:@"trackPrice"];

                    ArtistResult *result = [[ArtistResult alloc] initWithName:artistName track:trackName collection:collectionName preview:previewUrl artwork:artworkUrl100 collection:collectionViewUrl cPrice:collectionPrice tPrice:trackPrice];
                    [self.arrayOfResults addObject:result];
                    [self.tableView reloadData];
                }
            }] resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.individualResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    NSDictionary *individualResult = [self.individualResults objectAtIndex:indexPath.row];
    cell.textLabel.text = [individualResult objectForKey:@"trackName"];
    cell.detailTextLabel.text = [individualResult objectForKey:@"collectionName"];
    return cell;
}

@end
