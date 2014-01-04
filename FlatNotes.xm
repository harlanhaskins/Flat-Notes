//%hook UIColor
//
//+(UIColor*) notesAppYellowColor {
//    // Return a nice, calm, iOS 7 blue.
//    return [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
//}
//
//%end

@interface UIImage(Color)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

@implementation UIImage(Color)

+ (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0, 0, 1, 1);

    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;

}

@end

%hook NotesTextureBackgroundView

+ (UIImage*) statusBarBackgroundImage {
    
    // Create a blank, white image for the background.
    return [UIImage imageWithColor:[UIColor whiteColor]];
}

+ (UIImage*) textureImage {
    
    // Create a blank, white image for the background.
    return [UIImage imageWithColor:[UIColor whiteColor]];
    
}

%end

@interface NoteCellContentView : UIView

@end

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

- (void) _configureBarLetterpress:(id)arg1 {
    
    // We don't ever want this to run. No sir.
    return;
}

%end

@interface NoteContentLayer : UIView<UITextViewDelegate>

@end

%hook NoteContentLayer

- (void) setContent:(id)arg1 isPlainText:(_Bool)arg2 isCJK:(_Bool)arg3 {
    %orig(arg1, YES, arg3);
    NSString *logString = [NSString stringWithFormat:@"content: %@ isPlainText: %@", arg1, arg2 ? @"YES" : @"NO"];
    %log(logString);
    
}

%end