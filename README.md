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

The server essentially acts as a router between UE4 and other VRTEX devices.
Each device to be routed for must be specified with a ip/port in config.yml.
Upon declaration, the server will listen on the OSC address namespace
"/{device name}/.\*" and forward along messages to the corresponding devices.
Any message with an OSC address that doesn't correspond to a device name will
be dropped.

Credits
-------

Developed by team VRtex.
Powered by [osc-ruby](https://github.com/aberant/osc-ruby)
