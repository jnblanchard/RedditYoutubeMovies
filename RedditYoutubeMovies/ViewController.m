//
//  ViewController.m
//  RedditYoutubeMovies
//
//  Created by John N Blanchard on 8/25/16.
//  Copyright © 2016 John N Blanchard. All rights reserved.
//

#import "ViewController.h"
@import JavaScriptCore;
#import "TFHpple.h"
#import "YoutubePlayerViewController.h"

#define urlRedditString @"https://www.reddit.com/r/fullmoviesonyoutube"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray* movieArray;

@property NSString* selectedID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TFHpple* redditParser = [TFHpple hppleWithHTMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlRedditString]]];
    NSMutableArray* array = [NSMutableArray arrayWithArray:[redditParser searchWithXPathQuery:@"//p[@class=\"title\"]"]];
    
    self.movieArray = [NSMutableArray new];
    
    [array removeObjectAtIndex:0];
    for (TFHppleElement* element in array)
    {
        if ([[[element.children objectAtIndex:1] firstChild] isKindOfClass:[TFHppleElement class]])
        {
            TFHppleElement* layerOne = [element.children objectAtIndex:1];
//            NSLog(@"%@", [layerOne.attributes objectForKey:@"href"]);
            NSString* fullURL = [layerOne.attributes objectForKey:@"href"];
            TFHppleElement* layerTwo = [layerOne firstChild];
            NSString* title = layerTwo.content;
            NSArray* movie = @[title, [self parseStringForMovieTitle:fullURL]];
            [self.movieArray addObject:movie];
        }
    }
    [self.tableView reloadData];
    
}

- (BOOL)prefersStatusBarHidden
{
    return true;
}

- (NSString*) parseStringForMovieTitle:(NSString*)str
{
    NSArray* comps = [str componentsSeparatedByString:@"/"];
    NSString* lastID = comps.lastObject;
    if ([lastID containsString:@"="])
    {
        comps = [lastID componentsSeparatedByString:@"="];
        lastID = comps.lastObject;
    }
    return comps.lastObject;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movieArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* movie = [self.movieArray objectAtIndex:indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = movie.firstObject;
    cell.detailTextLabel.text = movie.lastObject;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* movie = [self.movieArray objectAtIndex:indexPath.row];
    self.selectedID = movie.lastObject;
    [self performSegueWithIdentifier:@"vid" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YoutubePlayerViewController* ypvc = (YoutubePlayerViewController*)segue.destinationViewController;
    NSLog(@"%@", self.selectedID);
    ypvc.ytID = self.selectedID;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
