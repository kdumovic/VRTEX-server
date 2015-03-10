require "application"

@client = OSC::Client.new('localhost', 4000)
@client.send(OSC::Message.new("/greeting" , "Hello World!"))
