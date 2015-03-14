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

To connect to the server from a client, send an OSC message to address
`/register/[ClientType]` where `[ClientType]` is the class name of a client in
`app/clients`. An example follows below:

    /register/QuickOsc # Registers a new client of type Clients::QuickOsc

Contributing
------------

Code for interacting with a given client lives in the `app/clients` directory.

All clients must inhereit from `Clients::Client` and implement the `bind`
method. See `Clients::QuickOsc` for an example of how to implement `bind`.

Credits
-------

Developed by team VRtex.
Powered by [osc-ruby](https://github.com/aberant/osc-ruby)
