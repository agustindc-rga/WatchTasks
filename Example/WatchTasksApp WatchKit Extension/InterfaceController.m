//
//  InterfaceController.m
//  WatchTasksApp WatchKit Extension
//
//  Created by Agustín de Cabrera on 2/3/15.
//  Copyright (c) 2015 Agustín de Cabrera. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchTasks/WatchTasks.h>


@interface InterfaceController()

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *label;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *button;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [self.label setText:@"What's your name?"];
    [self.button setTitle:@"Enter name"];
    

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(IBAction)buttonTapped:(id)sender {
    [self presentTextInputControllerWithSuggestions:@[@"Bob", @"Alice"] allowedInputMode:WKTextInputModePlain completion:^(NSArray *results) {
        
        WTTaskRequest *request = [[WTTaskRequest alloc] initWithTaskType:@"ExampleTask"];
        request.parameters[@"name"] = [results componentsJoinedByString:@" "];
        
        [[WTTaskClient sharedInstance] sendTaskRequest:request completion:^(WTTaskResponse *response) {
            
            if (!response.errorMessage) {
                [self.button setHidden:YES];
                [self.label setText:response.data[@"message"]];
            }
        }];
    }];
}

@end



