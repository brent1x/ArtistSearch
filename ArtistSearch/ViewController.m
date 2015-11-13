//
//  ViewController.m
//  ArtistSearch
//
//  Created by Brent Dady on 11/11/15.
//  Copyright © 2015 Brent Dady. All rights reserved.
//

#import "ViewController.h"
#import "ArtistResult.h"
#import "DetailViewController.h"

#define kNSUserDefaultsCacheKey @"kNSUserDefaultsLastCacheKey"

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
    [self.tableView reloadData];
}

- (void)networkCall {

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    self.returnedDictionary = [NSDictionary new];
    self.individualResults = [NSArray new];
    self.arrayOfResults = [NSMutableArray new];

    NSString *appleURL = @"https://itunes.apple.com/search?term=bb+king&limit=20";

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:appleURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {

                if (error) {
                    [self loadCachedData];
                    [self.tableView reloadData];
                }

                self.returnedDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                self.individualResults = [self.returnedDictionary objectForKey:@"results"];

                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.individualResults forKey:kNSUserDefaultsCacheKey];

                for (NSDictionary *dict in self.individualResults) {
                    NSString *artistName = [dict objectForKey:@"artistName"];
                    NSString *trackName = [dict objectForKey:@"trackName"];
                    NSString *collectionName = [dict objectForKey:@"collectionName"];
                    NSString *previewUrl = [dict objectForKey:@"previewUrl"];
                    NSString *trackViewUrl = [dict objectForKey:@"trackViewUrl"];
                    NSString *artworkUrl100 = [dict objectForKey:@"artworkUrl100"];
                    NSString *collectionViewUrl = [dict objectForKey:@"collectionViewUrl"];
                    NSNumber *collectionPrice = [dict objectForKey:@"collectionPrice"];
                    NSNumber *trackPrice = [dict objectForKey:@"trackPrice"];

                    ArtistResult *result = [[ArtistResult alloc] initWithName:artistName track:trackName collection:collectionName preview:previewUrl artwork:artworkUrl100 trackView:trackViewUrl collection:collectionViewUrl cPrice:collectionPrice tPrice:trackPrice];
                    [self.arrayOfResults addObject:result];
                }

                [self.tableView reloadData];

        }] resume];

    [self.tableView reloadData];
}

#pragma mark // load cached data

- (void)loadCachedData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:kNSUserDefaultsCacheKey] != nil) {
        self.individualResults = [userDefaults objectForKey:kNSUserDefaultsCacheKey];
    }
}

#pragma mark // table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.individualResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];

    NSDictionary *individualResult = [self.individualResults objectAtIndex:indexPath.row];

    cell.textLabel.text = [individualResult objectForKey:@"trackName"];
    cell.detailTextLabel.text = [individualResult objectForKey:@"collectionName"];

    NSURL *artworkUrl = [NSURL URLWithString:[individualResult objectForKey:@"artworkUrl100"]];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:artworkUrl]];

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    return cell;
}

#pragma mark // prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ArtistResult *result = [self.arrayOfResults objectAtIndex:indexPath.row];
    DetailViewController *destVC = segue.destinationViewController;
    destVC.result = result;
}

@end
