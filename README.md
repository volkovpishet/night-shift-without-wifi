# macOS Nightshift without wifi

Script to setup launch agent to update macos `nightshift` schedule every day using provided location details (latitude and longitude)

I made it to suit my needs, but decided to share it.

## Why
Script may be useful for those who does not have working wifi on mac (`hackintosh` without working module 😌). Or for anyone who would like to setup `nightshift` schedule with different location.

## Prerequisites
`nightlight` utility should be installed. You can use brew for that 🍺

```
brew install smudge/smudge/nightlight
```
See original author repo for details: https://github.com/smudge/nightlight
<br/>
<br/>

## Usage
1. Clone or download the project to local directory
2. Open terminal in that directory
3. Copy config.example to config (without `.example` part)
```
cp config.example config
```
4. Update copied config with you location details 🌎
> You can use any service to find out your latitude and longitude, f.e. https://www.latlong.net 
5. make install.sh executable
```
chmod +x install.sh
```
6. Install it
```
./install.sh
```
7. Run it for the first time  and check nightshift settings  to see if it is working
```
launchctl start local.nightShiftWithoutWifi
```
<br/>

## Uninstall
1. make uninstall.sh executable
```
chmod +x uninstall.sh
```
2. Run it
```
./uninstall.sh
```

## How to contribute 🙌
If you like the project, please give it a star on GitHub. This will be a good marker to know that script was useful for someone. You can also share ideas or bug reports
