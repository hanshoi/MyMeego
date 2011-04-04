'''
Created on Dec 14, 2010

@group: RawDimension
'''

import dbus
import dbus.service
from EventHandler import EventHandler,Event

class Agent(dbus.service.Object):
    def __init__(self,bus,name,path,event_handler):
        self._eventhandler = event_handler
        #register service name
        bus_name = dbus.service.BusName(name,bus)
        print "Register servicename: "+name
        #call parent
        dbus.service.Object.__init__(self, bus, path, bus_name)
    
    @dbus.service.method("org.mymeego.Backend",in_signature="sss",out_signature="")
    def transferData(self,device_id,type,value):
        print "TransfertData: \ndeviceId: " + str(device_id) +"\ntype: "+ type + "\nValue: " + str(value) +"\n\n"
        self._eventhandler.handleEvent(Event("DataRequest",device_id,type,value))