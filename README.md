VRtex Server
============

This server is the central brain of the VRtex team building suite. Various
clients will connect to the server via OSC and have their messages relayed
accordingly.

Installation
-----------

    bundle install

Usage
-----

    ruby server.rb [port]      # defaults to 4000

Contributing
------------

Code for interacting with a given client lives in the `app` directory. Please
see an example.

Credits
-------

Developed by team VRtex.
Powered by [osc-ruby](https://github.com/aberant/osc-ruby)
