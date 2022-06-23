## coping through ssh and pbcopy:
host: create ssh tunnel
    ssh -nNT -R 9222:localhost:22 sam@dcc-ipotceluev-01

client: connect to host through tunnel
    ssh -p 9222 sam@localhost


## Way 2: Using services:
https://gist.github.com/jclosure/19698429dda1105b8a93b0832c07ebc7

```macos: ~/Library/LaunchAgents/pbcopy.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>localhost.pbcopy</string>
	<key>ProgramArguments</key>
	<array>
	    <string>/bin/sh</string>
	    <string>-c</string>
	    <string>LC_CTYPE=en_US.UTF-8 pbcopy</string>
	</array>
	<key>Sockets</key>
	<dict>
	    <key>Listeners</key>
	    <dict>
		<key>SockNodeName</key>
		<string>127.0.0.1</string>
		<key>SockServiceName</key>
		<string>2224</string>
	    </dict>
	</dict>
	<key>inetdCompatibility</key>
	<dict>
	    <key>Wait</key>
	    <false/>
	</dict>
    </dict>
</plist>
```

```macos ~/Library/LaunchAgents/pbpaste.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
	<key>Label</key>
	<string>localhost.pbpaste</string>
	<key>ProgramArguments</key>
	<array>
	    <string>/bin/sh</string>
	    <string>-c</string>
	    <string>LC_CTYPE=en_US.UTF-8 pbpaste</string>
	</array>
	<key>Sockets</key>
	<dict>
	    <key>Listeners</key>
	    <dict>
		<key>SockNodeName</key>
		<string>127.0.0.1</string>
		<key>SockServiceName</key>
		<string>2225</string>
	    </dict>
	</dict>
	<key>inetdCompatibility</key>
	<dict>
	    <key>Wait</key>
	    <false/>
	</dict>
    </dict>
</plist>
```

```macos: ~/.ssh/config
Host *
  RemoteForward 2224 localhost:2224
  RemoteForward 2225 localhost:2225
```

```sh macos
launchctl load ~/Library/LaunchAgents/pbcopy.plist
launchctl load ~/Library/LaunchAgents/pbpaste.plist
launchctl start ~/Library/LaunchAgents/pbcopy.plist
launchctl start ~/Library/LaunchAgents/pbpaste.plist
```

```sh Linux test
echo testing | nc -w0 localhost 2224
```

```Linux: ~/.zshrc
alias pbcopy="nc -w0 localhost 2224"
```

```Linux: ~/.tmux.conf
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'nc -w0 localhost 2224'
```
