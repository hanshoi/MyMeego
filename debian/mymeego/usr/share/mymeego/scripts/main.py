#!/usr/bin/python
'''
Created on Dec 14, 2010

@group: RawDimension
'''

import sys
import dbus
import gobject
import dbus.mainloop.glib
import signal

from Agent import Agent
from EventHandler import EventHandler, Command
from Module import DbusModule, UpnpModule, WorkerModule
from BackendUpnp import BackendUpnp
from Config import Config,config

def close(signal=None,frame=None):
    print "close application"
    event_handler.close()
    event_handler.join()
    upnp.close()
    print "application closed"
        
if __name__ == '__main__':       
    #init config file
    print "load global config file"
    if len(sys.argv) < 2:
        config.load("../conf/mymeego.conf")
    else:
        config.load(sys.argv[1])
    
    #init mainloop
    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
     
    # get session bus
    bus = dbus.SessionBus()
        
    mainloop = gobject.MainLoop()
    event_handler = EventHandler(mainloop)
    
    # init upnp ########
    configfile = config.coherence_conf
    if len(configfile) <= 0:
        sys.exit("no coherence config file specified in config or else")
    upnp = BackendUpnp(event_handler,configfile,config.device_name,config.device_type)
    # end upnp init ####
    
    # init closing signals
    signal.signal(signal.SIGINT,close)  # CTRL+C signal error
    signal.signal(signal.SIGQUIT,close)  # terminal quit
        
    # init modules
    dbus_module = DbusModule(event_handler,"dbus","org.mymeego.Ui","/org/mymeego/Ui","org.mymeego.Ui")
    upnp_module = UpnpModule(event_handler,"upnp",upnp)
    worker_module = WorkerModule(event_handler,"worker")
    
    ####################
    # INIT handlers
    ####################    
    #TODO: get the native path you are in currently and then the xml files from there...
    event_handler.addCommand(Command("ReturnUiData",dbus_module))
    event_handler.addCommand(Command("DataRequest",worker_module)) # this is the default command from UI
    event_handler.addCommand(Command("GetDeviceList",upnp_module))
    event_handler.addCommand(Command("GetFileList",upnp_module))
    event_handler.addCommand(Command("TransferFiles",upnp_module))
    ####################
    # stop handler init
    ####################
    
    # create agent
    print "create agent"
    agent = Agent(bus,"org.mymeego.Backend","/org/mymeego/Backend",event_handler)
    
    try:    
        # init mainloop
        print "init upnp mainloop"
        print "waiting for events"
        # blocks until completion
        upnp.run()
    except:
        close()
        print "Execution aborted"
    
    
    
