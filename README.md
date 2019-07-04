**Before running this script, make a backup of your screenshot directory. If all looks well, the backup may then be deleted. I am not responsible for any lost screenshots.**

# FFXIV_ScreenshotArchiver
Easily organize FFXIV screenshots in to folders by year and date to avoid the agonizing wait when loading directory in excess of 1,000 files.

Love taking screenshots? With time, you've likely amassed quite the collection. The problem though is when opening the screenshot directory, you've likely sat waiting for Windows to do its thing before files are sorted or thumbnails are shown. Sans technical explanation, this is quite the annoying behavior, especially when the directory is opened multiple times. This script will sort the screenshots in to folders organized by year and month thereby reducing the number of files having to be shown.

# To use
Download the Powershell script to a directory. Open Powershell, navigate to said directory, and run the following command:
```
.\FFXIV_Screenshot_Archiver.ps1
```
If your screenshot directory is not located in the default location of `C:\Users\username\Documents\My Games\FINAL FANTASY XIV - A Realm Reborn\screenshots`, you can specify it with the following command:
```
.\FFXIV_Screenshot_Archiver.ps1 -directory "C:\directory\to\screenshots"
```
To show the log file after script execution, append the `-showlog` parameter.

# Log output
Activity will be shown both in the console and written to a log file in `%temp%\FFXIV_ScreenshotArchiver.txt`. Below is a sample log:

```
2019-07-03_15:09:43|Beginning screenshot cleanup
2019-07-03_15:09:43|    Screenshot folder: 'C:\Users\username\Documents\My Games\FINAL FANTASY XIV - A Realm Reborn\screenshots'
2019-07-03_15:09:44|There are 651 files to be archived...
2019-07-03_15:09:44|    Moving image 'ffxiv_11242016_221405.png' to folder '\2016-11'
2019-07-03_15:09:44|    Moving image 'ffxiv_12032016_234223.png' to folder '\2016-12'
2019-07-03_15:09:44|    Moving image 'ffxiv_12042016_220057.png' to folder '\2016-12'
2019-07-03_15:09:44|    Moving image 'ffxiv_12042016_231535.png' to folder '\2016-12'
2019-07-03_15:09:44|    Moving image 'ffxiv_12302016_024654.png' to folder '\2016-12'
[...]
2019-07-03_15:09:46|    Moving image 'ffxiv_dx11 2019-02-24 22-41-10.png' to folder '\2019-02'
2019-07-03_15:09:46|    Moving image 'ffxiv_dx11 2019-02-25 22-18-00.png' to folder '\2019-02'
2019-07-03_15:09:46|    Moving image 'ffxiv_dx11 2019-02-25 22-18-29.png' to folder '\2019-02'
2019-07-03_15:09:46|    Moving image 'ffxiv_dx11 2019-02-26 23-31-44.png' to folder '\2019-02'
2019-07-03_15:09:53|Cleanup complete!
```

Once script has finished, the directory tree will look similar to the following:

```
C:\USERS\USERNAME\DOCUMENTS\MY GAMES\FINAL FANTASY XIV - A REALM REBORN\SCREENSHOTS
├───2016-11
│       ffxiv_11242016_221405.png
│
├───2016-12
│       ffxiv_12032016_234223.png
│       ffxiv_12042016_220057.png
│       ffxiv_12042016_231535.png
│       ffxiv_12302016_024654.png
│
├───2017-01
│       ffxiv_01122017_235420.png
│       ffxiv_01122017_235452.png
│       ffxiv_01132017_000112.png
│       ffxiv_01132017_000318.png
│       ffxiv_01292017_014203.png
│
├───2017-03
│       ffxiv_03022017_213117.png
│       ffxiv_03022017_213131.png
│       ffxiv_03022017_213159.png
│       ffxiv_03022017_213212.png
│       ffxiv_03022017_213842.png
│       ffxiv_03022017_213847.png
│       ffxiv_03022017_213915.png
```