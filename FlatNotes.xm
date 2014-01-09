//
//  FlatNotes.xm
//
//
//  Created by Harlan Haskins on 1/8/14.
//
//

#import "UIImage+Color.h"

@interface NotesTextureBackgroundView

+ (UIImage*) textureImage;

@end

%hook NotesTextureBackgroundView

+ (UIImage*) statusBarBackgroundImage {

    // Create a blank, white image for the background.
    return [%c(NotesTextureBackgroundView) textureImage];
}

+ (UIImage*) textureImage {

    // Create a blank, white image for the background.
    return [UIImage imageWithColor:[UIColor whiteColor]];
}

%end

%hook NoteCellContentView

- (void) setTitle:(NSString*)title {
    
    // Hook the useLetterpress variable and set it to NO.
    BOOL &useLetterpress = MSHookIvar<BOOL>(self, "_useLetterpress");
    useLetterpress = NO;
    
    %orig(title);
}

- (void) setDate:(NSDate*)date {
    
    // Hook the useLetterpress variable and set it to NO.
    BOOL &useLetterpress = MSHookIvar<BOOL>(self, "_useLetterpress");
    useLetterpress = NO;
    
    %orig(date);
}

%end

%hook NotesApp

- (void) _configureBarLetterpress:(UINavigationBar*)navigationBar {
    // We don't ever want this to run. No sir.
    return;
}

%end
