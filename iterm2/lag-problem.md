## Problem description
On macbook pro (with discrete GPU) CLI commands output occasionally lags.
[problem](https://apple.stackexchange.com/questions/411232/big-sur-terminal-sometimes-5-second-lag-16in-macbook-pro?newreg=1cf3b523031445ab9417e371464b568b)

## Solution

### For energy socket plugged-in mode only:
Preferences -> General -> Magic
v GPU rendering
Advanced GPU Settings...
v Disable GPU rendered when disconnected from power
v Maximize throughput
  Prefer integrated to discrete GPU

### Include workaround for battery mode:
  Disable GPU rendered when disconnected from power
v Maximize throughput
  Prefer integrated to discrete GPU
