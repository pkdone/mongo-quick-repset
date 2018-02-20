# Very simple script to configure and run a simple MongoDB Replica Set on a single host machine/VM

## Pre-Requisites

*  Tested on Linux only (Ubuntu 16.04 x86-64 - other Linux variants should be fine). Mac OS X hosts may be ok too, but haven't tested.
*  Requires a version of MongoDB to already be installed on the local machine.

## Usage Steps

1.  In this root directory, modify the file 'generate.sh' and change the value of the variable MONGODB_BIN to reference the path of the MongoDB installation's 'bin' directory, on the local machine.

2.  From the terminal, run the following script to configure and run a "3-node" MongoDB Replica Set, running on the local host machine (each of the 3 replicas listens on a different local port):

    ```
    $ ./generate.sh
    ```

**NOTE**: Ensure the 'generate.sh' is executable first.

As the script is finishing it will print the command that can subsequently be executed to run the Mongo Shell against the new Replica Set.


