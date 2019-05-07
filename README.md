Demo of deSEC's desec-stack hosted on desec.io
====

To run demos, setup an virtual environment and install the requirements:

    virtualenv -p python3 venv
    pip install -r requirements.txt
    source venv/bin/activate

Basic Demo
----

To run, an access token for the demo.dedyn.io domain is required.
Assuming my_token is your the access token, run the demo with

    source venv/bin/activate
    TOKEN=my_token doitlive play basic.sh 

Note that the demo is best run completely and uninterrupted,
otherwise future runs may be confused by existing/non-existing data on the server.

