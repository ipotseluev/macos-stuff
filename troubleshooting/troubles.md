## Ctrl-P problem

**Problem**
    You log into Docker container, press Ctrl-P and find out you need to press it twice every god damn time
**Solution (seems working)**

1. Open iTerm2 Preferences:
Open iTerm2 and go to Preferences (you can press Cmd + , or go to iTerm2 > Preferences from the menu bar).
2. Navigate to the “Keys” Tab:
In the Preferences window, select the Keys tab.
3. Add a New Key Binding:
Click the + button at the bottom of the key bindings list to add a new key binding.
4. Set the Shortcut and Action:
• In the Keyboard Shortcut field, press Ctrl + P to set the shortcut.
• In the Action dropdown menu, select Send Hex Code.
5. Enter the Hex Code for the Up Arrow Key:
In the Hex Code field, enter the hex code for the Up arrow key. The hex code for the Up arrow key is 0x1b 0x5b 0x41. Enter this code into the field.
6. Save the Key Binding:
Click OK to save the new key binding.

**Solution (not working)**
Add it to  ~/.docker/config.json

```
{
    "detachKeys": "ctrl-]"
}
```

## Shortcut for toggling mode for function keys

It works only for native keyboard. You can try to adapt it to bluetooth keyboard if you like.
[link](https://www.reddit.com/r/shortcuts/comments/17h8mmy/macos_sonoma_toggle_function_keys_f1f2)
