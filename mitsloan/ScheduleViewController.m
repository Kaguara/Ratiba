//
//  FirstViewController.m
//  mitsloan
//
//  Created by Leonard Ng'eno on 2/13/14.
//  Copyright (c) 2014 Leonard Ng'eno. All rights reserved.
//

#import "ScheduleViewController.h"

@implementation ScheduleViewController

@synthesize scheduleView;
@synthesize scheduleArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.scheduleView.dataSource = self;
    self.scheduleView.delegate = self;
    self.scheduleArray = [self getDummyScheduleArray];
    
}

-(NSArray *) getDummyScheduleArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        Panel *panel = [[Panel alloc] init];
        [array addObject:panel];
    }
    return array;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.scheduleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SettingsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Panel *panel = [self.scheduleArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:panel.title];
    [cell.detailTextLabel setText:[self getDateString:panel.startTime]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PanelViewController *panelView = [self.storyboard instantiateViewControllerWithIdentifier:@"PanelViewController"];
    Panel *myPanel = [self.scheduleArray objectAtIndex:indexPath.row];
    panelView.title = myPanel.title;
    panelView.location = myPanel.location;
    panelView.blurb = myPanel.blurb;
    panelView.time = [self getDateString:myPanel.startTime];
    panelView.panelists = myPanel.speakers;
    [self.navigationController pushViewController:panelView animated:YES];
}

-(NSString *) getDateString:(NSDate *) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
