## The problem

iterm. Full screen view. 
Sometimes I'm moving to iterm display and at the top of the screen I see 3  window headers: menu bar, white window stripe and row with tabs. 
They overlap part of terminal with content of opened files etc. 
To get rid of the menu bar and window header I need to move cursor to the top edge of the screen. But it's a bad workaround since I want my hands be lying on keyboard.
Possible solution:
1) Do not show extra headers unless I do up-to-top mouse movement
2) Never show extra headers for iterm2 in fullscreen mode
3) When extra headers show up do not overlap text in terminal, but move it down (seems unlikely to be doable)


## Solution 1 (not working): always show menu bar

Open "System Preferences" -> "Dock & Menu Bar".
Check the option "Automatically hide and show the menu bar in full screen".

## Solution 2 (complex and annoying)

### Step 1. Switch iterm2 to 'non-native full-screen mode'
### Step 2. Add shortcut for switching to iterm2 window

```
It looks like the "Services" section may not be immediately visible in your Keyboard Shortcuts preferences. Here's how to ensure you find and configure the Service:

### Step-by-Step Guide to Assign a Shortcut to the Automator Service

#### Step 1: Ensure the Automator Service is Created Correctly

1. **Open Automator**:
   - Select "Quick Action" (formerly "Service").
   
2. **Configure the Quick Action**:
   - Set "Workflow receives" to "no input" in "any application".
   
3. **Add a Run AppleScript Action**:
   - In the Library on the left, select "Utilities" and drag "Run AppleScript" to the workflow area.
   - Enter the following AppleScript:
     ```applescript
     tell application "iTerm"
         activate
     end tell
     ```

4. **Save the Quick Action**:
   - Save the Quick Action with a name like "Switch to iTerm2".

#### Step 2: Assign a Keyboard Shortcut

1. **Open System Preferences**:
   - Go to "System Preferences" -> "Keyboard".

2. **Find the Services Menu**:
   - In the Keyboard Shortcuts preferences, select "App Shortcuts".
   - If you don’t see "Services" directly, you might need to scroll or look under different categories like "General" or "App Shortcuts".

3. **Add a New Shortcut**:
   - Click the "+" button to add a new shortcut.
   - Ensure "Application" is set to "All Applications".
   - For "Menu Title", enter the exact name of your saved Automator Quick Action, such as "Switch to iTerm2".
   - For "Keyboard Shortcut", click in the field and press the keyboard shortcut you want to use, such as `Cmd + Shift + I`.

4. **Save and Apply**:
   - Click "Add" to save the shortcut.
   - Close System Preferences.

### Testing the Shortcut

1. **Press the Assigned Shortcut** (e.g., `Cmd + Shift + I`).
2. **iTerm2 Should Activate**.

### Alternative Method Using Karabiner-Elements

If finding and setting up the Service in System Preferences remains difficult, you can use Karabiner-Elements to assign a custom shortcut:

1. **Open Karabiner-Elements**.
2. **Go to Complex Modifications**.
3. **Add Rule** -> **Import More Rules**.
4. **Create a Custom Rule** if necessary.
5. **Edit `karabiner.json`**:
   - Place the following configuration in the appropriate section of your `karabiner.json` file:
     ```json
     {
       "description": "Switch to iTerm2 with Cmd+Shift+I",
       "manipulators": [
         {
           "type": "basic",
           "from": {
             "modifiers": {
               "mandatory": [
                 "left_command",
                 "left_shift"
               ]
             },
             "key_code": "i"
           },
           "to": [
             {
               "shell_command": "open -a iTerm"
             }
           ]
         }
       ]
     }
     ```
6. **Save and Reload Karabiner-Elements**.

By following these steps, you should be able to set a global shortcut to switch directly to iTerm2. If you have any further questions or need additional assistance, please let me know!
```
