# Pratkomat Bundle Script

This script will create a tar archive containing the java source files and any text files within the project folder.

Usage
-----------

The script should be invoked from within the project directory.

    /path/to/bundle.sh [<entry_point_file_name>]
    
If the file containing the entry point is called "Shell.java" the argument can be omitted.

After the script finished running the project directory should contain a "bundle.tar" file, that can then be uploaded to the Praktomat.
