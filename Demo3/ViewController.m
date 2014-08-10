//
//  ViewController.m
//  Demo3
//
//  Created by Kirbo on 08/08/14.
//  Copyright (c) 2014 es.ujaen.es. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSURLSession * session;
@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfiguration;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.items = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://mejorandoios.herokuapp.com/api/courses/all"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    self.sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
        if(urlResponse.statusCode == 200){
            NSLog(@"It`s OK");
            [self handleResults:data];
        }
    }];
    
    [task resume];
}

-(void)handleResults:(NSData *)data{
    NSError *jsonError;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    
    if(response){
        NSLog(@"%@",response[@"data"]);
        
        for(NSDictionary *dataDictionary in response[@"data"]){
            [self.items addObject:dataDictionary];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.CollectionView reloadData];
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.items count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

@end
