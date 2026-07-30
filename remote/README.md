USE AT OWN RISK!

NOTE: Run on PC not on MiSTer.

# convertFromZipToCueToChdAndDelete.sh

Converts a folder of zipped cue/bin files into chd. place file into folder containing the zip files and run, warning does delete the originals! So backup or edit the script if not required.

Requires chdman, run `sudo dnf install chdman` if on a Fedora like system (eg Nobora) or `apt-get` on Debian etc.

place `convertFromZipToCueToChdAndDelete.sh` in the same folder as the zipped cue/bin files you wish to convert, then execute:
```
./convertFromZipToCueToChdAndDelete.sh
```

This process may take a long time if you have a lot of files or a weak processor, you can limit the batch size by adding a number as an arg eg `5` this will process 5 files then stop:
```
./convertFromZipToCueToChdAndDelete.sh 5
``` 

If you do not wish to delete the original zip files and unzipped cue/bin files add the arg `safe`:
```
./convertFromZipToCueToChdAndDelete.sh safe
```

Combine for a test run:
```
./convertFromZipToCueToChdAndDelete.sh safe 1
```
