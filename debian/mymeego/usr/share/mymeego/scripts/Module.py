'''
Created on Dec 14, 2010

@group: RawDimension
'''

import dbus
from EventHandler import EventHandler,Event
from TransferList import TransferList
from Config import config
import threading

#test import
import time

class Module(threading.Thread):
    name = ""
    event_handler = None
    event = None
    def __init__(self,event_handler=None,name=""):
#        super(Module,self).__init__()
        self.name = name
        self.event_handler = event_handler
        threading.Thread.__init__(self)
    def copy(self, module):
        self.name = module.name
        self.event_handler = module.event_handler
#    def getName(self):
#        return self.name
#    def getEventHandler(self):
#        return self.event_handler
    def run(self):
        pass
    
class DbusModule(Module):
    service = ""
    path = ""
    interface = ""
    def __init__(self,event_handler=None,name="",service="",path="",interface=""):
        super(DbusModule,self).__init__(event_handler,name)
        self.service = service
        self.path = path
        self.interface = interface
    def copy(self,module):
        self.service = module.service
        self.path = module.path
        self.interface = module.interface
        Module.copy(self,module)
#    def dbusError(self,e):
#        print "A dbus exception occurred"
#        print "\t",str(e)
#    def dbusReply(self):
#        print "Got a reply from dbus"
    def run(self):
        print "forward event to dbus"
        try:
            # get proxy
            print "Get proxy. Service: ", self.service, ", Path: ",self.path
            proxy = dbus.SessionBus().get_object(self.service, self.path)
            
            # get interface
            print "Get interface: ",self.interface
            iface = dbus.Interface(proxy,self.interface)
            
            # send dbus event
            print "Send event:",self.event
#            iface.Event(event.getDeviceId(),event.getType(),event.getValue(),
#                        reply_handler=self.dbusReply, error_handler=self.dbusError)
            iface.Event(str(self.event.deviceId),str(self.event.type),str(self.event.value))
        except dbus.DBusException:
            print "Client application was not turned on"
        
class UpnpModule(Module):
    upnp = None
    def __init__(self,event_handler=None,name="",upnp=None):
        self.upnp = upnp
        super(UpnpModule,self).__init__(event_handler,name)
    def copy(self,module):
        self.upnp = module.upnp
        Module.copy(self, module)
    def run(self):
        # just print for now 
        print "UpNp"
        print self.event        
        
        #TODO: call self.upnp to make the tasks required.
        
        # TEST! transfer testing purposes
        if self.event.command == "TransferFiles":
            amount = len(self.event.value.file_list)
            for x in range(amount):
                self.event.command = "ReturnUiData"
                print "X:",x," Amount:",amount
                if x == amount-1:
                    print "Send Done"
                    self.event.value = "done"
                else:
                    self.event.value = "transferred:"+str(x)
                time.sleep(2)
                self.event_handler.handleEvent(self.event)
        elif self.event.command == "GetFileList":
            if config.fake_actions == True:
                # use faked actions
                self.event.command = "ReturnUiData"
                self.event.value = "../data/TestTransfer.xml"
                self.event_handler.handleEvent(self.event)
            else:
                #TODO:!!!
                pass
        # TEST end!
                
class WorkerModule(Module):
    def __init__(self,event_handler=None,name=""):
        super(WorkerModule,self).__init__(event_handler,name)
    def run(self):
        #print
        print "Worker module processing event"
        print self.event
        # process event
        if (self.event.command == "DataRequest"):
            # a data request from ui occurred
            if (self.event.type == "GetDeviceList"):
                #forward event to upnp module
                self.event.command = "GetDeviceList"
                self.event_handler.handleEvent(self.event)
            elif (self.event.type == "GetFileList"):
                #forward event to upnp module
                self.event.command = "GetFileList"
                self.event_handler.handleEvent(self.event)
            elif (self.event.type == "TransferFiles"):
                #forward event to upnp module
                self.event.command = "TransferFiles"
                #change the value format from string to TransferList class
                transfer = TransferList()
                transfer.importAsString(self.event.value)
                self.event.value = transfer
                self.event_handler.handleEvent(self.event)
            else:
                print "ERROR: no solutions found for command DataRequest"
        else:
            print "ERROR: no solutions found for event processing found."
        print "Worker module processed the event"
        
